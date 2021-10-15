import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField({
    Key? key,
    required this.press,
  }) : super(key: key);

  final Function press;
  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                        controller: messageTextController,
                      ),
                    ),
                    const SizedBox(height: 5),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black54,
                      ),
                      onPressed: () async {
                        if (messageTextController.text.trim().isNotEmpty) {
                          String messText = messageTextController.text.trim();
                          messageTextController.text = '';
                          await press(messText);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
