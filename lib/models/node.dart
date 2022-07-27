import 'dart:async';
import 'dart:io';
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

  bool? verifyDirectory;

  bool get isDirectory => ext == null || fullPath.endsWith('/') || ext!.isEmpty;

  String get formattedSize => getFormattedSize(size);

  @override
  String toString() => fullPath + ' (${size} bytes)' + modifiedDate.toString();

  DateTime? modifiedDate;

  // Future getModifiedDate() async {
  //   print("Getting modified date for $fullPath");
  //   await Directory.fromUri(Uri.parse(fullPath)).stat().then((stat) {
  //     verifyDirectory = stat.type == FileSystemEntityType.directory;
  //     modifiedDate = stat.modified;
  //   }).catchError((e) {
  //     isExist = false;
  //   });
  // }

  // Directory get directory => Directory.fromUri(Uri.parse(fullPath));

  bool? isExist;
  // Future<bool> exists() async {
  //   return await directory.exists();
  // }

  // hashcode
  @override
  int get hashCode => fullPath.hashCode;

  Node({
    required this.size,
    required this.fullPath,
  })  : parentPath = p.dirname(fullPath),
        name = p.basenameWithoutExtension(fullPath),
        depth = fullPath.split('/').length,
        ext = p.extension(fullPath);

  @override
  bool operator ==(Object other) {
    return other is Node && fullPath == other.fullPath;
  }
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
  final Color color;

  Item({
    required this.name,
    required this.size,
    required this.color,
    this.children = const [],
  });

  // Color get color => getRandomColor();
}

// function to return random solid color
Color getRandomColor() {
  return Color(
    0xFF222222 | (Random().nextInt(0xDDDDDD) << 8) | Random().nextInt(0xDDDDDD),
  );
}

extension Helpers on Iterable<Node> {
  List<Node> sortBySizeDesc() {
    return toList()..sort((a, b) => b.size.compareTo(a.size));
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
          name: n.fullName,
          size: n.size / totalSize,
          color: getRandomColor(),
        )).toList();
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
