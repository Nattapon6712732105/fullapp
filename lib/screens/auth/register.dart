import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopf/helpers/db_helper.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final DBHelper _dbHelper = DBHelper();

  Future<void> _handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'กรุณากรอกข้อมูลให้ครบถ้วน',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    final lowercaseCount = RegExp(r'[a-z]').allMatches(password).length;
    final uppercaseCount = RegExp(r'[A-Z]').allMatches(password).length;

    if (password.length < 8 || lowercaseCount < 2 || uppercaseCount < 1) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร และต้องประกอบด้วยตัวอักษรตัวเล็กอย่างน้อย 2 ตัว และตัวใหญ่อย่างน้อย 1 ตัว',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await _dbHelper.registerUser(email, password);

      if (success) {
        Get.snackbar(
          'สำเร็จ',
          'สมัครสมาชิกสำเร็จ กรุณาลงชื่อเข้าใช้งาน',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF87CF3E),
          colorText: Colors.black,
        );
        // Go to Login Screen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        Get.snackbar(
          'ข้อผิดพลาด',
          'อีเมลนี้ถูกใช้งานไปแล้ว หรือระบบฐานข้อมูลมีข้อผิดพลาด',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'ข้อผิดพลาดระบบ',
        'ไม่สามารถเชื่อมต่อฐานข้อมูลได้: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Linux Mint Palette
    final Color mintGreen = const Color(0xFF87CF3E);
    final Color mintDarkPanel = const Color(0xFF2F2F2F);
    final Color mintDarkBackground = const Color(0xFF151515);
    final Color mintWindowHeader = const Color(0xFF383838);
    final Color mintBorderColor = const Color(0xFF454545);

    return Scaffold(
      backgroundColor: mintDarkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: mintGreen),
        title: const Text(
          'Register Screen',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Linux Mint Register Window Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mintDarkPanel,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mintBorderColor, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mint OS Window Title Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: mintWindowHeader,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        border: Border(
                          bottom: BorderSide(color: mintBorderColor, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF5F56),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFBD2E),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFF27C93F),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'Linux Mint - Create User Wizard',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Window Content
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 60,
                            color: mintGreen,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'สร้างบัญชีผู้ประกอบการใหม่',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'กรอกรายละเอียดบัญชีด้านล่าง',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Email Input field
                          TextField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined, color: mintGreen),
                              hintText: 'อีเมล / Email',
                              hintStyle: const TextStyle(color: Colors.white38),
                              filled: true,
                              fillColor: mintDarkBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: mintBorderColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: mintGreen, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password Input field
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded, color: mintGreen),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: mintGreen,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              hintText: 'รหัสผ่าน / Password',
                              hintStyle: const TextStyle(color: Colors.white38),
                              filled: true,
                              fillColor: mintDarkBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: mintBorderColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: mintGreen, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password Input field
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_clock_outlined, color: mintGreen),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                                  color: mintGreen,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              hintText: 'ยืนยันรหัสผ่าน / Confirm Password',
                              hintStyle: const TextStyle(color: Colors.white38),
                              filled: true,
                              fillColor: mintDarkBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: mintBorderColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: mintGreen, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mintGreen,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: _isLoading ? null : _handleRegister,
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.black)
                                  : const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.person_add_rounded, size: 18),
                                        SizedBox(width: 8),
                                        Text(
                                          'ลงทะเบียนผู้ใช้งาน',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Back Link
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Text(
                              'มีบัญชีผู้ใช้งานอยู่แล้ว ? ลงชื่อเข้าใช้',
                              style: TextStyle(color: mintGreen, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}