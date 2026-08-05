import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
      body: Stack(
        children: [
          // Background subtle Mint Glow
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mintGreen.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mintGreen.withValues(alpha: 0.08),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Spacer / Alignment
                  const SizedBox(height: 10),

                  // Linux Mint Desktop-like Window Card
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
                              // Window Buttons (Linux Mint style: Left side / Right side)
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF5F56), // Red
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFBD2E), // Yellow
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF27C93F), // Green
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                'Linux Mint - Welcome Assistant',
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
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                          child: Column(
                            children: [
                              // Linux Mint Stylized Leaf Logo
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: mintDarkBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: mintGreen, width: 2.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: mintGreen.withValues(alpha: 0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.eco_rounded,
                                      size: 70,
                                      color: mintGreen,
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: mintDarkBackground,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: mintGreen, width: 1),
                                        ),
                                        child: const Text(
                                          'LM',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Header Title
                              const Text(
                                'Shopif',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // OS/App Subtitle
                              Text(
                                'ระบบจัดการร้านค้าและอัพเดทสินค้า',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade400,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 35),

                              // Action Buttons
                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mintGreen,
                                    foregroundColor: Colors.black,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                                    );
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.login_rounded, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'เข้าสู่ระบบ (Sign In)',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Register Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: mintGreen.withValues(alpha: 0.8), width: 1.5),
                                    foregroundColor: mintGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                    );
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person_add_alt_1_rounded, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'ลงทะเบียน (Register)',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Linux Mint Style Bottom Desktop Panel/Taskbar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: mintDarkPanel,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: mintBorderColor, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left: Mint Logo / Start Menu
                        Row(
                          children: [
                            Icon(Icons.eco, color: mintGreen, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Menu',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        // Middle: System status or active window
                        const Text(
                          'Welcome Screen',
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                        // Right: Desktop Icons (battery, wifi, time)
                        Row(
                          children: [
                            const Icon(Icons.wifi, color: Colors.white70, size: 16),
                            const SizedBox(width: 10),
                            const Icon(Icons.battery_std, color: Colors.white70, size: 16),
                            const SizedBox(width: 12),
                            Text(
                              TimeOfDay.now().format(context),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}