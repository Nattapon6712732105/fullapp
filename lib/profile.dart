import 'dart:ui';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/img/mymint.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Dark Dim Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.45),
            ),
          ),
          // Scrollable Profile Container
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Glassmorphic Card Container
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Circular Avatar image
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white.withValues(alpha: 0.15),
                              backgroundImage: const AssetImage('assets/img/myface.jpeg'),
                            ),
                            const SizedBox(height: 16),
                            // Profile Name
                            const Text(
                              'Natthaphon Boonnara',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Profile Description
                            const Text(
                              'นักศึกษาสาขาวิทยาการคอมพิวเตอร์',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Colors.white24, thickness: 1),
                            const SizedBox(height: 20),
                            // Profile Details
                            const _ProfileInfoRow(
                              icon: Icons.badge_outlined,
                              title: 'Student ID',
                              value: '65xxxxxxxxx',
                            ),
                            const SizedBox(height: 16),
                            const _ProfileInfoRow(
                              icon: Icons.email_outlined,
                              title: 'Email',
                              value: 'natthaphon@example.com',
                            ),
                            const SizedBox(height: 16),
                            const _ProfileInfoRow(
                              icon: Icons.school_outlined,
                              title: 'Major',
                              value: 'Computer Science',
                            ),
                            const SizedBox(height: 16),
                            const _ProfileInfoRow(
                              icon: Icons.phone_android_outlined,
                              title: 'Phone',
                              value: '+66 xx-xxx-xxxx',
                            ),
                            const SizedBox(height: 16),
                            const _ProfileInfoRow(
                              icon: Icons.location_on_outlined,
                              title: 'Location',
                              value: 'Khon Kaen, Thailand',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileInfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12, width: 1),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
