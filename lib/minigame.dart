import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopf/components/app_drawer.dart';

// --- โมเดลข้อมูลสำหรับประวัติการรับเหรียญ ---
class RewardLog {
  final String title;
  final int coins;
  final DateTime time;

  RewardLog({required this.title, required this.coins, required this.time});
}

// --- โมเดลข้อมูลสำหรับสถานะฟีเจอร์ใน Grid ---
class FeatureStatus {
  final String name;
  var isUnlocked = false.obs;
  var useCount = 0.obs;

  FeatureStatus({required this.name});
}

// --- GetX Controller จัดการ State ข้อมูลและการสุ่ม ---
class MiniGameController extends GetxController {
  var osUsageHours = 14.5.obs; 
  var osName = "Linux Mint".obs;
  var totalCoins = 100.obs;
  
  var currentFeature = "ยังไม่ได้สุ่มฟีเจอร์".obs;
  var isSpanning = false.obs;

  // รายการล็อกประวัติ (เก็บในรูป RxList เพื่ออัปเดตอัตโนมัติแบบ Reactive)
  var rewardLogs = <RewardLog>[].obs;

  // รายการสถานะฟีเจอร์ในระบบ Grid
  var gridFeatures = <FeatureStatus>[
    FeatureStatus(name: "Terminal Update"),
    FeatureStatus(name: "Package Cache"),
    FeatureStatus(name: "Compile Source"),
    FeatureStatus(name: "L3 Cache Tune"),
    FeatureStatus(name: "Kernel Tweak"),
    FeatureStatus(name: "Docker Container"),
    FeatureStatus(name: "Git Workflow"),
    FeatureStatus(name: "Bash Script"),
  ].obs;

  // รายการคำอธิบายเต็มเวลาสุ่มได้
  final List<String> osFeatures = [
    "Update System via Terminal",
    "Clean Package Cache",
    "Compile Source Code",
    "Optimize L3 Cache Tuning",
    "Kernel Tweaking",
    "Docker Container Up",
    "Git Commit & Push",
    "Bash Script Automation",
  ];

  void spinFeature() async {
    if (isSpanning.value) return;
    
    isSpanning.value = true;
    currentFeature.value = "กำลังประมวลผลระบบ...";
    
    await Future.delayed(const Duration(milliseconds: 1200));
    
    final random = Random();
    int featureIndex = random.nextInt(osFeatures.length);
    String selectedFeature = osFeatures[featureIndex];
    currentFeature.value = selectedFeature;
    
    int reward = random.nextInt(41) + 10;
    totalCoins.value += reward;

    // อัปเดตข้อมูลใน Grid (จับคู่ตาม Index ของข้อมูล)
    if (featureIndex < gridFeatures.length) {
      gridFeatures[featureIndex].isUnlocked.value = true;
      gridFeatures[featureIndex].useCount.value += 1;
    }

    // เพิ่มข้อมูลลงใน List ประวัติ (แทรกไว้บนสุด)
    rewardLogs.insert(
      0, 
      RewardLog(title: selectedFeature, coins: reward, time: DateTime.now())
    );
    
    isSpanning.value = false;

    Get.snackbar(
      'สุ่มฟีเจอร์สำเร็จ!',
      'ใช้งาน $selectedFeature รับไปเลย $reward เหรียญ! 🪙',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      colorText: const Color(0xFF1B5E20),
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.monetization_on, color: Colors.amber, size: 24),
      borderColor: const Color(0xFF1B5E20).withValues(alpha: 0.3),
      borderWidth: 1,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
    );
  }
}
// --- หน้า UI ของมินิเกม ---
class MiniGamePage extends StatelessWidget {
  const MiniGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MiniGameController controller = Get.put(MiniGameController());

    const Color primaryGreen = Color(0xFF1B5E20);
    const Color secondaryGreen = Color(0xFF43A047);
    const Color backgroundColor = Color(0xFFF8FBF8);
    const Color cardColor = Colors.white;
    const Color textColor = Color(0xFF212121);
    const Color subtitleColor = Color(0xFF757575);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'OS Stat & Mini Game',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            letterSpacing: 0.5
          ),
        ),
        backgroundColor: primaryGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Obx(() => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryGreen.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${controller.totalCoins.value} GP',
                      style: const TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- ส่วนที่ 1: การ์ดแสดงแสตทชั่วโมงการใช้งาน OS ---
            const Text(
              'OS SYSTEM STATUS',
              style: TextStyle(
                color: subtitleColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryGreen.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.terminal_rounded, color: primaryGreen, size: 36),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              controller.osName.value,
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(height: 6),
                        Obx(() => Text(
                              'ใช้งานไปแล้ว: ${controller.osUsageHours.value} ชั่วโมง',
                              style: const TextStyle(
                                color: subtitleColor,
                                fontSize: 15,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 36),

            // --- ส่วนที่ 2: โซนฟีเจอร์มินิเกมสำหรับรับเหรียญ ---
            const Text(
              'FEATURE REWARD MINI GAME',
              style: TextStyle(
                color: subtitleColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'เสี่ยงดวงเปิดใช้งานฟีเจอร์เพื่อรับ Coin',
                    style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 28),
                  
                  Obx(() => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: controller.isSpanning.value 
                                ? Colors.blue.withValues(alpha: 0.5)
                                : secondaryGreen.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          controller.currentFeature.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: controller.isSpanning.value 
                                ? Colors.blue
                                : primaryGreen,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Courier',
                            letterSpacing: 0.5,
                          ),
                        ),
                      )),
                  
                  const SizedBox(height: 36),
                  
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: controller.isSpanning.value
                              ? null
                              : () => controller.spinFeature(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryGreen,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey[300],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: controller.isSpanning.value
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.casino_rounded, size: 24),
                                    SizedBox(width: 12),
                                    Text(
                                      'สุ่มฟีเจอร์รับเหรียญ',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 36),

            // --- ส่วนที่ 3: GRID แสดงรายการฟีเจอร์และจำนวนครั้งที่เปิดสุ่ม ---
            const Text(
              'FEATURE UNLOCKED SYSTEM (GRID)',
              style: TextStyle(
                color: subtitleColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // แบ่งช่องตารางเป็น 2 ฝั่งซ้ายขวา
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5, // สัดส่วนการ์ดแนวนอน
                  ),
                  itemCount: controller.gridFeatures.length,
                  itemBuilder: (context, index) {
                    final feature = controller.gridFeatures[index];
                    return Obx(() => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: feature.isUnlocked.value 
                                ? primaryGreen.withValues(alpha: 0.05) 
                                : cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: feature.isUnlocked.value 
                                  ? primaryGreen.withValues(alpha: 0.3) 
                                  : Colors.black.withValues(alpha: 0.05)
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                feature.isUnlocked.value ? Icons.check_circle : Icons.lock_outline,
                                color: feature.isUnlocked.value ? secondaryGreen : subtitleColor,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      feature.name,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: feature.isUnlocked.value ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 13,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (feature.isUnlocked.value)
                                      Text(
                                        'เปิดแล้ว: ${feature.useCount.value} ครั้ง',
                                        style: const TextStyle(color: secondaryGreen, fontSize: 11),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                  },
                )),

            const SizedBox(height: 36),

            // --- ส่วนที่ 4: LIST แสดงล็อกประวัติการรับรางวัลล่าสุด ---
            const Text(
              'REWARD HISTORY LOGS (LIST)',
              style: TextStyle(
                color: subtitleColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => controller.rewardLogs.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                    ),
                    child: const Text(
                      'ยังไม่มีประวัติการรับเหรียญในรอบนี้',
                      style: TextStyle(color: subtitleColor),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.rewardLogs.length,
                    itemBuilder: (context, index) {
                      final log = controller.rewardLogs[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.monetization_on, color: Colors.amber),
                          ),
                          title: Text(
                            log.title,
                            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          subtitle: Text(
                            'เมื่อเวลา ${log.time.hour.toString().padLeft(2, '0')}:${log.time.minute.toString().padLeft(2, '0')}:${log.time.second.toString().padLeft(2, '0')} น.',
                            style: const TextStyle(color: subtitleColor, fontSize: 12),
                          ),
                          trailing: Text(
                            '+${log.coins} GP',
                            style: const TextStyle(color: secondaryGreen, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      );
                    },
                  )),
          ],
        ),
      ),
    );
  }
}