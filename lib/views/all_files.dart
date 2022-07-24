import 'dart:math' hide log;

import 'package:dui/extensions/color.dart';
import 'package:dui/services/file_index_service.dart';
import 'package:dui/widgets/list_pane.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;

import '../models/node.dart';
import '../services/sql.dart';
import '../widgets/breadcrumbs.dart';
import '../widgets/sunburst.dart';

enum DbType { sql, nosql }

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

  // Default DbType is sql.
  DbType dbType = DbType.sql;
  bool isSql = true;

  String currentPath = "/Users/piyushmehta/Downloads/";

  void _index() async {
    await ref.read(FileIndexService.provider).index(currentPath);
    _getNodes(currentPath);
  }

  // sum of all the nodes sizes
  int get totalSize => nodes.fold(0, (sum, node) => sum + node.size);

  List<Item> items = [];

  // Get the nodes from the database
  void _getNodes(String path) async {
    final res = await ref.read(SQLService.provider).getFiles(path);
    currentPath = path;
    nodes.clear();
    nodes.addAll(res);

    curentNodes.clear();
    curentNodes.addAll(res.where((n) => n.parentPath == path));
    curentNodes.sortBySizeDesc();

    items = getChildren(currentPath);
    setState(() {});
    _controller.forward(from: 0.0);
  }

  List<Item> getChildren(String path) {
    final baseNodes = nodes.where((n) => n.parentPath == path).toList();
    return baseNodes.map((n) {
      return Item(
        n.fullName,
        n.size.toDouble() / baseNodes.totalSize,
        getChildren(n.fullPath),
      );
    }).toList();
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _index(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                    color: AllFiles.c,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            Text(
                              dbType == DbType.sql ? "SQL" : "NoSQL",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Switch(
                              value: isSql,
                              onChanged: (value) {
                                setState(() {
                                  isSql = value;
                                  dbType = value ? DbType.sql : DbType.nosql;
                                });

                                print(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                const Divider(),
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
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Breadcrumbs(
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
                                        nodes: curentNodes,
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
                              Expanded(
                                child: Column(children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Align(
                                          child: Text(
                                            nodes.formattedSize,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
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
