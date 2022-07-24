import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;

part 'node.g.dart';

@Collection()
class Node {
  int id = Isar.autoIncrement;

  final int size;

  final String parentPath;

  final String name;
  final String? ext;
  final int depth;

  @Index(unique: true, caseSensitive: false)
  final String fullPath;

  String get fullName => name + (ext ?? '');

  bool get isDirectory => ext == null || fullPath.endsWith('/') || ext!.isEmpty;

  String get formattedSize => getFormattedSize(size);

  @override
  String toString() => fullPath;

  Node({
    required this.size,
    required this.fullPath,
  })  : parentPath = p.dirname(fullPath),
        name = p.basenameWithoutExtension(fullPath),
        depth = fullPath.split('/').length,
        ext = p.extension(fullPath);
}

String getFormattedSize(int size) {
  int bytes = size * 512;
  int decimals = 1;
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1000)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

class Item {
  final String name;
  final double size;
  final List<Item> children;
  final color = getRandomColor();

  Item(this.name, this.size, [this.children = const []]);

  // Color get color => getRandomColor();
}

// function to return random solid color
Color getRandomColor() {
  return Color(
    0xFF000000 | (Random().nextInt(0xDDDDDD) << 8) | Random().nextInt(0xDDDDDD),
  );
}

extension Helpers on List<Node> {
  List<Node> sortBySizeDesc() {
    return this..sort((a, b) => b.size.compareTo(a.size));
  }

  int get totalSize {
    return fold(0, (sum, node) => sum + node.size);
  }

  String get formattedSize {
    return getFormattedSize(totalSize);
  }

  // convert to Item
  List<Item> toItems() {
    return map((n) => Item(
          n.fullName,
          n.size / totalSize,
        )).toList();
  }
}

// returns fake item data with sizes that add up to 1
final data = [
  Item(
    "root",
    0.8,
    [
      Item(
        "A",
        0.3,
        [
          Item(
            "A1",
            0.2,
            [
              Item(
                "A",
                0.3,
                [
                  Item("A1", 0.2),
                  Item(
                    "A2",
                    0.8,
                  ),
                ],
              ),
              Item(
                "B",
                0.7,
                [
                  Item("B1", 0.4),
                  Item("B2", 0.6),
                ],
              ),
            ],
          ),
          Item("A2", 0.8),
        ],
      ),
      Item(
        "B",
        0.7,
        [
          Item("B1", 0.4),
          Item(
            "B2",
            0.6,
            [
              Item(
                "A",
                0.3,
                [
                  Item("A1", 0.2),
                  Item("A2", 0.8),
                ],
              ),
              Item(
                "B",
                0.7,
                [
                  Item("B1", 0.4),
                  Item("B2", 0.6),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  Item(
    "test",
    0.2,
    [
      Item("A", 0.1),
      Item("A", 0.1),
      Item("A", 0.2),
      Item(
        "B",
        0.6,
        [
          Item(
            "A",
            0.3,
            [
              Item("A1", 0.2),
              Item(
                "A2",
                0.8,
                [
                  Item(
                    "A",
                    0.3,
                    [
                      Item("A1", 0.2),
                      Item("A2", 0.8),
                    ],
                  ),
                  Item(
                    "B",
                    0.7,
                    [
                      Item("B1", 0.4),
                      Item("B2", 0.6),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Item(
            "B",
            0.7,
            [
              Item("B1", 0.4),
              Item("B2", 0.6),
            ],
          ),
        ],
      ),
    ],
  )
];
