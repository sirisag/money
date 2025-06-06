import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/transaction_record.dart';
import 'package:money/features/monk/notifiers/monk_data_notifier.dart';

class MonkTransactionHistoryScreen extends ConsumerWidget {
  const MonkTransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monkDataState = ref.watch(monkDataNotifierProvider);
    final transactions = monkDataState.transactions;
    // Sort transactions by date descending for display
    final sortedTransactions = List<TransactionRecord>.from(transactions)
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    final numberFormat = NumberFormat("#,##0", "en_US");
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('ประวัติรายการปัจจัยทั้งหมด')),
      body:
          monkDataState.isLoading &&
              transactions
                  .isEmpty // Show loading only if transactions are not yet loaded
          ? const Center(child: CircularProgressIndicator())
          : monkDataState.errorMessage != null && transactions.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'เกิดข้อผิดพลาด: ${monkDataState.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            )
          : sortedTransactions.isEmpty
          ? const Center(
              child: Text(
                'ยังไม่มีประวัติรายการธุรกรรม',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: sortedTransactions.length,
              itemBuilder: (context, index) {
                final tx = sortedTransactions[index];
                final isDeposit = tx.type == TransactionType.deposit;
                final amountString =
                    "${isDeposit ? '+' : '-'} ${numberFormat.format(tx.amount)} บาท";
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    leading: Icon(
                      isDeposit
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      color: isDeposit ? Colors.green : Colors.red,
                      size: 30,
                    ),
                    title: Text(
                      tx.description ?? 'ไม่มีรายละเอียด',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateFormat.format(tx.dateTime)),
                        Text(
                          'ดำเนินการโดย: ${tx.processedByUserId ?? "N/A"} (${tx.source.name})',
                        ),
                        if (tx.driverPrimaryId != null)
                          Text(
                            'คนขับรถ: ${tx.driverPrimaryId}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Text(
                      amountString,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDeposit ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
