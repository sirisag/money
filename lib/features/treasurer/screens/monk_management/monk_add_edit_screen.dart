import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/features/treasurer/notifiers/monk_account_notifier.dart';

enum MonkFormMode { add, edit }

class MonkAddEditScreen extends ConsumerStatefulWidget {
  final MonkFormMode mode;
  final MonkProfile? existingMonk; // Pass this when in edit mode

  const MonkAddEditScreen({super.key, required this.mode, this.existingMonk});

  @override
  ConsumerState<MonkAddEditScreen> createState() => _MonkAddEditScreenState();
}

class _MonkAddEditScreenState extends ConsumerState<MonkAddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactInfoController = TextEditingController();
  MonkAccountStatus _selectedStatus = MonkAccountStatus.active;

  // These would be displayed, not edited by treasurer directly in this form
  String _generatedPrimaryId = " (จะสร้างอัตโนมัติ)";
  String _generatedSecondaryId = " (จะสร้างอัตโนมัติ)";

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.mode == MonkFormMode.edit && widget.existingMonk != null) {
      // Pre-fill form for editing
      _nameController.text = widget.existingMonk!.nameOrTitle ?? '';
      _contactInfoController.text = widget.existingMonk!.contactInfo ?? '';
      _selectedStatus = widget.existingMonk!.status;
      _generatedPrimaryId = widget.existingMonk!.monkPrimaryId;
      // Ensure appUser is loaded if you need its secondaryId for display
      // For now, MonkProfile's secondaryId is used.
      _generatedSecondaryId = widget.existingMonk!.monkSecondaryId ?? 'N/A';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  Future<void> _saveMonkData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final success = await ref
          .read(monkAccountNotifierProvider.notifier)
          .saveMonk(
            mode: widget.mode,
            existingMonkIsarId: widget.mode == MonkFormMode.edit
                ? widget.existingMonk?.id
                : null,
            existingMonkAppUserPrimaryId: widget.mode == MonkFormMode.edit
                ? widget
                      .existingMonk
                      ?.appUser
                      .value
                      ?.primaryId // Assuming AppUser is linked and loaded
                : null,
            name: _nameController.text,
            contactInfo: _contactInfoController.text,
            status: _selectedStatus,
          );
      final String action = widget.mode == MonkFormMode.add ? "เพิ่ม" : "แก้ไข";

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? '$actionข้อมูลพระ ${_nameController.text} สำเร็จ!'
                  : '$actionข้อมูลพระไม่สำเร็จ: ${ref.read(monkAccountNotifierProvider).errorMessage ?? "เกิดข้อผิดพลาดไม่ทราบสาเหตุ"}',
            ),
          ),
        );
        if (success) {
          Navigator.of(context).pop(); // Go back to MonkListScreen
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String appBarTitle = widget.mode == MonkFormMode.add
        ? 'เพิ่มบัญชีพระ'
        : 'แก้ไขข้อมูลพระ';
    final String buttonText = widget.mode == MonkFormMode.add
        ? 'สร้างบัญชีพระ'
        : 'บันทึกการแก้ไข';

    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              if (widget.mode == MonkFormMode.edit) ...[
                _buildReadOnlyIdRow("Primary ID:", _generatedPrimaryId),
                _buildReadOnlyIdRow("Secondary ID:", _generatedSecondaryId),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อ/ฉายาพระ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อหรือฉายาพระ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactInfoController,
                decoration: const InputDecoration(
                  labelText: 'ข้อมูลติดต่อ (ถ้ามี)',
                  hintText: 'เช่น เบอร์โทร, กุฏิ, วัด',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.contact_page_outlined),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MonkAccountStatus>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'สถานะบัญชีพระ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.history_toggle_off_outlined),
                ),
                items: MonkAccountStatus.values.map((MonkAccountStatus status) {
                  return DropdownMenuItem<MonkAccountStatus>(
                    value: status,
                    child: Text(status.displayName),
                  );
                }).toList(),
                onChanged: (MonkAccountStatus? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedStatus = newValue;
                    });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'กรุณาเลือกสถานะบัญชี';
                  }
                  return null;
                },
              ),
              if (widget.mode == MonkFormMode.add) ...[
                const SizedBox(height: 16),
                Text(
                  'หมายเหตุ: Primary ID และ Secondary ID สำหรับพระจะถูกสร้างโดยระบบโดยอัตโนมัติ (6 หลัก) หลังจากบันทึกข้อมูล',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: Icon(
                        widget.mode == MonkFormMode.add
                            ? Icons.person_add_alt_1_outlined
                            : Icons.save_outlined,
                      ),
                      onPressed: _saveMonkData,
                      label: Text(buttonText),
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

  Widget _buildReadOnlyIdRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
