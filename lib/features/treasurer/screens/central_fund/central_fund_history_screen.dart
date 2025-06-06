import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/central_fund_transaction.dart';
import 'package:money/features/treasurer/notifiers/central_fund_notifier.dart';

class CentralFundHistoryScreen extends ConsumerWidget {
  const CentralFundHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final centralFundState = ref.watch(centralFundNotifierProvider);
    final transactions = centralFundState.transactions;
    // Sort transactions by date descending for display
    final sortedTransactions = List<CentralFundTransaction>.from(transactions)
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    final numberFormat = NumberFormat("#,##0.00", "en_US");
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('ประวัติรายการเงินกองกลาง')),
      body: centralFundState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : centralFundState.errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'เกิดข้อผิดพลาด: ${centralFundState.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            )
          : sortedTransactions.isEmpty
          ? const Center(
              child: Text(
                'ยังไม่มีรายการธุรกรรมในกองกลาง',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: sortedTransactions.length,
              itemBuilder: (context, index) {
                final tx = sortedTransactions[index];
                final isIncome =
                    tx.type ==
                        CentralFundTransactionType
                            .donation || // Corrected enum name
                    tx.type ==
                        CentralFundTransactionType
                            .receiveDriverAdvanceReturn; // Corrected enum name
                final amountString =
                    "${isIncome ? '+' : '-'} ${numberFormat.format(tx.amount)}";
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    leading: Icon(
                      isIncome
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      color: isIncome ? Colors.green : Colors.red,
                      size: 30,
                    ),
                    title: Text(
                      tx.description ??
                          'ไม่มีรายละเอียด', // Handle null description
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateFormat.format(tx.dateTime)),
                        if (tx.relatedDriverId != null) // Corrected field name
                          Text(
                            'เกี่ยวข้องกับคนขับรถ ID: ${tx.relatedDriverId}', // Corrected field name
                          ),
                        if (tx.relatedMonkId != null) // Corrected field name
                          Text(
                            'เกี่ยวข้องกับพระ ID: ${tx.relatedMonkId}',
                          ), // Corrected field name
                        Text('ประเภท: ${tx.type.displayName}'),
                      ],
                    ),
                    trailing: Text(
                      amountString,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
