import 'package:chat/constant/enum.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/message/text_message.dart';
import 'package:chat/model/message/unsupport_message.dart';
import 'package:chat/model/user.dart';

import 'image_message.dart';

abstract class MessageModel {
  MessageModel(
    this.author,
    this.createdAt,
    this.id,
    this.metadata,
    this.remoteId,
    this.roomId,
    this.status,
    this.type,
    this.updatedAt,
    ChatDeliveryStatus sent, {
    this.isDisplayTime = false,
    this.deliveryStatus = ChatDeliveryStatus.sent,
  });

  /// Creates a particular message from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'image':
        return ImageMessageModel.fromJson(json);
      case 'text':
        return TextMessageModel.fromJson(json);
      default:
        return UnsupportedMessageModel.fromJson(json);
    }
  }

  MessageModel copyWith(
      {Map<String, dynamic>? metadata,
      String? remoteId,
      MessageStatus? status,
      String? text,
      int? updatedAt,
      ChatDeliveryStatus? deliveryStatus,
      bool isDisplayTime,
      String? uri});

  /// Converts a particular message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson();

  /// User who sent this message
  final UserModel author;

  /// Created message timestamp, in ms
  final int createdAt;

  /// Unique ID of the message
  String id;

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;

  /// Unique ID of the message received from the backend
  final String? remoteId;

  /// ID of the room where this message is sent
  final String? roomId;

  /// Message [MessageStatus]
  final MessageStatus? status;

  /// [MessageType]
  final MessageType type;

  /// Updated message timestamp, in ms
  final int? updatedAt;

  late ChatDeliveryStatus deliveryStatus;

  late bool isDisplayTime;
}
