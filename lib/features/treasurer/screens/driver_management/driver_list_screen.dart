import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/core/navigation/app_router.dart';
import 'package:money/features/treasurer/notifiers/driver_account_notifier.dart';
// import 'package:money/features/treasurer/screens/driver_management/driver_add_edit_screen.dart'; // For form mode
import 'package:intl/intl.dart';

class DriverListScreen extends ConsumerStatefulWidget {
  const DriverListScreen({super.key});

  @override
  ConsumerState<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends ConsumerState<DriverListScreen> {
  String _searchQuery = '';
  // Add filters if needed, e.g., by status if drivers have statuses

  final _numberFormat = NumberFormat("#,##0", "en_US");

  List<DriverProfile> _filterDrivers(List<DriverProfile> allDrivers) {
    List<DriverProfile> driversToFilter = List.from(allDrivers);

    if (_searchQuery.isNotEmpty) {
      driversToFilter = driversToFilter
          .where(
            (driver) =>
                (driver.name?.toLowerCase() ?? '').contains(
                  _searchQuery.toLowerCase(),
                ) ||
                driver.driverPrimaryId.contains(_searchQuery),
          )
          .toList();
    }
    return driversToFilter;
  }

  @override
  Widget build(BuildContext context) {
    final driverAccountState = ref.watch(driverAccountNotifierProvider);
    final allDrivers = driverAccountState.drivers;
    final displayedDrivers = _filterDrivers(allDrivers);

    return Scaffold(
      appBar: AppBar(title: const Text('จัดการบัญชีคนขับรถ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาคนขับรถ (ชื่อ หรือ ID)...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Add filter dropdowns here if needed
          Expanded(
            child: driverAccountState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : driverAccountState.errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'เกิดข้อผิดพลาด: ${driverAccountState.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                : displayedDrivers.isEmpty
                ? Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? 'ยังไม่มีข้อมูลคนขับรถในระบบ\nกดปุ่ม + เพื่อเพิ่มคนขับรถใหม่'
                          : 'ไม่พบข้อมูลคนขับรถที่ตรงกับการค้นหา',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    itemCount: displayedDrivers.length,
                    itemBuilder: (context, index) {
                      final driver = displayedDrivers[index];
                      final advanceString =
                          "${_numberFormat.format(driver.travelAdvanceBalance)} บาท"; // Corrected field name
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              driver.name != null && driver.name!.isNotEmpty
                                  ? driver.name![0]
                                  : '?',
                            ),
                          ),
                          title: Text(driver.name ?? 'N/A'),
                          subtitle: Text(
                            'ID: ${driver.driverPrimaryId} | เงินสำรอง: $advanceString',
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.treasurerDriverDetail,
                              arguments: driver,
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.treasurerDriverAddEdit,
            arguments: {'isEditMode': false},
          );
        },
        icon: const Icon(Icons.person_add_alt_1_outlined),
        label: const Text('เพิ่มคนขับรถใหม่'),
      ),
    );
  }
}
