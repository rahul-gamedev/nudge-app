import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:nudge_app/domain/config/theme/app_color.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nudge', style: theme.textTheme.headlineLarge),
        centerTitle: true,
        leadingWidth: 68, // Increased to accommodate the margin
        // automaticallyImplyLeading: true,
        leading: Container(
          margin: EdgeInsets.only(left: 12),
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
        actionsPadding: EdgeInsets.only(right: 16),
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
      ),
      body: Column(
        children: [
          // Messages container - takes all available space
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  // Received message bubble
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16, right: 80),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        // color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        border: Border.all(
                          color:
                              isDarkMode
                                  ? Colors.grey[700]!
                                  : Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        "Hi there! How can I help you today?",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  // Sent message bubble
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16, left: 80),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        "I need help with my project!!!!!!!",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Text input field - fixed at bottom
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text field in expanded container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color:
                              isDarkMode
                                  ? Colors.white.withValues(alpha: .1)
                                  : Colors.grey.withValues(alpha: .3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                        contentPadding: EdgeInsets.only(
                          right: 16,
                          top: 14,
                          bottom: 14,
                          left: 8,
                        ),
                        filled: true,
                        fillColor: theme.scaffoldBackgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide.none,
                        ),
                        // Attachment button on left side
                        prefixIcon: Container(
                          // padding: EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              IconConfig.paperClip,
                              colorFilter: ColorFilter.mode(
                                AppColor.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {
                              // Handle attachment action
                            },
                          ),
                        ),
                        // No suffix icon anymore
                      ),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),

                // Add spacing between text field and send button
                SizedBox(width: 6),

                // Send button outside the text field
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      IconConfig.arrowRight,
                      colorFilter: ColorFilter.mode(
                        AppColor.light,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      // Handle send message action
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
