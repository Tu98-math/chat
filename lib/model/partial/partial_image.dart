import 'package:meta/meta.dart';
import '../message/image_message.dart';

@immutable
class PartialImageModel {
  /// Creates a partial image message with all variables image can have.
  /// Use [ImageMessageModel] to create a full message.
  /// You can use [ImageMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialImageModel({
    this.height,
    this.metadata,
    required this.name,
    required this.size,
    required this.uri,
    this.width,
  });

  /// Creates a partial image message from a map (decoded JSON).
  factory PartialImageModel.fromJson(Map<String, dynamic> json) =>
      _$PartialImageFromJson(json);

  /// Converts a partial image message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$PartialImageToJson(this);

  /// Image height in pixels
  final double? height;

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;

  /// The name of the image
  final String name;

  /// Size of the image in bytes
  final num size;

  /// The image source (either a remote URL or a local resource)
  final String uri;

  /// Image width in pixels
  final double? width;
}


PartialImageModel _$PartialImageFromJson(Map<String, dynamic> json) => PartialImageModel(
  height: (json['height'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  name: json['name'] as String,
  size: json['size'] as num,
  uri: json['uri'] as String,
  width: (json['width'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PartialImageToJson(PartialImageModel instance) =>
<String, dynamic>{
  'height': instance.height,
  'metadata': instance.metadata,
  'name': instance.name,
  'size': instance.size,
  'uri': instance.uri,
  'width': instance.width,
};

