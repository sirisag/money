import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart';
// Import AppRoutes to navigate to other treasurer features
import 'package:money/core/navigation/app_router.dart';

class TreasurerDashboardScreen extends ConsumerWidget {
  const TreasurerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final treasurerName = authState.currentUser?.displayName ?? 'ไวยาวัจกรณ์';

    return Scaffold(
      appBar: AppBar(
        title: Text('แดชบอร์ด: $treasurerName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'ออกจากระบบ',
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
              // AuthWrapperScreen will handle navigation to LoginScreen
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Section: Overview (Placeholder)
          _buildOverviewSection(context),
          const SizedBox(height: 24.0),

          // Section: Main Menu
          _buildMainMenu(context),
        ],
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    // In a real app, this data would come from a notifier/provider
    const totalMonkBalance = "123,456 บาท";
    const centralFundBalance = "789,012 บาท";
    const monkCount = "15 รูป";
    const driverCount = "4 คน";

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ภาพรวมบัญชี', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16.0),
            _buildOverviewItem(
              icon: Icons.account_balance_wallet,
              label: 'ยอดเงินคงเหลือพระทุกรูป (รวม):',
              value: totalMonkBalance,
            ),
            _buildOverviewItem(
              icon: Icons.temple_hindu_outlined, // Or Icons.account_balance
              label: 'ยอดเงินคงเหลือ กองกลางวัด:',
              value: centralFundBalance,
            ),
            _buildOverviewItem(
              icon: Icons.groups_2_outlined,
              label: 'จำนวนพระในระบบ:',
              value: monkCount,
            ),
            _buildOverviewItem(
              icon: Icons.directions_car_filled_outlined,
              label: 'จำนวนคนขับรถในระบบ:',
              value: driverCount,
            ),
            // Add more overview items as needed
            // e.g., Text_PendingMonkFundApprovals, Text_PendingDriverExpenseReconciliation
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 12.0),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16.0))),
          Text(
            value,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMainMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('เมนูหลัก', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8.0),
        _buildMenuItem(
          context: context,
          icon: Icons.person_search_outlined,
          title: 'จัดการบัญชีพระ',
          subtitle: 'เพิ่ม, แก้ไข, ดูข้อมูลพระ และทำรายการโดยตรง',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.treasurerMonkList);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.manage_accounts_outlined,
          title: 'จัดการบัญชีคนขับรถ',
          subtitle: 'เพิ่ม, แก้ไข, ดูข้อมูลคนขับรถ',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.treasurerDriverList);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.call_received_outlined,
          title: 'รับข้อมูลจากคนขับรถ',
          subtitle: 'นำเข้าและประมวลผลข้อมูลปัจจัยพระและค่าใช้จ่าย',
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.treasurerProcessDriverSubmission,
            );
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.account_balance_outlined,
          title: 'จัดการเงินกองกลางวัด',
          subtitle: 'บันทึกรับ-จ่าย, จัดการเงินสำรองคนขับรถ',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.treasurerCentralFundMain);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.bar_chart_outlined,
          title: 'ดูรายงานและประวัติ',
          subtitle: 'สรุปข้อมูลและประวัติรายการต่างๆ',
          onTap: () {
            // TODO: Navigate to Reports (e.g., AppRoutes.treasurerReports)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ไปหน้าดูรายงาน (TODO)')),
            );
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.backup_outlined,
          title: 'สำรองข้อมูล / ส่งออกข้อมูล',
          subtitle: 'สร้างไฟล์สำรองข้อมูลและไฟล์สำหรับพระ',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.treasurerBackupExport);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.settings_outlined,
          title: 'ตั้งค่าระบบ',
          subtitle: 'เปลี่ยนรหัสผ่าน, ส่งต่อข้อมูลระบบ',
          onTap: () {
            // TODO: Navigate to System Settings (e.g., AppRoutes.treasurerSettings)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ไปหน้าตั้งค่าระบบ (TODO)')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(icon, size: 36.0, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16.0),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
      ),
    );
  }
}
