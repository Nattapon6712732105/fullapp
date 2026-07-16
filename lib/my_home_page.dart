import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopf/components/app_drawer.dart';
import 'package:shopf/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/img/myface.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Dark Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Custom Drawer Menu Button (Top Left)
          Positioned(
            top: 50,
            left: 16,
            child: Builder(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
          ),
          // Content Layout
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  // Name Header
                  const Text(
                    'Natthaphon Boonnara',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Subtitle
                  const Text(
                    'นักศึกษาสาขาวิทยาการคอมพิวเตอร์',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Go to Profile Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => const Profile());
                      },
                      icon: const Icon(Icons.person, color: Colors.white),
                      label: const Text(
                        'Go to profile',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.white30, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Social Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SocialButton(
                        icon: Icons.email,
                        label: 'Email',
                        onTap: () {
                          Get.snackbar(
                            'Email Contact',
                            'natthaphon@example.com',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white.withValues(alpha: 0.95),
                            colorText: Colors.black87,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 16,
                          );
                        },
                      ),
                      _SocialButton(
                        icon: Icons.phone,
                        label: 'Phone',
                        onTap: () {
                          Get.snackbar(
                            'Phone Contact',
                            '+66 xx-xxx-xxxx',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white.withValues(alpha: 0.95),
                            colorText: Colors.black87,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 16,
                          );
                        },
                      ),
                      _SocialButton(
                        icon: Icons.code,
                        label: 'GitHub',
                        onTap: () {
                          Get.snackbar(
                            'GitHub Profile',
                            'github.com/natthaphon',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white.withValues(alpha: 0.95),
                            colorText: Colors.black87,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 16,
                          );
                        },
                      ),
                      _SocialButton(
                        icon: Icons.facebook,
                        label: 'Facebook',
                        onTap: () {
                          Get.snackbar(
                            'Facebook Profile',
                            'facebook.com/natthaphon',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white.withValues(alpha: 0.95),
                            colorText: Colors.black87,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 16,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white30, width: 1),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
