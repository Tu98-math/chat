import 'package:chat/constant/enum.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/partial/partial_image.dart';
import 'package:chat/model/user.dart';

import 'message.dart';

class ImageMessageModel extends MessageModel {
  /// Creates an image message.
  ImageMessageModel({
    required UserModel author,
    required int createdAt,
    this.height,
    required String id,
    Map<String, dynamic>? metadata,
    required this.name,
    String? remoteId,
    String? roomId,
    required this.size,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
    required this.uri,
    this.width,
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
          type ?? MessageType.image,
          updatedAt,
          ChatDeliveryStatus.sent,
        );

  /// Creates a full image message from a partial one.
  ImageMessageModel.fromPartial({
    required UserModel author,
    required int createdAt,
    required String id,
    required PartialImageModel partialImage,
    String? remoteId,
    String? roomId,
    MessageStatus? status,
    int? updatedAt,
    ChatDeliveryStatus? chatDeliveryStatus,
    bool isDisplayTime = false,
  })  : height = partialImage.height,
        name = partialImage.name,
        size = partialImage.size,
        uri = partialImage.uri,
        width = partialImage.width,
        super(
          author,
          createdAt,
          id,
          partialImage.metadata,
          remoteId,
          roomId,
          status,
          MessageType.image,
          updatedAt,
          ChatDeliveryStatus.sent,
        );

  /// Creates an image message from a map (decoded JSON).
  factory ImageMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageMessageFromJson(json);

  /// Converts an image message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$ImageMessageToJson(this);

  /// Creates a copy of the image message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [previewData] is ignored for this message type.
  /// [remoteId] and [updatedAt] with null values will nullify existing value.
  /// [status] and [uri] with null values will be overwritten by previous values.
  /// [text] is ignored for this message type.
  @override
  MessageModel copyWith(
      {Map<String, dynamic>? metadata,
      String? remoteId,
      MessageStatus? status,
      String? text,
      int? updatedAt,
      String? uri,
      DateTime? time,
      ChatDeliveryStatus? deliveryStatus,
      bool isDisplayTime = true}) {
    return ImageMessageModel(
      author: author,
      createdAt: createdAt,
      height: height,
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      name: name,
      remoteId: remoteId,
      roomId: roomId,
      size: size,
      status: status ?? this.status,
      updatedAt: updatedAt,
      uri: uri ?? this.uri,
      width: width,
      isDisplayTime: isDisplayTime,
    );
  }

  /// Image height in pixels
  final double? height;

  /// The name of the image
  final String name;

  /// Size of the image in bytes
  final num size;

  /// The image source (either a remote URL or a local resource)
  final String uri;

  /// Image width in pixels
  final double? width;
}

ImageMessageModel _$ImageMessageFromJson(Map<String, dynamic> json) =>
    ImageMessageModel(
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int,
      height: (json['height'] as num?)?.toDouble(),
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String,
      remoteId: json['remoteId'] as String?,
      roomId: json['roomId'] as String?,
      size: json['size'] as num,
      status: $enumDecodeNullable($StatusEnumMap, json['status']),
      type: $enumDecodeNullable($MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
      uri: json['uri'] as String,
      width: (json['width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ImageMessageToJson(ImageMessageModel instance) =>
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
      'height': instance.height,
      'name': instance.name,
      'size': instance.size,
      'uri': instance.uri,
      'width': instance.width,
    };
