import 'package:flutter/material.dart';
import 'package:nudge_app/presentation/components/app_bar/chat_app_bar.dart';
import 'package:nudge_app/presentation/components/messages/message_container.dart';
import 'package:nudge_app/presentation/components/input/chat_input.dart';
import 'package:nudge_app/presentation/components/app_bar/app_drawer.dart';
import 'package:nudge_app/presentation/components/messages/message_bubble.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final GlobalKey<MessageContainerState> _messageContainerKey = GlobalKey();

  void _handleSendMessage(String messageText) {
    if (_messageContainerKey.currentState != null && messageText.isNotEmpty) {
      final message = Message(
        content: messageText,
        type: MessageType.sent,
        timestamp: DateTime.now(),
      );
      _messageContainerKey.currentState!.addMessage(message);

      // Add delay before showing the typing message
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_messageContainerKey.currentState != null) {
          final reply = Message(
            content: "Typing...",
            type: MessageType.received,
            timestamp: DateTime.now(),
          );
          _messageContainerKey.currentState!.addMessage(reply);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      drawer: const AppDrawer(),
      drawerEdgeDragWidth: 312,
      body: Column(
        children: [
          MessageContainer(key: _messageContainerKey),
          ChatInput(
            onSendPressed: _handleSendMessage,
            onAttachmentPressed: () {
              // Handle attachment
            },
          ),
        ],
      ),
    );
  }
}
