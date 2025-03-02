import 'package:flutter/material.dart';
import 'package:nudge_app/presentation/components/app_bar/chat_app_bar.dart';
import 'package:nudge_app/presentation/components/messages/message_container.dart';
import 'package:nudge_app/presentation/components/input/chat_input.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          const MessageContainer(),
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
