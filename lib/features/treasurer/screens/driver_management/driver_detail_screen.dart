import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/core/navigation/app_router.dart';
import 'package:money/data/models/driver_expense_record.dart';
import 'package:money/data/models/central_fund_transaction.dart';
import 'package:money/features/treasurer/notifiers/driver_account_notifier.dart'; // For providers

class DriverDetailScreen extends ConsumerWidget {
  final DriverProfile driver;

  const DriverDetailScreen({super.key, required this.driver});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberFormat = NumberFormat("#,##0", "en_US");
    final dateFormat = DateFormat(
      'dd/MM/yyyy',
    ); // Simpler date format for history

    // Attempt to get secondaryId from the linked AppUser
    // This requires the appUser link to be loaded.
    final secondaryId = driver.appUser.value?.secondaryId ?? 'N/A';
    final expenseHistoryAsync = ref.watch(
      driverExpenseHistoryProvider(driver.driverPrimaryId),
    );
    final advanceHistoryAsync = ref.watch(
      driverCentralFundTransactionsProvider(driver.driverPrimaryId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(driver.name ?? 'รายละเอียดคนขับรถ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'แก้ไขข้อมูลคนขับรถ',
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.treasurerDriverAddEdit,
                arguments: {'isEditMode': true, 'driver': driver},
              );
            },
          ),
          // Optional: Delete button (similar to MonkDetailScreen)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDetailRow(context, 'ชื่อ-นามสกุล:', driver.name ?? 'N/A'),
            _buildDetailRow(
              context,
              'Primary ID (คนขับรถ):',
              driver.driverPrimaryId,
            ),
            _buildDetailRow(context, 'Secondary ID (ระบบ):', secondaryId),
            _buildDetailRow(
              context,
              'ข้อมูลติดต่อ:',
              driver.contactInfo ?? 'ไม่มีข้อมูล',
            ),
            _buildDetailRow(
              context,
              'เงินสำรองเดินทางคงเหลือ:',
              '${numberFormat.format(driver.travelAdvanceBalance)} บาท', // Corrected field name
              valueColor:
                  driver.travelAdvanceBalance <
                      0 // Corrected field name
                  ? Colors.red
                  : Colors.green,
            ),

            // Add other driver-specific details here if any
            const SizedBox(height: 24),
            // Actions specific to a driver
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.request_quote_outlined),
                label: const Text('ออกเงินสำรองเดินทาง'),
                onPressed: () {
                  // TODO: Navigate to IssueTravelAdvanceScreen
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'ไปหน้าออกเงินสำรองสำหรับ ${driver.name} (TODO)',
                      ),
                    ),
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
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text('รับรายงานและกระทบยอดค่าใช้จ่าย'),
                onPressed: () {
                  // TODO: Navigate to ReconcileDriverExpensesScreen
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'ไปหน้ารับรายงานค่าใช้จ่าย ${driver.name} (TODO)',
                      ),
                    ),
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
              'ประวัติการเบิก/คืนเงินสำรอง (จากกองกลาง):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            advanceHistoryAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: Text('ไม่มีประวัติรายการเงินสำรอง')),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.take(5).length, // Show latest 5
                  itemBuilder: (context, index) => _buildCentralFundTxListItem(
                    context,
                    transactions[index],
                    numberFormat,
                    dateFormat,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text('เกิดข้อผิดพลาด: $err')),
            ),
            const SizedBox(height: 24),
            Text(
              'ประวัติค่าใช้จ่ายของคนขับรถ:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            expenseHistoryAsync.when(
              data: (expenses) {
                if (expenses.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: Text('ไม่มีประวัติค่าใช้จ่าย')),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: expenses.take(5).length, // Show latest 5
                  itemBuilder: (context, index) => _buildDriverExpenseListItem(
                    context,
                    expenses[index],
                    numberFormat,
                    dateFormat,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text('เกิดข้อผิดพลาด: $err')),
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
            width: 180, // Adjust width as needed for longer labels
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

  Widget _buildHistoryPlaceholder(
    BuildContext context,
    String title,
    String amount,
  ) {
    return ListTile(
      leading: Icon(
        amount.startsWith('+') ? Icons.arrow_downward : Icons.arrow_upward,
        color: amount.startsWith('+') ? Colors.green : Colors.red,
      ),
      title: Text(title),
      subtitle: Text(
        'วันที่ ${20 - (amount.length % 3)}/07/2567 โดย ไวยาวัจกรณ์',
      ),
      trailing: Text(amount),
    );
  }

  Widget _buildCentralFundTxListItem(
    BuildContext context,
    CentralFundTransaction tx,
    NumberFormat numberFormat,
    DateFormat dateFormat,
  ) {
    final isIncomeToCentralFund =
        tx.type == CentralFundTransactionType.donation ||
        tx.type == CentralFundTransactionType.receiveDriverAdvanceReturn;
    // For driver-related transactions, "income" to central fund means driver returned money or it's a general donation.
    // "Expense" from central fund means driver was issued an advance or reimbursed.

    // We need to interpret the 'amount' based on the transaction type from the driver's perspective.
    // However, the 'amount' in CentralFundTransaction is already signed (+ for income to fund, - for expense from fund).
    // So, if tx.amount is positive, it's money IN to the fund.
    // If tx.amount is negative, it's money OUT of the fund.

    final amountDisplay = numberFormat.format(tx.amount.abs());
    final color = tx.amount >= 0 ? Colors.green : Colors.red;
    final icon = tx.amount >= 0
        ? Icons
              .arrow_downward_rounded // Money into central fund
        : Icons.arrow_upward_rounded; // Money out of central fund

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(tx.description ?? 'ไม่มีรายละเอียด'),
        subtitle: Text(
          '${tx.type.displayName}\n${dateFormat.format(tx.dateTime)}',
        ),
        trailing: Text(
          amountDisplay,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDriverExpenseListItem(
    BuildContext context,
    DriverExpenseRecord expense,
    NumberFormat numberFormat,
    DateFormat dateFormat,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: const Icon(Icons.receipt_long_outlined, color: Colors.orange),
        title: Text(expense.expenseType),
        subtitle: Text(
          '${expense.details ?? "ไม่มีรายละเอียดเพิ่มเติม"}\nวันที่: ${dateFormat.format(expense.date)}',
        ),
        trailing: Text(
          numberFormat.format(expense.amount),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
