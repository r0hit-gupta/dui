import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:dui/colors.dart';
import 'package:dui/extensions/build_context_ext.dart';
import 'package:dui/extensions/color.dart';
import 'package:dui/services/no_sql.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../models/node.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({
    Key? key,
    required this.currentIndex,
    required this.onChange,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onChange;

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar>
    with TickerProviderStateMixin {
  Set<Node> nodesToDelete = {};

  int get numOfFolders =>
      nodesToDelete.where((node) => node.isDirectory).length;
  int get numOfFiles => nodesToDelete.where((node) => !node.isDirectory).length;
  bool isHover = false;

  bool isDeleting = false;

  late final _animationController = AnimationController(
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    nodesToDelete = ref.watch(NoSQLService.provider).nodesToDelete;
    return Stack(
      children: [
        Container(
          width: min(context.width * 0.25, 250),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            // blue gradient to bottom
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.withOpacity(0.2),
                Colors.blue.withOpacity(0.65),
              ],
            ),
            border: Border(
              right: BorderSide(
                color: Colors.grey.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Column(children: [
            const Logo(),
            OptionLink(
              icon: Icons.add_home_work_outlined,
              title: 'Home',
              isActive: widget.currentIndex == 0,
              onTap: () => widget.onChange(0),
            ),
            OptionLink(
              icon: Icons.video_collection_outlined,
              title: 'Videos',
              isActive: widget.currentIndex == 1,
              onTap: () => widget.onChange(1),
            ),
            OptionLink(
              icon: Icons.image_outlined,
              title: 'Images',
              isActive: widget.currentIndex == 2,
              onTap: () => widget.onChange(2),
            ),
          ]),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          right: -100,
          child: AnimatedOpacity(
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 300),
            opacity: isHover ? 0.3 : 0,
            child: Image.asset(
              'assets/bg/bg.png',
              fit: BoxFit.fitWidth,
              width: 500,
              height: 300,
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          left: 0,
          right: 0,
          child: Lottie.asset(
            'assets/lottie/confetti.json',
            controller: _animationController,
            onLoaded: (composition) {
              _animationController.duration = composition.duration;
            },
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DragTarget<Node>(
              builder: (context, candidateItems, rejectedItems) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (nodesToDelete.isNotEmpty) ...[
                        Text(
                          nodesToDelete.formattedSize,
                          style: const TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${nodesToDelete.length} items | $numOfFolders folders, $numOfFiles file',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isDeleting = true;
                            });
                            await ref
                                .read(NoSQLService.provider)
                                .delete(nodesToDelete);

                            setState(() {
                              isDeleting = false;
                            });
                            _animationController.forward(from: 0);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: KColors.accent.lighten(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  isDeleting
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Expanded(
                                          child: Text(
                                            'CLEAN NOW',
                                            style: TextStyle(
                                              color: Color(0xff098ff1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                ],
                              )),
                        ),
                      ] else
                        Center(
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: Colors.white,
                            strokeWidth: 1,
                            dashPattern: [4, 4],
                            radius: const Radius.circular(8),
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  size: 48,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Drag files here to delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
              onMove: (_) {
                setState(() {
                  isHover = true;
                });
              },
              onLeave: (_) {
                setState(() {
                  isHover = false;
                });
              },
              onAccept: (item) {
                ref.read(NoSQLService.provider).addNodeToDelete(item);
                isHover = false;
                // setState(() {});
              },
            )),
      ],
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 60,
            ),
            Text(
              'dui',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              'disk utility interface',
              style: TextStyle(
                // fontSize: 48,
                // fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class OptionLink extends StatefulWidget {
  const OptionLink({
    Key? key,
    required this.title,
    required this.icon,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool isActive;
  final Function()? onTap;

  @override
  State<OptionLink> createState() => _OptionLinkState();
}

class _OptionLinkState extends State<OptionLink> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.onTap?.call();
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: widget.isActive
                ? BoxDecoration(
                    color: widget.isActive ? KColors.accent : null,
                    borderRadius: BorderRadius.circular(8),
                  )
                : isHover
                    ? BoxDecoration(
                        color: KColors.accent.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : null,
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color:
                      widget.isActive ? const Color(0xff098ff1) : Colors.white,
                  // : const Color(0xff098ff1).lighten(0.1),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.isActive
                        ? const Color(0xff098ff1)
                        : Colors.white.lighten(0.1),
                    // : const Color(0xdd098ff1).darken(0.2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
