import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/features/treasurer/notifiers/driver_account_notifier.dart';

// We use a boolean for mode here as per DriverAccountNotifier,
// but an enum could also be used for consistency if preferred.
// enum DriverFormMode { add, edit }

class DriverAddEditScreen extends ConsumerStatefulWidget {
  final bool isEditMode;
  final DriverProfile? existingDriver;

  const DriverAddEditScreen({
    super.key,
    required this.isEditMode,
    this.existingDriver,
  });

  @override
  ConsumerState<DriverAddEditScreen> createState() =>
      _DriverAddEditScreenState();
}

class _DriverAddEditScreenState extends ConsumerState<DriverAddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactInfoController = TextEditingController();
  // Add controllers for other driver-specific fields if any (e.g., license number)

  // These would be displayed, not edited by treasurer directly in this form
  String _displayPrimaryId = " (จะสร้างอัตโนมัติ)";
  String _displaySecondaryId = " (จะสร้างอัตโนมัติ)"; // From AppUser

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.existingDriver != null) {
      _nameController.text = widget.existingDriver!.name ?? '';
      _contactInfoController.text = widget.existingDriver!.contactInfo ?? '';
      _displayPrimaryId = widget.existingDriver!.driverPrimaryId;

      // To display secondaryId, we need the linked AppUser.
      // This assumes the AppUser link is loaded with DriverProfile.
      // If not, it might need to be fetched or handled differently.
      _displaySecondaryId =
          widget.existingDriver!.appUser.value?.secondaryId ?? 'N/A';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  Future<void> _saveDriverData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final success = await ref
          .read(driverAccountNotifierProvider.notifier)
          .saveDriver(
            isEditMode: widget.isEditMode,
            existingDriverIsarId: widget.isEditMode
                ? widget.existingDriver?.id
                : null,
            existingDriverAppUserPrimaryId: widget.isEditMode
                ? widget.existingDriver?.appUser.value?.primaryId
                : null,
            name: _nameController.text,
            contactInfo: _contactInfoController.text,
            // Pass other driver-specific fields here
          );
      final String action = widget.isEditMode ? "แก้ไข" : "เพิ่ม";

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? '$actionข้อมูลคนขับรถ ${_nameController.text} สำเร็จ!'
                  : '$actionข้อมูลคนขับรถไม่สำเร็จ: ${ref.read(driverAccountNotifierProvider).errorMessage ?? "เกิดข้อผิดพลาดไม่ทราบสาเหตุ"}',
            ),
          ),
        );
        if (success) {
          Navigator.of(context).pop(); // Go back to DriverListScreen
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String appBarTitle = widget.isEditMode
        ? 'แก้ไขข้อมูลคนขับรถ'
        : 'เพิ่มบัญชีคนขับรถใหม่';
    final String buttonText = widget.isEditMode
        ? 'บันทึกการแก้ไข'
        : 'สร้างบัญชีคนขับรถ';

    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              if (widget.isEditMode) ...[
                _buildReadOnlyIdRow("Primary ID (คนขับรถ):", _displayPrimaryId),
                _buildReadOnlyIdRow(
                  "Secondary ID (ระบบ):",
                  _displaySecondaryId,
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อ-นามสกุล คนขับรถ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อคนขับรถ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactInfoController,
                decoration: const InputDecoration(
                  labelText: 'ข้อมูลติดต่อ (ถ้ามี)',
                  hintText: 'เช่น เบอร์โทรศัพท์',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.contact_phone_outlined),
                ),
                maxLines: 2,
              ),

              // Add other driver-specific fields here
              // e.g., TextFormField for license number
              if (!widget.isEditMode) ...[
                const SizedBox(height: 16),
                Text(
                  'หมายเหตุ: Primary ID และ Secondary ID สำหรับคนขับรถจะถูกสร้างโดยระบบโดยอัตโนมัติ (5 หลัก) หลังจากบันทึกข้อมูล และจะมีการสร้างรหัสผ่านเริ่มต้นให้',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: Icon(
                        widget.isEditMode
                            ? Icons.save_outlined
                            : Icons.person_add_alt_1_outlined,
                      ),
                      onPressed: _saveDriverData,
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
