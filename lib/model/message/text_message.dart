import 'package:chat/constant/enum.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/message/message.dart';
import 'package:chat/model/partial/partial_text.dart';
import 'package:chat/model/user.dart';

class TextMessageModel extends MessageModel {
  /// Creates a text message.
  TextMessageModel({
    required UserModel author,
    required int createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    String? remoteId,
    String? roomId,
    MessageStatus? status,
    required this.text,
    MessageType? type,
    int? updatedAt,
    ChatDeliveryStatus? chatDeliveryStatus,
    bool isDisplayTime = false,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          remoteId,
          roomId,
          status,
          type ?? MessageType.text,
          updatedAt,
          ChatDeliveryStatus.sent,
        );

  /// Creates a full text message from a partial one.
  TextMessageModel.fromPartial(
      {required UserModel author,
      required int createdAt,
      required String id,
      required PartialTextModel partialText,
      String? remoteId,
      String? roomId,
      MessageStatus? status,
      int? updatedAt,
      ChatDeliveryStatus? deliveryStatus,
      bool isDisplayTime = false})
      : text = partialText.text,
        super(
          author,
          createdAt,
          id,
          partialText.metadata,
          remoteId,
          roomId,
          status,
          MessageType.text,
          updatedAt,
          ChatDeliveryStatus.sent,
        );

  /// Creates a text message from a map (decoded JSON).
  factory TextMessageModel.fromJson(Map<String, dynamic> json) =>
      _$TextMessageFromJson(json);

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);

  /// Creates a copy of the text message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [remoteId] and [updatedAt] with null values will nullify existing value.
  /// [status] and [text] with null values will be overwritten by previous values.
  /// [uri] is ignored for this message type.
  @override
  MessageModel copyWith({
    Map<String, dynamic>? metadata,
    String? remoteId,
    MessageStatus? status,
    String? text,
    int? updatedAt,
    String? uri,
    DateTime? time,
    ChatDeliveryStatus? deliveryStatus,
    bool isDisplayTime = false,
  }) {
    return TextMessageModel(
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
      text: text ?? this.text,
      updatedAt: updatedAt,
      isDisplayTime: isDisplayTime,
    );
  }

  /// User's message
  final String text;
}

TextMessageModel _$TextMessageFromJson(Map<String, dynamic> json) =>
    TextMessageModel(
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int,
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      remoteId: json['remoteId'] as String?,
      roomId: json['roomId'] as String?,
      status: $enumDecodeNullable($StatusEnumMap, json['status']),
      text: json['text'] as String,
      type: $enumDecodeNullable($MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
      isDisplayTime: json['isDisplayTime'] as bool,
    );

Map<String, dynamic> _$TextMessageToJson(TextMessageModel instance) =>
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
      'text': instance.text,
      'isDisplayTime': instance.isDisplayTime,
    };
