import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:nudge_app/presentation/pages/chat.dart';
import 'package:nudge_app/presentation/pages/journal_list.dart';
import 'package:nudge_app/presentation/pages/settings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      width: 256,
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer header with app logo/name
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Text('Nudge', style: theme.textTheme.headlineLarge),
                  const Spacer(),
                ],
              ),
            ),

            const Divider(),

            // Drawer items
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),

              leading: SvgPicture.asset(
                IconConfig.messageSquare,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              title: Text('Chat', style: theme.textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => const Chat()));
                // Navigate to home
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),

              leading: SvgPicture.asset(
                IconConfig.notebook,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              title: Text('Journal', style: theme.textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const JournalList()),
                );
                // Navigate to profile
              },
            ),

            const Spacer(),

            // Bottom section with logout
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: SvgPicture.asset(
                IconConfig.settings,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              title: Text('Settings', style: theme.textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
                // Navigate to settings
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
