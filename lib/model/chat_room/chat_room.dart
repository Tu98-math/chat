import 'package:chat/constant/enum.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/message/message.dart';
import 'package:chat/model/user.dart';

class ChatRoomModel {
  final String id;
  final List<MessageModel> message;
  final List<UserModel> userInChat;
  final ChatRoomType type;
  final ChatDeliveryStatus deliveryStatus;

  const ChatRoomModel(
      {required this.id,
      this.message = const [],
      required this.type,
      required this.userInChat,
      this.deliveryStatus = ChatDeliveryStatus.sent});

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'] as String,
      message: _listMessageFromJson(json) ?? [],
      type: $enumDecode($ChatRoomTypeEnumMap, json['type']),
      userInChat: _listUserFromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = $ChatRoomTypeEnumMap[type];
    if (message.isNotEmpty) {
      data['message'] = message.map((v) => v.toJson()).toList();
    }
    data['user'] = userInChat.map((v) => v.toJson()).toList();
    return data;
  }
}

List<MessageModel>? _listMessageFromJson(Map<String, dynamic> json) {
  if (json['message'] != null) {
    List<MessageModel> _returnList = [];
    json['message'].forEach((v) {
      _returnList.add(MessageModel.fromJson(v));
    });
    return _returnList;
  }
}

List<UserModel> _listUserFromJson(List<Map<String, dynamic>> json) {
  List<UserModel> _returnList = [];
  for (var v in json) {
    _returnList.add(UserModel.fromJson(v));
  }
  return _returnList;
}
