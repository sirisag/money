import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/features/treasurer/notifiers/central_fund_notifier.dart';
import 'package:money/core/navigation/app_router.dart';

class CentralFundMainScreen extends ConsumerWidget {
  const CentralFundMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final centralFundState = ref.watch(centralFundNotifierProvider);
    final numberFormat = NumberFormat("#,##0.00", "en_US");

    return Scaffold(
      appBar: AppBar(title: const Text('จัดการเงินกองกลางวัด')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Section: Current Balance
          _buildBalanceSection(context, centralFundState, numberFormat),
          const SizedBox(height: 24.0),

          // Section: Menu for Central Fund Actions
          _buildCentralFundMenu(context),
        ],
      ),
    );
  }

  Widget _buildBalanceSection(
    BuildContext context,
    CentralFundState state,
    NumberFormat formatter,
  ) {
    return Card(
      elevation: 4.0,
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'ยอดเงินกองกลางปัจจุบัน',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 8.0),
            state.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    '${formatter.format(state.currentBalance)} บาท',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCentralFundMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMenuItem(
          context: context,
          icon: Icons.volunteer_activism_outlined,
          title: 'บันทึกการรับบริจาค/รายรับ',
          subtitle: 'บันทึกเงินเข้ากองกลาง',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.treasurerRecordDonation);
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.receipt_long_outlined,
          title: 'บันทึกค่าใช้จ่ายของวัด',
          subtitle: 'บันทึกเงินออกจากกองกลางสำหรับค่าใช้จ่ายวัด',
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.treasurerRecordTempleExpense,
            );
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.car_rental_outlined,
          title: 'จัดการเงินสำรองเดินทางคนขับรถ',
          subtitle: 'บันทึกการเบิก/คืนเงินสำรองของคนขับรถ',
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.treasurerManageDriverAdvance,
            );
          },
        ),
        _buildMenuItem(
          context: context,
          icon: Icons.history_outlined,
          title: 'ดูประวัติรายการเงินกองกลาง',
          subtitle: 'ตรวจสอบรายการรับ-จ่ายทั้งหมดของกองกลาง',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.treasurerCentralFundHistory);
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
