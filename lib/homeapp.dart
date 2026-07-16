import 'package:flutter/material.dart';
import 'package:shopf/components/app_drawer.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  // Dialog showing general stats for Windows 11
  void _showWindowsGeneral(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.window, color: Colors.blue, size: 28),
            SizedBox(width: 8),
            Text(
              'Windows 11 Overview',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Windows 11 is Microsoft\'s latest proprietary operating system. It features a modern Fluent Design language, deep integration with Microsoft 365, and excellent consumer software support.',
                style: TextStyle(color: Colors.white70, height: 1.4),
              ),
              SizedBox(height: 16),
              Text(
                'Key Capabilities:',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 6),
              Text('• Native WSL (Windows Subsystem for Linux)\n• DirectX 12 Ultimate & Auto HDR for gaming\n• Broad commercial software compatibility (Adobe, Office, etc.)\n• Massive driver support out of the box',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // Dialog showing general stats for Linux Mint
  void _showLinuxMintGeneral(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.eco, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text(
              'Linux Mint Overview',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Linux Mint is a free, open-source community-driven operating system based on Ubuntu/Debian. It aims to provide a classic desktop experience (Cinnamon) that is highly user-friendly and stable.',
                style: TextStyle(color: Colors.white70, height: 1.4),
              ),
              SizedBox(height: 16),
              Text(
                'Key Capabilities:',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 6),
              Text('• Full customization of GUI panels and themes\n• Lightweight Cinnamon desktop (runs great on older PCs)\n• Software Manager with Flatpak & APT access\n• Zero built-in telemetry or forced updates',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  // Dialog showing details comparison of subtopics
  void _showTopicDetail(BuildContext context, String title, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B1B22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Windows Card Comparison
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.window, color: Colors.blue, size: 20),
                          SizedBox(width: 8),
                          Text('Windows 11', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Pros: ${data['win_pros']}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('Cons: ${data['win_cons']}', style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 4),
                      Text('Capabilities: ${data['win_caps']}', style: const TextStyle(color: Colors.blueAccent)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Linux Mint Card Comparison
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.eco, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          Text('Linux Mint', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Pros: ${data['mint_pros']}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('Cons: ${data['mint_cons']}', style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 4),
                      Text('Capabilities: ${data['mint_caps']}', style: const TextStyle(color: Colors.greenAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dataset for comparisons
    final List<Map<String, dynamic>> comparisonTopics = [
      {
        'title': 'Performance & Hardware',
        'subtitle': 'System resource usage and specifications',
        'icon': Icons.speed,
        'win_pros': 'Excellent DirectX performance, advanced graphic pipeline features (Auto HDR).',
        'win_cons': 'High CPU/RAM idle usage, demands modern CPU, TPM 2.0, Secure Boot.',
        'win_caps': 'Drives heavy workloads natively; optimized for multi-core latest chipsets.',
        'mint_pros': 'Runs at less than 1GB idle RAM, revives old laptops/desktops, zero overhead.',
        'mint_cons': 'Sometimes lacks modern power management out-of-the-box (requires kernel tweaking).',
        'mint_caps': 'Ultra-efficient scheduler, lightweight window managers (Cinnamon, XFCE).'
      },
      {
        'title': 'Privacy & Telemetry',
        'subtitle': 'User data collection and forced schedules',
        'icon': Icons.security,
        'win_pros': 'Offers cloud diagnostic sync for automatic crash troubleshooting.',
        'win_cons': 'Extensive analytics gathered by default, mandatory cloud accounts, advertising in OS.',
        'win_caps': 'Active cloud syncing and AI analytics (Copilot integrations).',
        'mint_pros': 'No tracking, zero telemetry, local profiles only, full privacy guarantees.',
        'mint_cons': 'No central automatic system health cloud analytics/reporting.',
        'mint_caps': 'Privacy-first computing, complete control over what gets sent or stored.'
      },
      {
        'title': 'Software & Gaming',
        'subtitle': 'Application coverage and hardware compatibility',
        'icon': Icons.sports_esports,
        'win_pros': 'Native support for Adobe Creative Cloud, MS Office, and all major AAA games.',
        'win_cons': 'System can get bloated over time due to installer residues.',
        'win_caps': 'Unrivaled game libraries via Steam, Xbox App, and proprietary graphic APIs.',
        'mint_pros': 'Central Software Manager, Flatpak/APT store, easy updates.',
        'mint_cons': 'No native MS Office or Adobe Suite support (must use alternatives or Wine/VMs).',
        'mint_caps': 'Steam Proton allows running ~80% of Windows games, excellent FOSS software library.'
      },
      {
        'title': 'Developer Environment',
        'subtitle': 'Compiling, coding toolchains and CLI utility',
        'icon': Icons.code,
        'win_pros': 'WSL 2 offers full Linux shell; VS Code and Visual Studio run extremely well.',
        'win_cons': 'Configuring environment variables and POSIX paths natively can be tedious.',
        'win_caps': 'Great hybrid environment using WSL to run server architectures locally.',
        'mint_pros': 'Native bash terminal, pre-installed Python/Git/GCC toolchains, Docker runs natively.',
        'mint_cons': 'Certain proprietary SDKs/tools (like iOS Xcode or MS SQL native UI) are limited.',
        'mint_caps': 'Excellent for web, backend, and open-source systems programming.'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121216),
      appBar: AppBar(
        title: const Text(
          'OS Academic Comparison',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B1B22),
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Description Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.withValues(alpha: 0.15), Colors.green.withValues(alpha: 0.15)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Academic Dual-Boot Study',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'An in-depth analysis of Windows 11 & Linux Mint desktop architectures. Select an OS card below to explore general specs, or tap the list items to review detailed comparisons.',
                      style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // GridView for OS selection (Windows / Linux Mint)
              const Text(
                'Select Operating System',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  // Windows 11 Card
                  InkWell(
                    onTap: () => _showWindowsGeneral(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1B22),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.window, size: 48, color: Colors.blue),
                          SizedBox(height: 12),
                          Text(
                            'Windows 11',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('Fluent & Commercial', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  // Linux Mint Card
                  InkWell(
                    onTap: () => _showLinuxMintGeneral(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1B22),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.withValues(alpha: 0.3), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.eco, size: 48, color: Colors.green),
                          SizedBox(height: 12),
                          Text(
                            'Linux Mint',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('FOSS & Lightweight', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              // ListView of Comparative Topics
              const Text(
                'Architectural Comparisons',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comparisonTopics.length,
                itemBuilder: (context, index) {
                  final topic = comparisonTopics[index];
                  return Card(
                    color: const Color(0xFF1B1B22),
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.05),
                        child: Icon(topic['icon'], color: Colors.white70),
                      ),
                      title: Text(
                        topic['title'],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        topic['subtitle'],
                        style: const TextStyle(color: Colors.white30, fontSize: 12),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 16),
                      onTap: () => _showTopicDetail(context, topic['title'], topic),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
