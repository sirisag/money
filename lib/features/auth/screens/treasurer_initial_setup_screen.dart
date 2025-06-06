import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/auth_notifier.dart'; // Import your AuthNotifier
import '../../../data/models/app_user.dart'; // Import UserRole
import '../../../core/navigation/app_router.dart'; // Import AppRouter

class TreasurerInitialSetupScreen extends ConsumerStatefulWidget {
  const TreasurerInitialSetupScreen({super.key});

  @override
  ConsumerState<TreasurerInitialSetupScreen> createState() =>
      _TreasurerInitialSetupScreenState();
}

class _TreasurerInitialSetupScreenState
    extends ConsumerState<TreasurerInitialSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _primaryIdController = TextEditingController();
  final _secondaryIdController =
      TextEditingController(); // Optional for treasurer
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _primaryIdController.dispose();
    _secondaryIdController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _performSetup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Note on secondaryId:
      // Currently, if secondaryId is empty, primaryId is used.
      // Given that AppUser.secondaryId is marked unique in the schema,
      // ensure this logic aligns with your uniqueness requirements for IDs.
      // If secondaryId for Treasurer is truly optional and can be different
      // or non-existent, the model and this logic might need adjustment.
      final String secondaryIdValue = _secondaryIdController.text.isNotEmpty
          ? _secondaryIdController.text
          : _primaryIdController.text;

      final success = await ref
          .read(authNotifierProvider.notifier)
          .performInitialSetup(
            primaryId: _primaryIdController.text,
            secondaryId: secondaryIdValue,
            password: _passwordController.text,
            role: UserRole.treasurer,
            displayName: _displayNameController.text,
          );

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // Check if the widget is still in the tree
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ตั้งค่าไวยาวัจกรณ์สำเร็จ! กรุณาเข้าสู่ระบบ'),
            ),
          );
          // Navigate to Login Screen and remove all previous routes from the stack
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'ตั้งค่าไม่สำเร็จ: ID อาจซ้ำกัน หรือเกิดข้อผิดพลาด',
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ตั้งค่าไวยาวัจกรณ์')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _primaryIdController,
                decoration: const InputDecoration(
                  labelText: 'Primary ID (4 หลัก)',
                  hintText: 'เช่น 0001',
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก Primary ID';
                  }
                  if (value.length != 4) {
                    return 'Primary ID ต้องมี 4 หลัก';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Primary ID ต้องเป็นตัวเลขเท่านั้น';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _secondaryIdController,
                decoration: const InputDecoration(
                  labelText: 'Secondary ID (4 หลัก, ถ้ามี)',
                  hintText: 'เช่น 0002 (ถ้าไม่กรอกจะใช้ Primary ID แทน)',
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length != 4) {
                      return 'Secondary ID ต้องมี 4 หลัก (ถ้ากรอก)';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Secondary ID ต้องเป็นตัวเลขเท่านั้น (ถ้ากรอก)';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'ชื่อที่ใช้แสดงผล',
                  hintText: 'เช่น ชื่อ-นามสกุล หรือชื่อเรียก',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อที่ใช้แสดงผล';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรหัสผ่าน';
                  }
                  if (value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'ยืนยันรหัสผ่าน'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณายืนยันรหัสผ่าน';
                  }
                  if (value != _passwordController.text) {
                    return 'รหัสผ่านไม่ตรงกัน';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _performSetup,
                      child: const Text('ตั้งค่าบัญชีไวยาวัจกรณ์'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
