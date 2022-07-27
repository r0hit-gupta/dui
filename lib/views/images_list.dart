import 'dart:math' hide log;

import 'package:dui/extensions/color.dart';
import 'package:dui/widgets/list_pane.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/node.dart';
import '../services/no_sql.dart';

class ImagesList extends ConsumerStatefulWidget {
  const ImagesList({Key? key}) : super(key: key);
  static const c = Color(0xfff9fafc);
  static const b = Color(0xff00c2ff);

  @override
  ConsumerState<ImagesList> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<ImagesList> {
  final List<Node> nodes = [];

  void _index() async {
    final vids = await ref.read(NoSQLService.provider).getImages();
    nodes.clear();
    nodes.addAll(vids);
    setState(() {});
  }

  // sum of all the nodes sizes
  int get totalSize => nodes.fold(0, (sum, node) => sum + node.size);

  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _index();
  }

  @override
  Widget build(BuildContext context) {
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
                          color: ImagesList.c.darken().withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: ImagesList.c.darken().withOpacity(0.3),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Top 100 Images'),
                              GestureDetector(
                                onTap: _index,
                                child: Icon(Icons.refresh,
                                    color: Colors.grey.withOpacity(0.7)),
                              ),
                            ],
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
                                        nodes: nodes,
                                        onDoubleTap: (node) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(),
                              Expanded(
                                child: Column(children: []),
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
