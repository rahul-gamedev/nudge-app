import 'package:flutter/material.dart';
import 'package:nudge_app/presentation/components/app_bar/chat_app_bar.dart';
import 'package:nudge_app/presentation/components/messages/message_bubble.dart';
import 'package:nudge_app/presentation/components/messages/message_container.dart';
import 'package:nudge_app/presentation/components/input/chat_input.dart';
import 'package:nudge_app/presentation/components/app_bar/app_drawer.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      drawer: const AppDrawer(), // Add the drawer here
      // Enable swipe gesture to open drawer (default in Scaffold)
      drawerEdgeDragWidth: 512, // Customize drag area width if needed
      body: Column(
        children: [
          MessageContainer(
            messages: [
              Message(
                content: "Hello! Welcome to the app.",
                type: MessageType.received,
              ),
              Message(
                content: "Thanks for the warm welcome!",
                type: MessageType.sent,
              ),
              Message(
                content: "How can I help you today?",
                type: MessageType.received,
              ),
              Message(
                content:
                    "How can I help you today? How can I help you today? How can I help you today?",
                type: MessageType.received,
              ),
              Message(content: "Mm", type: MessageType.sent),
            ],
          ),
          ChatInput(
            onSendPressed: () {
              // Handle send message
            },
            onAttachmentPressed: () {
              // Handle attachment
            },
          ),
        ],
      ),
    );
  }
}
