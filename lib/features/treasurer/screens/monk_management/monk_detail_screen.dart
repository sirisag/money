import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/core/navigation/app_router.dart';
import 'package:money/data/models/transaction_record.dart';
import 'package:money/features/treasurer/screens/monk_management/monk_add_edit_screen.dart'; // For MonkFormMode
import 'package:money/features/treasurer/notifiers/monk_account_notifier.dart'; // For monkTransactionHistoryProvider

class MonkDetailScreen extends ConsumerWidget {
  final MonkProfile monk;

  const MonkDetailScreen({super.key, required this.monk});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberFormat = NumberFormat("#,##0", "en_US");
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final transactionHistoryAsyncValue = ref.watch(
      monkTransactionHistoryProvider(monk.monkPrimaryId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(monk.nameOrTitle ?? 'รายละเอียดพระ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'แก้ไขข้อมูลพระ',
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.treasurerMonkAddEdit,
                arguments: {'mode': MonkFormMode.edit, 'monk': monk},
              );
            },
          ),
          // Optional: Delete button
          // IconButton(
          //   icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          //   tooltip: 'ลบข้อมูลพระ',
          //   onPressed: () async {
          //     final confirmDelete = await showDialog<bool>(
          //       context: context,
          //       builder: (BuildContext dialogContext) {
          //         return AlertDialog(
          //           title: const Text('ยืนยันการลบ'),
          //           content: Text(
          //               'คุณต้องการลบข้อมูลของ "${monk.nameOrTitle ?? monk.monkPrimaryId}" ใช่หรือไม่? การกระทำนี้ไม่สามารถย้อนกลับได้ และจะลบข้อมูล AppUser ที่เกี่ยวข้องด้วย'),
          //           actions: <Widget>[
          //             TextButton(
          //               child: const Text('ยกเลิก'),
          //               onPressed: () => Navigator.of(dialogContext).pop(false),
          //             ),
          //             TextButton(
          //               style: TextButton.styleFrom(foregroundColor: Colors.red),
          //               child: const Text('ลบ'),
          //               onPressed: () => Navigator.of(dialogContext).pop(true),
          //             ),
          //           ],
          //         );
          //       },
          //     );

          //     if (confirmDelete == true && monk.appUser.value != null) {
          //       final success = await ref
          //           .read(monkAccountNotifierProvider.notifier)
          //           .deleteMonk(monk.id, monk.appUser.value!.primaryId); // monk.id is Isar ID
          //       if (context.mounted) {
          //          ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: Text(success
          //                 ? 'ลบข้อมูลพระสำเร็จ'
          //                 : 'การลบข้อมูลพระล้มเหลว: ${ref.read(monkAccountNotifierProvider).errorMessage ?? ""}'),
          //           ),
          //         );
          //         if (success) {
          //           Navigator.of(context).pop(); // Go back to list screen
          //         }
          //       }
          //     }
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDetailRow(context, 'ชื่อ/ฉายา:', monk.nameOrTitle ?? 'N/A'),
            _buildDetailRow(context, 'Primary ID:', monk.monkPrimaryId),
            _buildDetailRow(
              context,
              'Secondary ID:',
              monk.monkSecondaryId ?? 'N/A',
            ),
            _buildDetailRow(
              context,
              'ข้อมูลติดต่อ:',
              monk.contactInfo ?? 'ไม่มีข้อมูล',
            ),
            _buildDetailRow(context, 'สถานะบัญชี:', monk.status.displayName),
            _buildDetailRow(
              context,
              'ยอดปัจจัยคงเหลือ:',
              '${numberFormat.format(monk.currentBalance)} บาท',
              valueColor: monk.currentBalance < 0 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.swap_horiz_outlined),
                label: const Text('ทำรายการฝาก/ถอนโดยตรง'),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.treasurerDirectMonkTransaction,
                    arguments: monk,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'ประวัติรายการธุรกรรม (ล่าสุด 5 รายการ):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            transactionHistoryAsyncValue.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: Text('ไม่มีประวัติรายการธุรกรรม')),
                  );
                }
                // Display a limited number of recent transactions, e.g., latest 5
                final recentTransactions = transactions.take(5).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recentTransactions.length,
                  itemBuilder: (context, index) {
                    return _buildTransactionListItem(
                      context,
                      recentTransactions[index],
                      numberFormat,
                      dateFormat,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text('เกิดข้อผิดพลาดในการโหลดประวัติ: $err')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120, // Adjust width as needed
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: valueColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionPlaceholder(BuildContext context) {
    // Replace this with actual transaction data later
    return Column(
      children: List.generate(3, (index) {
        return ListTile(
          leading: Icon(
            index.isEven ? Icons.arrow_downward : Icons.arrow_upward,
            color: index.isEven ? Colors.green : Colors.red,
          ),
          title: Text(index.isEven ? 'รับฝากปัจจัย' : 'เบิกปัจจัย'),
          subtitle: Text('วันที่ ${20 - index}/07/2567 โดย ไวยาวัจกรณ์'),
          trailing: Text(index.isEven ? '+ 1,000 บาท' : '- 500 บาท'),
        );
      }),
    );
  }

  Widget _buildTransactionListItem(
    BuildContext context,
    TransactionRecord tx,
    NumberFormat numberFormat,
    DateFormat dateFormat,
  ) {
    final isDeposit = tx.type == TransactionType.deposit;
    final amountString =
        "${isDeposit ? '+' : '-'} ${numberFormat.format(tx.amount.abs())}";
    final color = isDeposit ? Colors.green : Colors.red;
    final icon = isDeposit
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded;

    String sourceText = tx.source.toString().split('.').last; // Default
    if (tx.source == TransactionSource.directTreasurer) {
      sourceText = 'โดยไวยาวัจกรณ์';
    } else if (tx.source == TransactionSource.driverCollection) {
      sourceText = 'รับฝากโดยคนขับรถ ID: ${tx.driverPrimaryId ?? 'N/A'}';
    } else if (tx.source == TransactionSource.driverWithdrawal) {
      sourceText = 'เบิกผ่านคนขับรถ ID: ${tx.driverPrimaryId ?? 'N/A'}';
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(tx.description ?? 'ไม่มีรายละเอียด'),
        subtitle: Text('${dateFormat.format(tx.dateTime)}\n$sourceText'),
        trailing: Text(
          amountString,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
