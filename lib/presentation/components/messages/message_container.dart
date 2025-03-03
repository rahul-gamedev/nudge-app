import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:nudge_app/presentation/components/messages/message_bubble.dart';

// Message model to represent chat messages
class Message {
  final String content;
  final MessageType type;
  final DateTime timestamp;

  Message({required this.content, required this.type, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();
}

class MessageContainer extends StatelessWidget {
  final List<Message> messages;

  // Default constructor with sample messages
  MessageContainer({super.key, List<Message>? messages})
    : messages =
          messages ??
          [
            Message(
              content: "Hi there! How can I help you today?",
              type: MessageType.received,
            ),
            Message(
              content: "I need help with my project!!!!!!!",
              type: MessageType.sent,
            ),
            Message(content: "Okay..", type: MessageType.received),
          ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(4),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return MessageBubble(
              message: message.content,
              type: message.type,
              onTap: () {
                // Handle message tap
              },
              onLongPress: () {
                // Show options for the message
                _showMessageOptions(context, message);
              },
            );
          },
        ),
      ),
    );
  }

  void _showMessageOptions(BuildContext context, Message message) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      backgroundColor: theme.scaffoldBackgroundColor,
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  IconConfig.clipboard,
                  colorFilter: ColorFilter.mode(
                    theme.iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
                title: Text('Copy'),
                onTap: () {
                  // Copy message content
                  Navigator.pop(context);
                },
              ),
              if (message.type == MessageType.sent)
                ListTile(
                  leading: SvgPicture.asset(
                    IconConfig.trash,
                    colorFilter: ColorFilter.mode(
                      theme.iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text('Delete'),
                  onTap: () {
                    // Delete message
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
    );
  }
}
