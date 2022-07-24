import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/node.dart';

class SQLService {
  static final provider = Provider<SQLService>((_) {
    return SQLService();
  });

  bool isinit = false;

  Isar? isar;

  Future<void> init() async {
    if (!isinit) {
      final dir = await getApplicationSupportDirectory();
      final temp = await dir.createTemp('isar');
      log("AAYA");
      log(temp.path);
      try {
        isar ??= await Isar.open(
          schemas: [NodeSchema],
          directory: temp.path,
          inspector:
              true, // if you want to enable the inspector for debug builds
        );
      } catch (e) {
        print('RRORR');
        print(e);
      }
      isinit = true;

      print(isinit);

      await clear();
    } else {
      log("Already started");
    }
  }

  // save node to database
  Future<void> save(List<Node> nodes) async {
    await init();
    await isar!.writeTxn((isar) async {
      await isar.nodes.putAll(nodes);
    });
  }

  Future<List<Node>> getFiles(String path, {int depth = 4}) async {
    await init();
    int pathDepth = path.split('/').length + depth;
    print("pathDepth");
    print(pathDepth);
    // return [];
    // final n = await isar!.nodes
    //     .filter()
    //     .parentPathStartsWith(path)
    //     // .depthLessThan(pathDepth)
    //     .sortBySizeDesc()
    //     .findAll();

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
    print('Found ${n.length} nodes');
    return n;
  }

  // get all videos from database
  Future<List<Node>> getVideos() async {
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

    // get all videos from database
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
    // final x = await isar!.nodes
    //     .filter()
    //     .extEqualTo('.mp4')
    //     .extEqualTo('.pdf')
    //     .sortBySizeDesc()
    //     .findAll();

    print('videos: ${x.length}');
    return x;
  }

  // clear database
  Future<void> clear() async {
    await isar?.writeTxn((isar) async {
      await isar.nodes.clear();
    });
  }
}
