import 'package:dui/views/videos_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Sidebar(
            currentIndex: _currentIndex,
            onChange: _handleSidebarIndex,
          ),
          Expanded(
              child: IndexedStack(
            index: _currentIndex,
            children: const [
              AllFiles(),
              VideosList(),
            ],
          )),
        ],
      ),
    );
  }
}
