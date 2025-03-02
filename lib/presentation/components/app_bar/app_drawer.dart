import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      width: 284,
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
                IconConfig.home,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              title: Text('Home', style: theme.textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // Navigate to home
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),

              leading: SvgPicture.asset(
                IconConfig.user,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              title: Text('Profile', style: theme.textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
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
                // Navigate to settings
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: SvgPicture.asset(
                IconConfig.logOut,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              title: Text('Logout', style: theme.textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
