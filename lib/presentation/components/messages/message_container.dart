import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:nudge_app/presentation/components/messages/message_bubble.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Message model to represent chat messages
class Message {
  final String content;
  final MessageType type;
  final DateTime timestamp;

  Message({required this.content, required this.type, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();

  // Factory constructor to create a Message from JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] ?? '',
      type: json['role'] == 'user' ? MessageType.sent : MessageType.received,
      timestamp:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}

class MessageContainer extends StatefulWidget {
  final List<Message>? initialMessages;

  const MessageContainer({super.key, this.initialMessages});

  @override
  State<MessageContainer> createState() => MessageContainerState();
}

class MessageContainerState extends State<MessageContainer> {
  late List<Message> messages;
  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize with provided messages or empty list
    messages = widget.initialMessages ?? [];

    // Fetch messages
    fetchMessages();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Method to fetch messages from API
  Future<void> fetchMessages() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      // Make API request
      final response = await http.get(
        Uri.parse('https://lh5tbl9j-6900.inc1.devtunnels.ms/chat'),
      );

      if (response.statusCode == 200) {
        // Parse response JSON
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Extract the "response" array from the JSON
        final List<dynamic> messagesData = jsonData['response'] ?? [];

        // Parse JSON data into Message objects
        final List<Message> fetchedMessages =
            messagesData.map<Message>((data) {
              return Message(
                content: data['content'] ?? '',
                // If role is "user", it's sent by the user, otherwise it's received
                type:
                    data['role'] == 'user'
                        ? MessageType.sent
                        : MessageType.received,
                timestamp:
                    data['createdAt'] != null
                        ? DateTime.parse(data['createdAt'])
                        : null,
              );
            }).toList();

        setState(() {
          messages = fetchedMessages;
          isLoading = false;
        });

        // Jump to bottom without animation after loading messages
        _scrollToBottom(animated: false);
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
          errorMessage = 'Failed to load messages: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Error: $e';
      });
    }
  }

  // Simplified scroll method
  void _scrollToBottom({bool animated = true}) {
    if (!_scrollController.hasClients) return;

    if (animated) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 1000,
        duration: const Duration(milliseconds: 350), // Very short animation
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  // Update the addMessage method to scroll immediately
  void addMessage(Message message) {
    setState(() {
      messages.add(message);
    });

    // Scroll immediately after adding, without unnecessary delays
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : messages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ), // More bottom padding
                      reverse: false,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return MessageBubble(
                          message: message.content,
                          type: message.type,
                          timestamp: message.timestamp,
                          onTap: () {},
                          onLongPress: () {
                            _showMessageOptions(context, message);
                            _showMessageOptions(context, message);
                          },
                        );
                      },
                    ),
          ),

          // // Just show the button always for simplicity
          // Positioned(
          //   right: 16,
          //   bottom: 16,
          //   child: FloatingActionButton(
          //     mini: true,
          //     backgroundColor: Theme.of(context).colorScheme.surface,
          //     elevation: 2.0,
          //     onPressed: () => _scrollToBottom(),
          //     child: Icon(
          //       Icons.keyboard_arrow_down,
          //       color: Theme.of(context).colorScheme.onSurface,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No messages yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (hasError) ...[
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'Unknown error',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.red[300]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchMessages,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }

  void _showMessageOptions(BuildContext context, Message message) {
    // Existing implementation...
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
                  // Copy message content - implement clipboard functionality
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
                    setState(() {
                      messages.remove(message);
                    });
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
    );
  }
}
