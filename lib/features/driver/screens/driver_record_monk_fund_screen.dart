import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/monk_profile.dart'; // To select monk
import 'package:money/data/models/transaction_record.dart'; // For TransactionType
import 'package:money/features/driver/notifiers/driver_data_notifier.dart';
import 'package:money/features/treasurer/notifiers/monk_account_notifier.dart'; // To get list of monks (assuming driver has access or a local copy)

class DriverRecordMonkFundScreen extends ConsumerStatefulWidget {
  const DriverRecordMonkFundScreen({super.key});

  @override
  ConsumerState<DriverRecordMonkFundScreen> createState() =>
      _DriverRecordMonkFundScreenState();
}

class _DriverRecordMonkFundScreenState
    extends ConsumerState<DriverRecordMonkFundScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TransactionType _selectedTransactionType = TransactionType.deposit;
  MonkProfile? _selectedMonk;
  bool _driverCoveredWithdrawal = false; // Only for withdrawal type

  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMonk == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('กรุณาเลือกพระ')));
      return;
    }

    setState(() => _isLoading = true);

    final amount = int.tryParse(
      _amountController.text,
    ); // Changed to int.tryParse
    if (amount == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('จำนวนเงินไม่ถูกต้อง')));
      setState(() => _isLoading = false);
      return;
    }

    final success = await ref
        .read(driverDataNotifierProvider.notifier)
        .recordMonkTransactionByDriver(
          monkPrimaryId: _selectedMonk!.monkPrimaryId,
          type: _selectedTransactionType,
          amount: amount, // amount is now int
          description: _descriptionController.text,
          dateTime: _selectedDate,
          driverCovered: _selectedTransactionType == TransactionType.withdrawal
              ? _driverCoveredWithdrawal
              : false,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'บันทึกรายการปัจจัยพระสำเร็จ!'
                : 'บันทึกรายการไม่สำเร็จ: ${ref.read(driverDataNotifierProvider).errorMessage ?? "เกิดข้อผิดพลาด"}',
          ),
        ),
      );
      if (success) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // For selecting a monk, the driver app needs access to the list of monks.
    // This might come from a local copy synced from the treasurer, or a simplified list.
    // Here, we assume MonkAccountNotifier might be accessible or a similar provider for driver.
    // If drivers don't have the full monk list, this part needs adjustment (e.g., manual ID input).
    final monksState = ref.watch(
      monkAccountNotifierProvider,
    ); // Placeholder: driver might have a different provider for monks

    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกรายการปัจจัยพระ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<MonkProfile>(
                value: _selectedMonk,
                hint: const Text('เลือกพระ'),
                isExpanded: true,
                items: monksState.monks.map((MonkProfile monk) {
                  // Assuming monksState.monks is available
                  return DropdownMenuItem<MonkProfile>(
                    value: monk,
                    child: Text(monk.nameOrTitle ?? monk.monkPrimaryId),
                  );
                }).toList(),
                onChanged: (MonkProfile? newValue) =>
                    setState(() => _selectedMonk = newValue),
                validator: (value) => value == null ? 'กรุณาเลือกพระ' : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_pin_circle_outlined),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TransactionType>(
                value: _selectedTransactionType,
                decoration: const InputDecoration(
                  labelText: 'ประเภทรายการ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.swap_vert),
                ),
                items: TransactionType.values
                    .where((t) => t != TransactionType.unknown)
                    .map((TransactionType type) {
                      return DropdownMenuItem<TransactionType>(
                        value: type,
                        child: Text(
                          type == TransactionType.deposit
                              ? 'รับฝากปัจจัย'
                              : 'เบิกปัจจัย',
                        ),
                      );
                    })
                    .toList(),
                onChanged: (TransactionType? newValue) => setState(
                  () => _selectedTransactionType =
                      newValue ?? TransactionType.deposit,
                ),
              ),
              if (_selectedTransactionType == TransactionType.withdrawal) ...[
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('คนขับรถสำรองจ่ายก่อน'),
                  value: _driverCoveredWithdrawal,
                  onChanged: (bool value) =>
                      setState(() => _driverCoveredWithdrawal = value),
                  secondary: const Icon(Icons.credit_card_outlined),
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'จำนวนเงิน (บาท)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number, // For integers
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'กรุณากรอกจำนวนเงิน';
                  if (int.tryParse(value) == null || // Changed to int.tryParse
                      int.parse(value) <= 0) {
                    return 'จำนวนเงินต้องเป็นเลขจำนวนเต็มบวก';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'รายละเอียด/หมายเหตุ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
                maxLines: 2,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'กรุณากรอกรายละเอียด'
                    : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  "วันที่ทำรายการ: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.save_alt_rounded),
                      onPressed: _saveTransaction,
                      label: const Text('บันทึกรายการ'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
