import 'package:flutter/material.dart';
import 'package:nudge_app/presentation/components/messages/message_bubble.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            MessageBubble(
              message: "Hi there! How can I help you today?",
              type: MessageType.received,
            ),
            MessageBubble(
              message: "I need help with my project!!!!!!!",
              type: MessageType.sent,
            ),
          ],
        ),
      ),
    );
  }
}
