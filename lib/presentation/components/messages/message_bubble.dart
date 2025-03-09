import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MessageType { sent, received }

class MessageBubble extends StatefulWidget {
  final String message;
  final MessageType type;
  final DateTime? timestamp;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    required this.type,
    this.timestamp,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _isPressed = false;

  String _formatTime() {
    final timestamp = widget.timestamp ?? DateTime.now();
    return DateFormat('h:mm a').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final timeString = _formatTime();

    // Calculate text size for timestamp
    final timeStyle = theme.textTheme.labelSmall?.copyWith(
      fontSize: 10,
      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
      fontWeight: FontWeight.w400,
    );

    Color? getBubbleColor() {
      if (widget.type == MessageType.sent) {
        if (_isPressed) {
          return isDarkMode ? Colors.grey[800] : Colors.grey[400];
        } else {
          return isDarkMode ? Colors.grey[900] : Colors.grey[300];
        }
      }
      return null;
    }

    return Align(
      alignment:
          widget.type == MessageType.sent
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 8,
            left: widget.type == MessageType.sent ? 80 : 16,
            right: widget.type == MessageType.received ? 80 : 16,
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: getBubbleColor(),
            border:
                widget.type == MessageType.received
                    ? Border.all(
                      color:
                          isDarkMode
                              ? (_isPressed
                                  ? Colors.grey[600]!
                                  : Colors.grey[700]!)
                              : (_isPressed
                                  ? Colors.grey[400]!
                                  : Colors.grey[300]!),
                      width: 1,
                    )
                    : null,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Stack(
            children: [
              // Main message text
              Padding(
                // Add padding on right for time
                padding: EdgeInsets.only(right: 42),
                child: Text(
                  "${widget.message}  ",
                  style: theme.textTheme.bodyMedium,
                  softWrap: true,
                ),
              ),

              // Time indicator overlaid at bottom right
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(timeString, style: timeStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
