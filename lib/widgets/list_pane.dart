import 'package:dui/colors.dart';
import 'package:dui/extensions/color.dart';
import 'package:flutter/material.dart';

import '../models/node.dart';

class ListPane extends StatefulWidget {
  const ListPane({Key? key, required this.nodes, this.onDoubleTap})
      : super(key: key);

  final List<Node> nodes;
  final Function(Node)? onDoubleTap;

  @override
  State<ListPane> createState() => _ListPaneState();
}

class _ListPaneState extends State<ListPane> {
  @override
  Widget build(BuildContext context) {
    final nodes = widget.nodes;
    return Material(
      color: Colors.white,
      child: ListView.builder(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          final node = nodes[index];
          return ListTile(
            hoverColor: KColors.accent,
            leading: Icon(
              node.isDirectory ? Icons.folder : Icons.insert_drive_file,
              color: node.isDirectory
                  ? KColors.accent.darken(.2)
                  : Colors.grey.shade300,
            ),
            title: Text(node.name + (node.ext ?? '')),
            dense: true,
            trailing: Text(node.formattedSize,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              widget.onDoubleTap?.call(node);
            },
          );
        },
      ),
    );
  }
}
