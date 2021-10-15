import 'package:chat/model/chat_room/chat_room.dart';
import 'package:chat/model/model.dart';

abstract class IChatApi<T extends ChatRoomModel, Y extends UserModel,
    Z extends MessageModel> {
  //Api to get chat data
  Future<T> getChatRoomData();
}
