import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text('Nudge', style: theme.textTheme.headlineLarge),
      centerTitle: true,
      leadingWidth: 68,
      leading: Container(
        margin: const EdgeInsets.only(left: 12),
        child: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            IconConfig.menu,
            semanticsLabel: "Menu",
            colorFilter: ColorFilter.mode(
              theme.appBarTheme.foregroundColor!,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.only(right: 16),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            IconConfig.ellipsis,
            colorFilter: ColorFilter.mode(
              theme.appBarTheme.foregroundColor!,
              BlendMode.srcIn,
            ),
          ),
          color: theme.appBarTheme.foregroundColor,
        ),
      ],
    );
  }
}
