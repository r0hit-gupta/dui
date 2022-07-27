import 'package:dui/colors.dart';
import 'package:dui/extensions/color.dart';
import 'package:dui/services/no_sql.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/node.dart';

class ListPane extends ConsumerStatefulWidget {
  const ListPane({
    Key? key,
    required this.nodes,
    this.onDoubleTap,
  }) : super(key: key);

  final List<Node> nodes;
  final Function(Node)? onDoubleTap;

  @override
  ConsumerState<ListPane> createState() => _ListPaneState();
}

class _ListPaneState extends ConsumerState<ListPane> {
  final List<Node> nodes = [];

  @override
  Widget build(BuildContext context) {
    final nodes = widget.nodes;
    final deletedNodes = ref.watch(NoSQLService.provider).nodesToDelete;
    return Material(
      color: Colors.white,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: nodes.length,
          itemBuilder: (context, index) {
            final node = nodes[index];
            final isDeleted = deletedNodes.contains(node);
            return Draggable<Node>(
              data: node,
              feedback: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Row(children: [
                    Icon(
                      node.isDirectory ? Icons.folder : Icons.insert_drive_file,
                      color: node.isDirectory
                          ? KColors.accent.darken(.2)
                          : Colors.grey.shade300,
                    ),
                    const SizedBox(width: 16),
                    Text(node.name + (node.ext ?? '')),
                    const SizedBox(width: 16),
                    Text(
                      node.formattedSize,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
                  // trailing: Text(
                  //   node.formattedSize,
                  //   style: const TextStyle(fontWeight: FontWeight.bold),
                  // ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      hoverColor: KColors.accent,
                      tileColor: isDeleted ? Colors.grey.shade100 : null,
                      leading: Icon(
                        node.isDirectory
                            ? Icons.folder
                            : Icons.insert_drive_file,
                        color: isDeleted
                            ? Colors.grey.shade300
                            : node.isDirectory
                                ? KColors.accent.darken(.2)
                                : Colors.grey.shade300,
                      ),
                      title: Text(node.name + (node.ext ?? ''),
                          style: TextStyle(
                            color: isDeleted ? Colors.grey : null,
                            decoration:
                                isDeleted ? TextDecoration.lineThrough : null,
                          )),
                      dense: true,
                      trailing: Text(node.formattedSize,
                          style: TextStyle(
                            color: isDeleted ? Colors.grey : null,
                            fontWeight: FontWeight.bold,
                            decoration:
                                isDeleted ? TextDecoration.lineThrough : null,
                          )),
                      onTap: () {
                        widget.onDoubleTap?.call(node);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
