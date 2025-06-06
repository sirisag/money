import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/data/models/transaction_record.dart'; // For TransactionType
import 'package:money/features/auth/notifiers/auth_notifier.dart'; // To get current treasurer
import 'package:money/features/treasurer/notifiers/monk_account_notifier.dart';

class DirectMonkTransactionScreen extends ConsumerStatefulWidget {
  final MonkProfile monk;

  const DirectMonkTransactionScreen({super.key, required this.monk});

  @override
  ConsumerState<DirectMonkTransactionScreen> createState() =>
      _DirectMonkTransactionScreenState();
}

class _DirectMonkTransactionScreenState
    extends ConsumerState<DirectMonkTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TransactionType _selectedTransactionType =
      TransactionType.deposit; // Default to deposit

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill description if needed, e.g.,
    // _descriptionController.text = "รายการโดยไวยาวัจกรณ์";
  }

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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final treasurerUser = ref.read(authNotifierProvider).currentUser;
    if (treasurerUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่พบข้อมูลไวยาวัจกรณ์ปัจจุบัน')),
      );
      return;
    }

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
        .read(monkAccountNotifierProvider.notifier)
        .recordDirectMonkTransaction(
          monkPrimaryId: widget.monk.monkPrimaryId,
          type: _selectedTransactionType,
          amount: amount, // amount is now int
          description: _descriptionController.text,
          dateTime: _selectedDate,
          treasurerUser: treasurerUser,
        );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'บันทึกรายการสำเร็จ!'
                : 'บันทึกรายการไม่สำเร็จ: ${ref.read(monkAccountNotifierProvider).errorMessage ?? "เกิดข้อผิดพลาด"}',
          ),
        ),
      );
      if (success) {
        Navigator.of(context).pop(); // Pop back to MonkDetailScreen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ทำรายการให้: ${widget.monk.nameOrTitle ?? widget.monk.monkPrimaryId}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'พระ: ${widget.monk.nameOrTitle ?? widget.monk.monkPrimaryId}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TransactionType>(
                value: _selectedTransactionType,
                decoration: const InputDecoration(
                  labelText: 'ประเภทรายการ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.swap_vert_circle_outlined),
                ),
                items: TransactionType.values
                    .where(
                      (type) => type != TransactionType.unknown,
                    ) // Exclude 'unknown'
                    .map((TransactionType type) {
                      return DropdownMenuItem<TransactionType>(
                        value: type,
                        child: Text(
                          type == TransactionType.deposit
                              ? 'ฝากปัจจัย'
                              : 'ถอนปัจจัย',
                        ),
                      );
                    })
                    .toList(),
                onChanged: (TransactionType? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedTransactionType = newValue;
                    });
                  }
                },
              ),
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
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกจำนวนเงิน';
                  }
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
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรายละเอียด';
                  }
                  return null;
                },
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
                      icon: const Icon(Icons.save_outlined),
                      onPressed: _saveTransaction,
                      label: const Text('บันทึกรายการ'),
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
