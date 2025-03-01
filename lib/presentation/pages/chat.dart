import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nudge', style: TextStyle(fontWeight: FontWeight.w500)),
        centerTitle: true,
        leadingWidth: 52,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.insert_drive_file_rounded),
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
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
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
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Text input field - fixed at bottom
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDarkMode
                            ? Colors.white.withValues(alpha: .15)
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
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 16,
                  ),
                  contentPadding: EdgeInsets.only(
                    right: 24,
                    top: 20,
                    bottom: 20,
                    left: 20,
                  ),
                  filled: true,
                  fillColor: theme.scaffoldBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide.none,
                  ),
                  // Attachment button on left side
                  prefixIcon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color:
                            isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_rounded,
                        size: 22,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        // Handle attachment action
                      },
                    ),
                  ),
                  // Send button on right side
                  suffixIcon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        // Handle send message action
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
