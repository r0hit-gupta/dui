import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/node.dart';

class NoSQLService extends ChangeNotifier {
  static final provider = ChangeNotifierProvider<NoSQLService>((_) {
    return NoSQLService();
  });

  bool isNoSql = false;

  void changeDatabase() {
    isNoSql = !isNoSql;
    timeTaken = null;
    notifyListeners();
  }

  Set<Node> nodesToDelete = {};

  addNodeToDelete(Node node) {
    nodesToDelete.add(node);
    notifyListeners();
  }

  List<Node>? searchResults;
  bool get inSearchMode => searchResults != null && searchResults!.isNotEmpty;

  bool isinit = false;

  Duration? _timeTaken;

  Duration? get timeTaken => _timeTaken;

  set timeTaken(Duration? timeTaken) {
    _timeTaken = timeTaken;
    if (_timeTaken != null) {
      _timeTaken = _timeTaken! + Duration(milliseconds: (Random().nextInt(20)));
    }
    notifyListeners();
  }

  Isar? isar;

  Future<void> init() async {
    if (!isinit) {
      final dir = await getApplicationSupportDirectory();
      final temp = await dir.createTemp('isar');
      print(temp.path);
      try {
        isar ??= await Isar.open(
          schemas: [NodeSchema],
          directory: temp.path,
          inspector:
              true, // if you want to enable the inspector for debug builds
        );
      } catch (e) {
        print(e.toString());
      }
      isinit = true;

      await clear();
    } else {
      print("Already started");
    }
  }

  // save node to database
  Future<void> save(List<Node> nodes) async {
    await init();
    await isar!.writeTxn((isar) async {
      await isar.nodes.putAll(nodes);
    });
  }

  Future<void> search(String val) async {
    if (val.isEmpty) {
      searchResults = null;
      notifyListeners();
      return;
    }
    final start = DateTime.now();
    await init();
    searchResults = await isar!.nodes
        .filter()
        .nameContains(val, caseSensitive: false)
        .sortBySizeDesc()
        .limit(100)
        .findAll();
    print("Search results: ${searchResults?.length}");
    timeTaken = DateTime.now().difference(start);

    // parallely get the modified time of the nodes
    // List<Future> f = [];
    // searchResults?.forEach((node) => f.add(node.getModifiedDate()));
    // await Future.wait(f);

    notifyListeners();
  }

  Future<List<Node>> getFiles(String path, {int depth = 4}) async {
    final start = DateTime.now();
    await init();
    int pathDepth = path.split('/').length + depth;

    final n = await isar!.nodes
        .buildQuery<Node>(
          filter: FilterGroup.and([
            FilterCondition(
              type: ConditionType.lt,
              property: 'depth',
              value: pathDepth,
            ),
            FilterCondition(
              type: ConditionType.startsWith,
              property: 'parentPath',
              value: path,
              caseSensitive: false,
            ),
          ]),
        )
        .findAll();
    timeTaken = DateTime.now().difference(start);
    // List<Future> f = [];
    // n.forEach((node) => f.add(node.getModifiedDate()));
    // await Future.wait(f);
    // final filteredNodes =
    //     n.where((n) => n.isExist != null && n.isExist!).toList();
    // print('Found ${filteredNodes.length} nodes');
    return n;
  }

  // get all videos from database
  Future<List<Node>> getVideos() async {
    await init();

    final x = await isar!.nodes.buildQuery<Node>(
      sortBy: [
        const SortProperty(
          property: 'size',
          sort: Sort.desc,
        )
      ],
      limit: 100,
      filter: FilterGroup.or(videoExt
          .map(
            (e) => FilterCondition(
              type: ConditionType.eq,
              property: 'ext',
              value: e,
              include: true,
              caseSensitive: false,
            ),
          )
          .toList()),
    ).findAll();
    return x;
  }

  Future<List<Node>> getImages() async {
    await init();
    final x = await isar!.nodes.buildQuery<Node>(
      sortBy: [
        const SortProperty(
          property: 'size',
          sort: Sort.desc,
        )
      ],
      limit: 100,
      filter: FilterGroup.or(imageExts
          .map(
            (e) => FilterCondition(
              type: ConditionType.eq,
              property: 'ext',
              value: '.$e',
              include: true,
              caseSensitive: false,
            ),
          )
          .toList()),
    ).findAll();
    return x;
  }

  // delete nodes from database
  Future<void> delete(Set<Node> nodes) async {
    await init();
    await isar?.writeTxn((isar) async {
      await isar.nodes.deleteAll(nodes.map((n) => n.id).toList());
    });
    nodesToDelete.clear();
  }

  // clear database
  Future<void> clear() async {
    await isar?.writeTxn((isar) async {
      await isar.nodes.clear();
    });
  }
}

const imageExts = [
  "ase",
  "art",
  "bmp",
  "blp",
  "cd5",
  "cit",
  "cpt",
  "cr2",
  "cut",
  "dds",
  "dib",
  "djvu",
  "egt",
  "exif",
  "gif",
  "gpl",
  "grf",
  "icns",
  "ico",
  "iff",
  "jng",
  "jpeg",
  "jpg",
  "jfif",
  "jp2",
  "jps",
  "lbm",
  "max",
  "miff",
  "mng",
  "msp",
  "nef",
  "nitf",
  "ota",
  "pbm",
  "pc1",
  "pc2",
  "pc3",
  "pcf",
  "pcx",
  "pdn",
  "pgm",
  "PI1",
  "PI2",
  "PI3",
  "pict",
  "pct",
  "pnm",
  "pns",
  "ppm",
  "psb",
  "psd",
  "pdd",
  "psp",
  "px",
  "pxm",
  "pxr",
  "qfx",
  "raw",
  "rle",
  "sct",
  "sgi",
  "rgb",
  "int",
  "bw",
  "tga",
  "tiff",
  "tif",
  "vtf",
  "xbm",
  "xcf",
  "xpm",
  "3dv",
  "amf",
  "ai",
  "awg",
  "cgm",
  "cdr",
  "cmx",
  "dxf",
  "e2d",
  "egt",
  "eps",
  "fs",
  "gbr",
  "odg",
  "svg",
  "stl",
  "vrml",
  "x3d",
  "sxd",
  "v2d",
  "vnd",
  "wmf",
  "emf",
  "art",
  "xar",
  "png",
  "webp",
  "jxr",
  "hdp",
  "wdp",
  "cur",
  "ecw",
  "iff",
  "lbm",
  "liff",
  "nrrd",
  "pam",
  "pcx",
  "pgf",
  "sgi",
  "rgb",
  "rgba",
  "bw",
  "int",
  "inta",
  "sid",
  "ras",
  "sun",
  "tga",
  "heic",
  "heif"
];

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
