import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/node.dart';
import 'no_sql.dart';

class FileIndexService extends ChangeNotifier {
  final Reader read;

  static final provider = ChangeNotifierProvider<FileIndexService>((ref) {
    return FileIndexService(ref.read);
  });

  List<Node> parsedNodes = [];

  bool _isScanning = false;

  bool get isScanning => _isScanning;

  set isScanning(bool isScanning) {
    _isScanning = isScanning;
    notifyListeners();
  }

  String? basePath;

  bool get hasBasePath => basePath != null && basePath!.isNotEmpty;

  void setBasePath(String path) {
    log("PATH SELECtED: $path");
    basePath = path;
  }

  // static String get currentPath => "/Users/rohit/Documents";

  FileIndexService(this.read);

  Future<void> index(String path) async {
    isScanning = true;

    clear();
    await read(NoSQLService.provider).init();
    final start = DateTime.now();
    final p = await Process.start(
      '/bin/sh',
      ['-c', 'du -a ~+'],
      workingDirectory: path,
      runInShell: true,
    );
    final task = utf8.decodeStream(p.stdout).then(processStdout);

    await task.whenComplete(() async {
      final end = DateTime.now();
      log('time taken: ${end.difference(start).inMilliseconds}');
      log('Total Nodes = ${parsedNodes.length}');
      await read(NoSQLService.provider).save(parsedNodes);
      log('Saved');
      isScanning = false;
    });
  }

  Future<void> clear() async {
    parsedNodes.clear();
    await read(NoSQLService.provider).clear();
  }

  void processStdout(String l) {
    List<String> lines = l.split('\n');
    for (String line in lines) {
      List<String> sline = line.split('\t');
      if (sline.isNotEmpty && sline.length > 1) {
        final n = Node(fullPath: sline[1], size: int.tryParse(sline[0]) ?? 8);
        parsedNodes.add(n);
      }
    }
  }
}
