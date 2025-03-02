import 'package:flutter/material.dart';

enum MessageType { sent, received }

class MessageBubble extends StatelessWidget {
  final String message;
  final MessageType type;

  const MessageBubble({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Align(
      alignment:
          type == MessageType.sent
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16,
          left: type == MessageType.sent ? 80 : 0,
          right: type == MessageType.received ? 80 : 0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              type == MessageType.sent
                  ? (isDarkMode ? Colors.grey[800] : Colors.grey[200])
                  : null,
          border:
              type == MessageType.received
                  ? Border.all(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1,
                  )
                  : null,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(message, style: theme.textTheme.bodyMedium),
      ),
    );
  }
}
