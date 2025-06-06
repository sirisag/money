import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money/data/models/central_fund_transaction.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/features/treasurer/notifiers/central_fund_notifier.dart';
import 'package:money/features/treasurer/notifiers/driver_account_notifier.dart'; // To get list of drivers

enum DriverAdvanceType { issue, receiveReturn }

class ManageDriverAdvanceScreen extends ConsumerStatefulWidget {
  const ManageDriverAdvanceScreen({super.key});

  @override
  ConsumerState<ManageDriverAdvanceScreen> createState() =>
      _ManageDriverAdvanceScreenState();
}

class _ManageDriverAdvanceScreenState
    extends ConsumerState<ManageDriverAdvanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DriverProfile? _selectedDriver;
  DriverAdvanceType _selectedAdvanceType = DriverAdvanceType.issue;

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

  Future<void> _saveDriverAdvance() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDriver == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('กรุณาเลือกคนขับรถ')));
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

      final transactionType = _selectedAdvanceType == DriverAdvanceType.issue
          ? CentralFundTransactionType
                .issueDriverAdvance // Corrected enum
          : CentralFundTransactionType
                .receiveDriverAdvanceReturn; // Corrected enum

      final success = await ref
          .read(centralFundNotifierProvider.notifier)
          .recordTransaction(
            type: transactionType,
            amount: amount, // amount is now int
            description: _descriptionController.text,
            dateTime: _selectedDate,
            relatedToDriverId: _selectedDriver!.driverPrimaryId,
          );

      if (success) {
        // Update DriverProfile's travelAdvanceBalance
        // The sign of amountChange depends on how CentralFundNotifier handles the amount for issue/return
        // and how DriverAccountNotifier expects amountChange.
        // Assuming CentralFundNotifier records issueDriverAdvance as a negative amount to central fund,
        // and receiveDriverAdvanceReturn as positive.
        // DriverAccountNotifier.updateDriverAdvance expects:
        //  - positive amountChange to increase driver's advance (e.g., treasurer gives money)
        //  - negative amountChange to decrease driver's advance (e.g., driver returns money)

        int amountChangeForDriver;
        if (_selectedAdvanceType == DriverAdvanceType.issue) {
          // Treasurer issues advance to driver, so driver's balance increases
          amountChangeForDriver = amount;
        } else {
          // Driver returns advance to treasurer, so driver's balance decreases
          amountChangeForDriver = -amount;
        }

        await ref
            .read(driverAccountNotifierProvider.notifier)
            .updateDriverAdvance(
              driverIsarId: _selectedDriver!.id,
              amountChange: amountChangeForDriver, // amountChange is now int
            );
      }

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'บันทึกรายการเงินสำรองคนขับรถสำเร็จ!'
                  : 'บันทึกรายการไม่สำเร็จ: ${ref.read(centralFundNotifierProvider).errorMessage ?? "เกิดข้อผิดพลาด"}',
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
    final driversState = ref.watch(driverAccountNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('จัดการเงินสำรองคนขับรถ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<DriverProfile>(
                value: _selectedDriver,
                hint: const Text('เลือกคนขับรถ'),
                isExpanded: true,
                items: driversState.drivers.map((DriverProfile driver) {
                  return DropdownMenuItem<DriverProfile>(
                    value: driver,
                    child: Text(driver.name ?? driver.driverPrimaryId),
                  );
                }).toList(),
                onChanged: (DriverProfile? newValue) {
                  setState(() {
                    _selectedDriver = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'กรุณาเลือกคนขับรถ' : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_search_outlined),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<DriverAdvanceType>(
                value: _selectedAdvanceType,
                items: DriverAdvanceType.values.map((DriverAdvanceType type) {
                  return DropdownMenuItem<DriverAdvanceType>(
                    value: type,
                    child: Text(
                      type == DriverAdvanceType.issue
                          ? 'เบิกเงินสำรอง (ให้คนขับรถ)'
                          : 'รับคืนเงินสำรอง (จากคนขับรถ)',
                    ),
                  );
                }).toList(),
                onChanged: (DriverAdvanceType? newValue) {
                  if (newValue != null) {
                    setState(() => _selectedAdvanceType = newValue);
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'ประเภทรายการ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.swap_horiz_outlined),
                ),
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
                maxLines: 2,
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
                      icon: const Icon(Icons.save_as_outlined),
                      onPressed: _saveDriverAdvance,
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
