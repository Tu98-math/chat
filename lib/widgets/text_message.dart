import 'package:chat/model/message/text_message.dart';
import 'package:flutter/material.dart';

class TextMessage<T extends TextMessageModel> extends StatefulWidget {
  const TextMessage({
    Key? key,
    required this.model,
    required this.authorID,
  }) : super(key: key);

  final T model;
  final String authorID;
  @override
  State<TextMessage> createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        if (widget.model.isDisplayTime)
          Column(
            children: [
              const SizedBox(height: 30),
              Text(DateTime.fromMicrosecondsSinceEpoch(widget.model.createdAt)
                  .toString()),
              const SizedBox(height: 10),
            ],
          ),
        Row(
          children: [
            CircleAvatar(
              radius: 10.0,
              backgroundImage: NetworkImage("${widget.model.author.imageUrl}"),
            ),
            SizedBox(
              width: size.width * .8,
              child: Padding(
                padding: EdgeInsets.only(
                  left: widget.model.author.id == widget.authorID ? 0 : 40,
                  right: widget.model.author.id == widget.authorID ? 40 : 0,
                ),
                child: Column(
                  crossAxisAlignment: widget.model.author.id == widget.authorID
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(widget.model.author.firstName! +
                          widget.model.author.lastName!),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.model.text),
                    ),
                    const SizedBox(height: 10),
                    Text(widget.model.deliveryStatus.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
