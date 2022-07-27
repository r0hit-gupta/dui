// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/node.dart';

class SQLService extends ChangeNotifier {
  static final provider = ChangeNotifierProvider<SQLService>((_) {
    return SQLService();
  });

  bool isNoSql = false;

  void changeDatabase() {
    isNoSql = !isNoSql;
    timeTaken = null;
    notifyListeners();
  }

  bool isinit = false;

  Duration? timeTaken;

  Future<void> init() async {
    const createTable = """
    CREATE TABLE IF NOT EXISTS nodes (
      id INTEGER PRIMARY KEY,
      name TEXT,
      path TEXT,
      size INTEGER,
      depth INTEGER,
      isDirectory INTEGER,
      parentId INTEGER,
      isFile INTEGER,
      isSymlink INTEGER,
      isHidden INTEGER,
      isExecutable INTEGER,
      isReadable INTEGER,
      isWritable INTEGER,
      isReadOnly INTEGER,
      isArchive INTEGER,
      isSystem INTEGER,
      isTemporary INTEGER,
      """;
  }

  // save node to database
  Future<void> save(List<Node> nodes) async {
    final query = """
    INSERT INTO nodes (
      id,
      name,
      path,
      size,
      isDirectory,
      parentId,
      isFile,
      isSymlink,
      isHidden,
      isExecutable,
      isReadable,
      isWritable,
      isReadOnly,
      isArchive,
      isSystem,
      isTemporary
    ) VALUES ($nodes.deserialize())
    """;
  }

  Future getFiles(String path, {int depth = 4}) async {
    // query to return nodes with path starting with path
    final query = """
    SELECT * FROM nodes WHERE path LIKE '$path%' 
    AND DEPTH <= $depth
    """;
  }

  // get all videos from database
  Future getVideos() async {
    await init();

    // list of all video file extensions
    final videoExt = [
      ".3g2",
      ".3gp",
      ".aaf",
      ".asf",
      ".avchd",
      ".avi",
      ".drc",
      ".flv",
      ".m2v",
      ".m3u8",
      ".m4p",
      ".m4v",
      ".mkv",
      ".mng",
      ".mov",
      ".mp2",
      ".mp4",
      ".mpe",
      ".mpeg",
      ".mpg",
      ".mpv",
      ".mxf",
      ".nsv",
      ".ogg",
      ".ogv",
      ".qt",
      ".rm",
      ".rmvb",
      ".roq",
      ".svi",
      ".vob",
      ".webm",
      ".wmv",
      ".yuv"
    ];

    // query to return nodes with path ending with videoExt
    final query = """
    SELECT * FROM nodes WHERE extension LIKE '%$videoExt'
    """;
  }

  Future<void> clear() async {
    const query = """
    DELETE FROM nodes WHERE 1
    """;
  }
}
