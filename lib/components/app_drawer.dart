import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopf/minigame.dart' show MiniGamePage;
import 'package:shopf/profile.dart';
import 'package:shopf/homeapp.dart';
import 'package:shopf/my_home_page.dart';
import 'package:shopf/้history.dart';
import 'package:shopf/helpers/db_helper.dart';

// Import หน้า Auth เพิ่มเติม
import 'package:shopf/screens/auth/welcome.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF121218),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Premium Gradient Header
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1B5E20),
                  Color(0xFF2E7D32),
                  Color(0xFF43A047),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  backgroundImage: const AssetImage('assets/img/myface.jpeg'),
                ),
                const SizedBox(height: 12),
                // Name
                const Text(
                  'Natthaphon Boonnara',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                // Subtitle
                Text(
                  'รายละเอียดโปรไฟล์',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Menu Items
          _DrawerItem(
            icon: Icons.dashboard_rounded,
            label: 'My Page',
            onTap: () {
              Navigator.pop(context);
              Get.offAll(() => const MyHomePage(title: 'Shopf Home'));
            },
          ),
          _DrawerItem(
            icon: Icons.compare_rounded,
            label: 'Docs',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const HomeApp());
            },
          ),
          _DrawerItem(
            icon: Icons.person_rounded,
            label: 'Profile',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const Profile());
            },
          ),
          _DrawerItem(
            icon: Icons.history_rounded,
            label: 'History',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const History());
            },
          ),
          _DrawerItem(
            icon: Icons.games_rounded,
            label: 'Mini Game',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const MiniGamePage());
            },
          ),
          
          // 🔴 เมนูออกจากระบบ (Logout)
          _DrawerItem(
            icon: Icons.logout_rounded,
            label: 'ออกจากระบบ',
            onTap: () async {
              Navigator.pop(context);
              await DBHelper().logout();
              Get.offAll(() => const WelcomeScreen());
            },
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(color: Colors.white.withValues(alpha: 0.08)),
          ),
          // Footer info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Text(
              'Shopf App v1.0.0',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.2),
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon, color: Colors.white70, size: 22),
        title: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        hoverColor: Colors.white.withValues(alpha: 0.05),
        splashColor: Colors.white.withValues(alpha: 0.08),
      ),
    );
  }
}