import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.featured_play_list_outlined,
            ),
            selectedIcon: Icon(Icons.featured_play_list),
            label: 'แนะนำ',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search_outlined,
            ),
            selectedIcon: Icon(
              Icons.search,
            ),
            label: 'ค้นหา',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.playlist_play_outlined,
            ),
            selectedIcon: Icon(
              Icons.playlist_play,
            ),
            label: 'คอลเลกชันของฉัน',
          ),
        ],
      ),
      body: widget.navigationShell,
    );
  }

  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
