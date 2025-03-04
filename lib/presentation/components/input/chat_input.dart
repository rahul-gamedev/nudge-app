import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge_app/domain/config/icon/icon_config.dart';
import 'package:nudge_app/domain/config/theme/app_color.dart';

class ChatInput extends StatefulWidget {
  final Function(String message)? onSendPressed;
  final Function()? onAttachmentPressed;

  const ChatInput({super.key, this.onSendPressed, this.onAttachmentPressed});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_textController.text.trim().isNotEmpty &&
        widget.onSendPressed != null) {
      widget.onSendPressed!(_textController.text.trim());
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text field in expanded container
          Expanded(
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
                            ? Colors.white.withValues(alpha: .1)
                            : Colors.grey.withValues(alpha: .3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  contentPadding: const EdgeInsets.only(
                    right: 16,
                    top: 14,
                    bottom: 14,
                    left: 8,
                  ),
                  filled: true,
                  fillColor: theme.scaffoldBackgroundColor,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        IconConfig.paperClip,
                        colorFilter: const ColorFilter.mode(
                          AppColor.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: widget.onAttachmentPressed,
                    ),
                  ),
                ),
                style: theme.textTheme.bodyMedium,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSend(),
              ),
            ),
          ),

          // Add spacing between text field and send button
          const SizedBox(width: 6),

          // Send button outside the text field
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primaryColor,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                IconConfig.arrowUp,
                colorFilter: const ColorFilter.mode(
                  AppColor.light,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: _handleSend,
            ),
          ),
        ],
      ),
    );
  }
}
