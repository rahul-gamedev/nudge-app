import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:nudge_app/presentation/components/app_bar/app_drawer.dart';

class JournalList extends StatelessWidget {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        leading: Builder(
          // Add Builder here
          builder: (BuildContext context) {
            // This creates a new context inside the Scaffold
            return IconButton(
              icon: SvgPicture.asset(
                IconConfig.menu,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Now this works
              },
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
      drawerEdgeDragWidth: 312,
      body: const Center(child: Text('Journal Page Content')),
    );
  }
}
