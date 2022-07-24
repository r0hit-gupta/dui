import 'dart:math';

import 'package:dui/colors.dart';
import 'package:dui/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
    required this.currentIndex,
    required this.onChange,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(context.width * 0.25, 250),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(children: [
        const SizedBox(
          height: 100,
        ),
        OptionLink(
          icon: Icons.add_home_work_outlined,
          title: 'Home',
          isActive: currentIndex == 0,
          onTap: () => onChange(0),
        ),
        OptionLink(
          icon: Icons.video_collection,
          title: 'Videos',
          isActive: currentIndex == 1,
          onTap: () => onChange(1),
        ),
        OptionLink(
          icon: Icons.insert_drive_file_outlined,
          title: 'Files',
          isActive: currentIndex == 2,
          onTap: () => onChange(2),
        ),
      ]),
    );
  }
}

class OptionLink extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? KColors.accent : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive
                    ? const Color(0xff098ff1)
                    : const Color(0xffaeaeb7),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: isActive
                      ? const Color(0xff098ff1)
                      : const Color(0xff0f1749),
                  fontWeight: isActive ? FontWeight.bold : null,
                ),
              ),
            ],
          )),
    );
  }
}
