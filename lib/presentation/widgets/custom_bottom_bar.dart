import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final paths = [
    '/',
    '/create_post',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).location;
    final currentIndex =
        paths.contains(currentLocation) ? paths.indexOf(currentLocation) : 0;

    return CupertinoTabBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CommunityMaterialIcons.home_variant_outline),
        ),
        BottomNavigationBarItem(
          icon: Icon(CommunityMaterialIcons.plus_circle_outline),
        ),
        BottomNavigationBarItem(
          icon: Icon(CommunityMaterialIcons.account_outline),
        ),
      ],
      onTap: (value) {
        context.go(paths[value]);
      },
      currentIndex: currentIndex,
    );
  }
}
