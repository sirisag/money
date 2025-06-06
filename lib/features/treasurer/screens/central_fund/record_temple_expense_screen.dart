import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/central_fund_transaction.dart';
import 'package:money/features/treasurer/notifiers/central_fund_notifier.dart';

class RecordTempleExpenseScreen extends ConsumerStatefulWidget {
  const RecordTempleExpenseScreen({super.key});

  @override
  ConsumerState<RecordTempleExpenseScreen> createState() =>
      _RecordTempleExpenseScreenState();
}

class _RecordTempleExpenseScreenState
    extends ConsumerState<RecordTempleExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

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

  Future<void> _saveExpense() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

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
          .read(centralFundNotifierProvider.notifier)
          .recordTransaction(
            type: CentralFundTransactionType
                .templeExpense, // Corrected enum name and type
            amount: amount, // amount is now int
            description: _descriptionController.text,
            dateTime: _selectedDate,
          );

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'บันทึกค่าใช้จ่ายสำเร็จ!'
                  : 'บันทึกค่าใช้จ่ายไม่สำเร็จ: ${ref.read(centralFundNotifierProvider).errorMessage ?? "เกิดข้อผิดพลาด"}',
            ),
          ),
        );
        if (success) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกค่าใช้จ่ายของวัด')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'จำนวนเงิน (บาท)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money_off_csred_outlined),
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
                  labelText: 'รายละเอียดค่าใช้จ่าย',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'กรุณากรอกรายละเอียด';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  "วันที่: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}",
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
                      icon: const Icon(Icons.save_alt_outlined),
                      onPressed: _saveExpense,
                      label: const Text('บันทึกค่าใช้จ่าย'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        textStyle: const TextStyle(fontSize: 16.0),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
