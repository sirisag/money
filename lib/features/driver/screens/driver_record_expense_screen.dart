import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/features/driver/notifiers/driver_data_notifier.dart';

class DriverRecordExpenseScreen extends ConsumerStatefulWidget {
  const DriverRecordExpenseScreen({super.key});

  @override
  ConsumerState<DriverRecordExpenseScreen> createState() =>
      _DriverRecordExpenseScreenState();
}

class _DriverRecordExpenseScreenState
    extends ConsumerState<DriverRecordExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _expenseTypeController = TextEditingController();
  final _amountController = TextEditingController();
  final _detailsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  bool _isLoading = false;

  // Predefined expense types for quick selection (optional)
  final List<String> _predefinedExpenseTypes = [
    'ค่าน้ำมัน',
    'ค่าทางด่วน',
    'ค่าอาหาร',
    'ค่าที่พัก',
    'ค่าซ่อมรถ',
    'อื่นๆ',
  ];
  String? _selectedPredefinedType;

  @override
  void dispose() {
    _expenseTypeController.dispose();
    _amountController.dispose();
    _detailsController.dispose();
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
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final amount = int.tryParse(_amountController.text);
    if (amount == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('จำนวนเงินไม่ถูกต้อง')));
      setState(() => _isLoading = false);
      return;
    }

    final expenseType =
        _selectedPredefinedType == 'อื่นๆ' || _selectedPredefinedType == null
        ? _expenseTypeController.text
        : _selectedPredefinedType!;

    final success = await ref
        .read(driverDataNotifierProvider.notifier)
        .recordDriverExpense(
          expenseType: expenseType,
          amount: amount,
          date: _selectedDate,
          details: _detailsController.text,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'บันทึกค่าใช้จ่ายสำเร็จ!'
                : 'บันทึกค่าใช้จ่ายไม่สำเร็จ: ${ref.read(driverDataNotifierProvider).errorMessage ?? "เกิดข้อผิดพลาด"}',
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
    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกค่าใช้จ่ายเดินทาง')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _selectedPredefinedType,
                hint: const Text('เลือกประเภทค่าใช้จ่าย หรือกรอกด้านล่าง'),
                items: _predefinedExpenseTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) => setState(() {
                  _selectedPredefinedType = newValue;
                  if (newValue != 'อื่นๆ' && newValue != null)
                    _expenseTypeController.text = newValue;
                  else if (newValue == 'อื่นๆ')
                    _expenseTypeController.clear();
                }),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category_outlined),
                ),
              ),
              if (_selectedPredefinedType == 'อื่นๆ' ||
                  _selectedPredefinedType == null) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _expenseTypeController,
                  decoration: const InputDecoration(
                    labelText: 'ประเภทค่าใช้จ่าย (กรณีเลือก "อื่นๆ")',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (_selectedPredefinedType == 'อื่นๆ' ||
                              _selectedPredefinedType == null) &&
                          (value == null || value.isEmpty)
                      ? 'กรุณาระบุประเภทค่าใช้จ่าย'
                      : null,
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'จำนวนเงิน (บาท)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.price_change_outlined),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'กรุณากรอกจำนวนเงิน';
                  if (int.tryParse(value) == null || int.parse(value) <= 0)
                    return 'จำนวนเงินต้องเป็นเลขจำนวนเต็มบวก';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'รายละเอียดเพิ่มเติม (ถ้ามี)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  "วันที่เกิดค่าใช้จ่าย: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}",
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
                      onPressed: _saveExpense,
                      label: const Text('บันทึกค่าใช้จ่าย'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
