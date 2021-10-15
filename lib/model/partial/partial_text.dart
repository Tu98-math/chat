
class PartialTextModel {
  /// Creates a partial text message with all variables text can have.
  /// Use [TextMessage] to create a full message.
  /// You can use [TextMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialTextModel({
    this.metadata,
    required this.text,
  });

  /// Creates a partial text message from a map (decoded JSON).
  factory PartialTextModel.fromJson(Map<String, dynamic> json) =>
      _$PartialTextFromJson(json);

  /// Converts a partial text message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$PartialTextToJson(this);

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;


  /// User's message
  final String text;
}

PartialTextModel _$PartialTextFromJson(Map<String, dynamic> json) => PartialTextModel(
      metadata: json['metadata'] as Map<String, dynamic>?,
      text: json['text'] as String,
    );

Map<String, dynamic> _$PartialTextToJson(PartialTextModel instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'text': instance.text,
    };
