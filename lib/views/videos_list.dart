import 'dart:math' hide log;

import 'package:dui/extensions/color.dart';
import 'package:dui/widgets/list_pane.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/node.dart';
import '../services/sql.dart';
import '../widgets/sunburst.dart';

class VideosList extends ConsumerStatefulWidget {
  const VideosList({Key? key}) : super(key: key);
  static const c = Color(0xfff9fafc);
  static const b = Color(0xff00c2ff);

  @override
  ConsumerState<VideosList> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<VideosList>
    with TickerProviderStateMixin {
  late AnimationController _controller = _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  late Animation<double> animation;
  late final Tween<double> _rotationTween = Tween(begin: 0, end: 2 * pi);

  final List<Node> nodes = [];

  String currentPath = "/Users/rohit/Documents";

  void _index() async {
    final vids = await ref.read(SQLService.provider).getVideos();
    // print(vids.length);
    nodes.clear();
    nodes.addAll(vids);
    setState(() {});
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
    setState(() {});
    items = await Future.wait(nodes.map((n) async {
      final children = await ref.read(SQLService.provider).getFiles(n.fullPath);
      return Item(
        n.fullName,
        n.size.toDouble() / totalSize,
        children.toItems(),
      );
    }).toList());
    _controller.forward(from: 0.0);
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
                  color: VideosList.c,
                  height: 40,
                ),
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
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text('All Videos'),
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
                                        nodes: nodes,
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
