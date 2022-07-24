import 'package:flutter/material.dart';
// import path package
import 'package:path/path.dart' as p;

class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({
    Key? key,
    required this.crumbs,
    this.onCrumbTap,
  }) : super(key: key);

  final List<String> crumbs;
  final Function(String)? onCrumbTap;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (String crumb in crumbs) ...[
        GestureDetector(
          onTap: () {
            // return joined crumbs upto the previous crumb
            final path =
                p.joinAll(crumbs.sublist(0, crumbs.indexOf(crumb) + 1));
            onCrumbTap?.call(path);
          },
          child:
              // show home icon for first crumb
              crumbs.indexOf(crumb) == 0
                  ? Icon(
                      Icons.home_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 18,
                    )
                  : Text(
                      crumb,
                      // highlight crumb with blue if it is not the last crumb
                      style: crumbs.last == crumb
                          ? null
                          : TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                    ),
        ),
        if (crumbs.indexOf(crumb) != crumbs.length - 1)
          Icon(
            Icons.chevron_right,
            color: Colors.grey[300],
            size: 18,
          ),
      ]
    ]);
  }
}
