import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/node.dart';
import 'sql.dart';

class FileIndexService {
  final Reader read;

  static final provider = Provider<FileIndexService>((ref) {
    return FileIndexService(ref.read);
  });

  List<Node> parsedNodes = [];

  // static String get currentPath => "/Users/rohit/Documents";

  FileIndexService(this.read);

  Future<void> index(String path) async {
    clear();
    await read(SQLService.provider).init();
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
      await read(SQLService.provider).save(parsedNodes);
      log('Saved');
    });
  }

  Future<void> clear() async {
    parsedNodes.clear();
    await read(SQLService.provider).clear();
  }

  void processStdout(String l) {
    log('parsong: ');
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
