import 'dart:io';
import 'dart:math' hide log;

import 'package:dui/extensions/color.dart';
import 'package:dui/services/file_index_service.dart';
import 'package:dui/services/sql.dart';
import 'package:dui/widgets/list_pane.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;

import '../models/node.dart';

import '../services/no_sql.dart';
import '../widgets/breadcrumbs.dart';
import '../widgets/sunburst.dart';

class AllFiles extends ConsumerStatefulWidget {
  const AllFiles({Key? key}) : super(key: key);
  static const c = Color(0xfff9fafc);
  static const b = Color(0xff00c2ff);

  @override
  ConsumerState<AllFiles> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<AllFiles>
    with TickerProviderStateMixin {
  late AnimationController _controller = _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  late Animation<double> animation;
  late final Tween<double> _rotationTween = Tween(begin: 0, end: 2 * pi);

  final List<Node> nodes = [];
  final List<Node> curentNodes = [];

  String get basePath => ref.read(FileIndexService.provider).basePath ?? '';

  late String currentPath = basePath;

  // sum of all the nodes sizes
  int get totalSize => nodes.fold(0, (sum, node) => sum + node.size);

  List<Item> items = [];

  // Get the nodes from the database
  void _getNodes(String path) async {
    final res = await ref.read(NoSQLService.provider).getFiles(path, depth: 6);
    currentPath = path;
    nodes.clear();
    nodes.addAll(res);

    curentNodes.clear();
    curentNodes.addAll(res.where((n) => n.parentPath == path));
    curentNodes.sort((a, b) => b.size.compareTo(a.size));

    items = getChildren(currentPath);
    setState(() {});
    _controller.forward(from: 0.0);
  }

  List<Item> getChildren(String path, [Color? nodeColor]) {
    final Color color =
        (nodeColor ?? getRandomColor()).hue(Random().nextInt(20));
    final baseNodes = nodes.where((n) => n.parentPath == path).toList();
    List<Item> bigNodes = [];
    bool hasSmallItem = false;
    baseNodes.forEach((n) {
      final ratio = n.size.toDouble() / baseNodes.totalSize;
      if (ratio > 0.03) {
        bigNodes.add(Item(
          name: n.fullName,
          size: n.size.toDouble() / baseNodes.totalSize,
          children: getChildren(n.fullPath, color),
          color: color,
        ));
      } else if (!hasSmallItem) {
        bigNodes.add(Item(
          name: n.fullName,
          size: 0.05,
          color: Colors.grey.shade300,
        ));
        hasSmallItem = true;
      }
    });
    return bigNodes;
  }

  // init animation
  void animate() {
    animation = _rotationTween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  Widget build(BuildContext context) {
    final searchNodes = ref.watch(NoSQLService.provider).searchResults;
    final isSearching = searchNodes != null;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AllFiles.c.darken().withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: AllFiles.c.darken().withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: isSearching
                              ? const Text('Search Results')
                              : Breadcrumbs(
                                  crumbs: p.split(currentPath),
                                  onCrumbTap: (path) {
                                    _getNodes(path);
                                  },
                                ),
                        ),
                        const Divider(),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListPane(
                                        nodes: isSearching
                                            ? searchNodes
                                            : curentNodes,
                                        onDoubleTap: (node) {
                                          if (node.isDirectory) {
                                            _getNodes(node.fullPath);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(),
                              if (!isSearching)
                                Expanded(
                                  child: Column(children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Align(
                                            child: Text(
                                              curentNodes.formattedSize,
                                              style: const TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: SunburstChart(
                                              items: items,
                                              animation: animation,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
