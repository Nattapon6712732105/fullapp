import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;
  static Future<Database>? _databaseFuture;

  Future<Database> get database async {
    if (_database != null) return _database!;
    if (_databaseFuture == null) {
      _databaseFuture = _initDatabase().catchError((error) {
        _databaseFuture = null;
        throw error;
      });
    }
    _database = await _databaseFuture!;
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final pathString = join(dbPath, 'app_auth.db');

    return await openDatabase(
      pathString,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE session (
            id INTEGER PRIMARY KEY,
            email TEXT,
            is_logged_in INTEGER DEFAULT 0
          )
        ''');
        // Insert initial empty session
        await db.insert('session', {'id': 1, 'email': '', 'is_logged_in': 0});
      },
    );
  }

  // Register user
  Future<bool> registerUser(String email, String password) async {
    final db = await database;
    try {
      await db.insert(
        'users',
        {
          'email': email.trim().toLowerCase(),
          'password': password,
        },
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return true;
    } catch (e) {
      return false; // Email already exists or other error
    }
  }

  // Check login credentials
  Future<bool> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email.trim().toLowerCase(), password],
    );

    if (maps.isNotEmpty) {
      // Set active session
      await db.update(
        'session',
        {
          'email': email.trim().toLowerCase(),
          'is_logged_in': 1,
        },
        where: 'id = ?',
        whereArgs: [1],
      );
      return true;
    }
    return false;
  }

  // Get log in status
  Future<bool> isLoggedIn() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'session',
      where: 'id = ?',
      whereArgs: [1],
    );

    if (maps.isNotEmpty) {
      return maps.first['is_logged_in'] == 1;
    }
    return false;
  }

  // Get current logged-in user email
  Future<String?> getCurrentUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'session',
      where: 'id = ?',
      whereArgs: [1],
    );

    if (maps.isNotEmpty && maps.first['is_logged_in'] == 1) {
      return maps.first['email'] as String?;
    }
    return null;
  }

  // Logout
  Future<void> logout() async {
    final db = await database;
    await db.update(
      'session',
      {
        'email': '',
        'is_logged_in': 0,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
