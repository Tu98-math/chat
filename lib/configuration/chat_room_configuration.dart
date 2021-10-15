import 'package:chat/constant/enum.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/chat_room/chat_room.dart';
import 'package:chat/model/message/image_message.dart';
import 'package:chat/model/message/message.dart';
import 'package:chat/model/message/text_message.dart';
import 'package:chat/widgets/image_message.dart';
import 'package:chat/widgets/text_message.dart';
import 'package:flutter/material.dart';

class ChatRoomConfiguration<T extends ChatRoomModel> {
  final EdgeInsets padding;

  final Decoration decoration;

  late Widget Function(MessageModel) itemBuilder;

  late List<MessageModel> Function(List<MessageModel> input)? filter;

  late Widget loadingMessageItem;

  late Widget Function(int)? itemTimeGap;

  ChatRoomConfiguration({
    this.padding = EdgeInsets.zero,
    this.decoration = const BoxDecoration(),
    Widget Function(MessageModel)? itemBuilder,
    Widget Function(int)? itemTimeGap,
    this.filter,
    this.loadingMessageItem = const Text("Loading ....."),
  }) {
    this.itemBuilder = itemBuilder ?? _baseItem;
    this.itemTimeGap = itemTimeGap ?? _baseItemTimeGap;
  }

  Widget _baseItemTimeGap(int timeStamp) {
    return Text(DateTime.fromMicrosecondsSinceEpoch(timeStamp).toString());
  }

  Widget _baseTtemChatDeliveryStatus(ChatDeliveryStatus status) {
    return Text(status.toString());
  }

  Widget _baseItem(MessageModel item) {
    switch (item.type) {
      case MessageType.text:
        return TextMessage(
          model: item as TextMessageModel,
          authorID: item.author.id,
        );
      case MessageType.image:
        return ImageMessage(
          model: item as ImageMessageModel,
          authorID: item.author.id,
        );
      case MessageType.custom:
        return TextMessage(
          model: item as TextMessageModel,
          authorID: item.author.id,
        );
      case MessageType.file:
        return TextMessage(
          model: item as TextMessageModel,
          authorID: item.author.id,
        );
      case MessageType.unsupported:
        return TextMessage(
          model: item as TextMessageModel,
          authorID: item.author.id,
        );
    }
  }
}
