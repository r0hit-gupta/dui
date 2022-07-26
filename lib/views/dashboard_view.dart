import 'dart:io';

import 'package:dui/extensions/color.dart';
import 'package:dui/services/file_index_service.dart';
import 'package:dui/views/videos_list.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../colors.dart';
import '../widgets/sidebar.dart';
import 'all_files.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  void _handleSidebarIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  bool isSql = true;

  // final scan = StateNotifierProvider(FileIndexService.provider).scan;
  @override
  Widget build(BuildContext context) {
    final isScanning = ref.watch(FileIndexService.provider).isScanning;
    final hasIndexed =
        ref.watch(FileIndexService.provider).hasBasePath && !isScanning;
    print('aaya ${isScanning}');
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Sidebar(
            currentIndex: _currentIndex,
            onChange: _handleSidebarIndex,
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: AllFiles.c,
                height: 55,
                width: double.infinity,
                child: Row(
                  children: [
                    const Flexible(
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(6),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search files, videos, etc...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        isSql = !isSql;
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutCubic,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: VideosList.c.darken().withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: VideosList.c.darken().withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.swap_horiz,
                              size: 20,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              isSql ? "SQL" : "NoSQL",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "122 ms",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: VideosList.c.darken().withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: VideosList.c.darken().withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _scanFolder,
                            child: Icon(
                              Icons.create_new_folder,
                              size: 20,
                              color: Colors.blue.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: isScanning || !hasIndexed
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isScanning
                              ? Lottie.asset(
                                  'assets/lottie/scanning.json',
                                  width: 300,
                                )
                              : Opacity(
                                  opacity: 0.8,
                                  child: Image.asset(
                                    "assets/bg/scan.png",
                                    width: 300,
                                  ),
                                ),

                          GestureDetector(
                            onTap: _scanFolder,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: KColors.accent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${isScanning ? "" : "BEGIN "}SCANNING',
                                      style: const TextStyle(
                                        color: Color(0xff098ff1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          // space
                          const SizedBox(height: 12),
                          const Text(
                            'Please select a folder to scan, it may take a while to scan big folders',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer()
                        ],
                      )
                    : IndexedStack(
                        index: _currentIndex,
                        children: const [
                          AllFiles(),
                          VideosList(),
                        ],
                      ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  void _scanFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      final x = await Directory(selectedDirectory).resolveSymbolicLinks();
      ref.read(FileIndexService.provider).setBasePath(x);
      ref.read(FileIndexService.provider).index(x);
    }
  }
}
