import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart';
// Import AppRoutes to navigate to other driver features
import 'package:money/core/navigation/app_router.dart';

class DriverDashboardScreen extends ConsumerWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final driverName = authState.currentUser?.displayName ?? 'คนขับรถ';

    return Scaffold(
      appBar: AppBar(
        title: Text('แดชบอร์ด: $driverName'),
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
    // In a real app, this data would come from a driver-specific notifier
    const travelAdvanceBalance = "5,000 บาท";
    const pendingMonkFundTransactions = "3 รายการ";
    const pendingExpenses = "5 รายการ";

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ข้อมูลสรุป', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16.0),
            _buildOverviewItem(
              icon: Icons.wallet_travel_outlined,
              label: 'เงินสำรองเดินทางคงเหลือ:',
              value: travelAdvanceBalance,
            ),
            _buildOverviewItem(
              icon: Icons.pending_actions_outlined,
              label: 'รายการปัจจัยพระรอส่งออก:',
              value: pendingMonkFundTransactions,
            ),
            _buildOverviewItem(
              icon: Icons.receipt_long_outlined,
              label: 'รายการค่าใช้จ่ายรอส่งออก:',
              value: pendingExpenses,
            ),
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
          icon: Icons.savings_outlined,
          title: 'บันทึกรายการปัจจัยพระ',
          subtitle: 'บันทึกการรับฝากหรือเบิกปัจจัยให้พระ',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.driverRecordMonkFund);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.price_change_outlined,
          title: 'บันทึกค่าใช้จ่ายเดินทาง',
          subtitle: 'บันทึกค่าใช้จ่ายที่เกิดขึ้นระหว่างเดินทาง',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.driverRecordExpense);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.ios_share_outlined,
          title: 'ส่งออกข้อมูลให้ไวยาวัจกรณ์',
          subtitle: 'รวบรวมและส่งข้อมูลรายการต่างๆ',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.driverExportData);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.file_download_done_outlined,
          title: 'นำเข้าข้อมูลอัปเดต',
          subtitle: 'รับข้อมูลล่าสุดจากไวยาวัจกรณ์',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.driverImportUpdate);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.settings_outlined,
          title: 'ตั้งค่าบัญชี',
          subtitle: 'เปลี่ยนรหัสผ่าน, ดูข้อมูล ID',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.driverSettings);
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
