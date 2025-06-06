import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/core/navigation/app_router.dart';
import 'package:money/features/treasurer/screens/monk_management/monk_add_edit_screen.dart'; // For MonkFormMode
import 'package:money/features/treasurer/notifiers/monk_account_notifier.dart';
import 'package:intl/intl.dart'; // For number formatting

class MonkListScreen extends ConsumerStatefulWidget {
  const MonkListScreen({super.key});

  @override
  ConsumerState<MonkListScreen> createState() => _MonkListScreenState();
}

class _MonkListScreenState extends ConsumerState<MonkListScreen> {
  String _searchQuery = '';
  String _selectedStatusFilter =
      'ทั้งหมด'; // "ทั้งหมด", "ใช้งานอยู่", "ย้ายวัด", "ลาสิกขา"

  // Helper to format balance
  final _numberFormat = NumberFormat("#,##0", "en_US");

  List<MonkProfile> _filterMonks(List<MonkProfile> allMonks) {
    List<MonkProfile> monksToFilter = List.from(allMonks);

    if (_selectedStatusFilter != 'ทั้งหมด') {
      MonkAccountStatus? statusEnum;
      try {
        statusEnum = MonkAccountStatus.values.firstWhere(
          (e) => e.displayName == _selectedStatusFilter,
        );
      } catch (e) {
        // Handle case where displayName might not match enum (should not happen with current setup)
      }
      monksToFilter = monksToFilter
          .where((monk) => monk.status == statusEnum)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      monksToFilter = monksToFilter
          .where(
            (monk) =>
                (monk.nameOrTitle?.toLowerCase() ?? '').contains(
                  _searchQuery.toLowerCase(),
                ) ||
                monk.monkPrimaryId.contains(_searchQuery),
          )
          .toList();
    }
    return monksToFilter;
  }

  @override
  Widget build(BuildContext context) {
    final monkAccountState = ref.watch(monkAccountNotifierProvider);
    final allMonks = monkAccountState.monks;
    final displayedMonks = _filterMonks(allMonks);

    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการบัญชีพระ'),
        // Optional: Add actions like search or filter if not in body
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาพระ (ชื่อ หรือ ID)...',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ตัวกรองสถานะ:', style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: _selectedStatusFilter,
                  items:
                      [
                        'ทั้งหมด',
                        ...MonkAccountStatus.values.map((e) => e.displayName),
                      ].map((String displayName) {
                        return DropdownMenuItem<String>(
                          value: displayName,
                          child: Text(displayName),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatusFilter = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: monkAccountState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : monkAccountState.errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'เกิดข้อผิดพลาด: ${monkAccountState.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                : displayedMonks.isEmpty
                ? Center(
                    child: Text(
                      _searchQuery.isEmpty && _selectedStatusFilter == 'ทั้งหมด'
                          ? 'ยังไม่มีข้อมูลพระในระบบ\nกดปุ่ม + เพื่อเพิ่มพระใหม่'
                          : 'ไม่พบข้อมูลพระที่ตรงกับการค้นหา/ตัวกรอง',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    itemCount: displayedMonks.length,
                    itemBuilder: (context, index) {
                      final monk = displayedMonks[index];
                      final balanceString =
                          "${_numberFormat.format(monk.currentBalance)} บาท";
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              monk.nameOrTitle != null &&
                                      monk.nameOrTitle!.isNotEmpty
                                  ? monk.nameOrTitle![0]
                                  : '?',
                            ),
                          ),
                          title: Text(monk.nameOrTitle ?? 'N/A'),
                          subtitle: Text(
                            'ID: ${monk.monkPrimaryId} | สถานะ: ${monk.status.displayName}',
                          ),
                          trailing: Text(
                            balanceString,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: monk.currentBalance < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                          onTap: () {
                            // Navigate to Detail screen
                            Navigator.pushNamed(
                              context,
                              AppRoutes.treasurerMonkDetail,
                              arguments: monk, // Pass the MonkProfile object
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
            AppRoutes.treasurerMonkAddEdit,
            arguments: {'mode': MonkFormMode.add},
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('เพิ่มพระใหม่'),
      ),
    );
  }
}
