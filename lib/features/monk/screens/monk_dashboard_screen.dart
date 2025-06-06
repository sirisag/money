import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart';
// Import AppRoutes to navigate to other monk features
import 'package:money/core/navigation/app_router.dart';
import 'package:money/data/models/transaction_record.dart'; // For TransactionType
import 'package:money/features/monk/notifiers/monk_data_notifier.dart'; // To display last import date

class MonkDashboardScreen extends ConsumerWidget {
  const MonkDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final monkDataState = ref.watch(
      monkDataNotifierProvider,
    ); // Watch monk data
    final numberFormat = NumberFormat(
      "#,##0",
      "en_US",
    ); // For balance formatting
    final dateFormat = DateFormat(
      'dd/MM/yyyy HH:mm',
    ); // For transaction date formatting
    // For Monk, displayName might be their monastic name,
    // which should be part of AppUser or a linked MonkProfile.
    // Using a default or primaryId if displayName is not set.
    final monkName =
        authState.currentUser?.displayName ??
        (authState.currentUser?.primaryId != null
            ? 'พระ ID: ${authState.currentUser!.primaryId}'
            : 'พระ');

    return Scaffold(
      appBar: AppBar(
        title: Text('แดชบอร์ด: $monkName'),
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
          _buildOverviewSection(context, ref),
          const SizedBox(height: 24.0),

          // Section: Main Menu
          _buildMainMenu(context),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              // Display last import date
              monkDataState.lastImportDate != null
                  ? 'ข้อมูลล่าสุดเมื่อ: ${DateFormat('dd/MM/yyyy HH:mm').format(monkDataState.lastImportDate!)}'
                  : 'ยังไม่ได้นำเข้าข้อมูล',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context, WidgetRef ref) {
    // In a real app, this data would come from a monk-specific notifier
    final monkData = ref.watch(monkDataNotifierProvider);
    final currentBalance = monkData.monkProfile?.currentBalance ?? 0.0;
    final recentTransactions = monkData.transactions;
    final numberFormat = NumberFormat(
      "#,##0",
      "en_US",
    ); // Already defined in parent build

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ข้อมูลปัจจัย', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16.0),
            _buildOverviewItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'ยอดปัจจัยคงเหลือปัจจุบัน:',
              value: '${numberFormat.format(currentBalance)} บาท',
            ),
            const SizedBox(height: 16.0),
            Text(
              'รายการล่าสุด:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            if (recentTransactions.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('ไม่มีรายการล่าสุด'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentTransactions.length > 3
                    ? 3
                    : recentTransactions.length, // Show max 3
                itemBuilder: (context, index) {
                  final tx = recentTransactions.reversed
                      .toList()[index]; // Show newest first
                  final isDeposit =
                      tx.type ==
                      TransactionType.deposit; // Use imported TransactionType
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      isDeposit
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      color: isDeposit ? Colors.green : Colors.red,
                    ),
                    title: Text(tx.description ?? 'ไม่มีรายละเอียด'),
                    trailing: Text(
                      '${isDeposit ? '+' : '-'} ${numberFormat.format(tx.amount)} บาท',
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(tx.dateTime),
                    ), // Simpler date for overview
                  );
                },
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
        Text('เมนู', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8.0),
        _buildMenuItem(
          context: context,
          icon: Icons.history_edu_outlined,
          title: 'ดูประวัติรายการทั้งหมด',
          subtitle: 'ตรวจสอบรายการปัจจัยทั้งหมดของคุณ',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.monkTransactionHistory);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.file_download_outlined,
          title: 'นำเข้าข้อมูลล่าสุด',
          subtitle: 'อัปเดตข้อมูลบัญชีจากไฟล์ที่ได้รับจากไวยาวัจกรณ์',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.monkImportMasterData);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.settings_outlined,
          title: 'ตั้งค่า',
          subtitle: 'เปลี่ยน PIN, ดูข้อมูลบัญชี',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.monkSettings);
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
