import 'package:chat/model/message/image_message.dart';
import 'package:flutter/material.dart';

class ImageMessage<T extends ImageMessageModel> extends StatefulWidget {
  const ImageMessage({Key? key, required this.model, required this.authorID})
      : super(key: key);

  final T model;
  final String authorID;
  @override
  State<ImageMessage> createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
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
                      padding: EdgeInsets.all(10),
                      child: Text(widget.model.author.firstName! +
                          widget.model.author.lastName!),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 100,
                      height: 20,
                      child: Image.network(
                        widget.model.uri,
                      ),
                    ),
                    const SizedBox(height: 10),
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
