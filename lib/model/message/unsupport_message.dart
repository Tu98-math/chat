import 'package:chat/constant/enum.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/message/message.dart';
import 'package:chat/model/user.dart';

class UnsupportedMessageModel extends MessageModel {
  /// Creates an unsupported message.
  UnsupportedMessageModel({
    required UserModel author,
    required int createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    String? remoteId,
    String? roomId,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
    ChatDeliveryStatus? chatDeliveryStatus,
    bool displayTime = false,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          remoteId,
          roomId,
          status,
          type ?? MessageType.unsupported,
          updatedAt,
          ChatDeliveryStatus.sent,
        );

  /// Creates an unsupported message from a map (decoded JSON).
  factory UnsupportedMessageModel.fromJson(Map<String, dynamic> json) =>
      _$UnsupportedMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnsupportedMessageToJson(this);

  @override
  MessageModel copyWith(
      {Map<String, dynamic>? metadata,
      String? remoteId,
      MessageStatus? status,
      String? text,
      int? updatedAt,
      String? uri,
      ChatDeliveryStatus? deliveryStatus,
      bool isDisplayTime = false}) {
    return UnsupportedMessageModel(
      author: author,
      createdAt: createdAt,
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      remoteId: remoteId,
      roomId: roomId,
      status: status ?? this.status,
      updatedAt: updatedAt,
      displayTime: isDisplayTime,
    );
  }
}

UnsupportedMessageModel _$UnsupportedMessageFromJson(
        Map<String, dynamic> json) =>
    UnsupportedMessageModel(
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int,
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      remoteId: json['remoteId'] as String?,
      roomId: json['roomId'] as String?,
      status: $enumDecodeNullable($StatusEnumMap, json['status']),
      type: $enumDecodeNullable($MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$UnsupportedMessageToJson(
        UnsupportedMessageModel instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'createdAt': instance.createdAt,
      'id': instance.id,
      'metadata': instance.metadata,
      'remoteId': instance.remoteId,
      'roomId': instance.roomId,
      'status': $StatusEnumMap[instance.status],
      'type': $MessageTypeEnumMap[instance.type],
      'updatedAt': instance.updatedAt,
    };
