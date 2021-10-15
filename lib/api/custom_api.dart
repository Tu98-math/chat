import 'package:chat/constant/enum.dart';
import 'package:chat/model/model.dart';

import 'chat_api.dart';

class MyApi extends IChatApi {
  UserModel user1 = UserModel(
    id: '1',
    firstName: 'Pham',
    lastName: 'Long',
    imageUrl:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
  );

  UserModel user2 = UserModel(
    id: '2',
    firstName: 'Tran',
    lastName: 'Tu',
    imageUrl:
        'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
  );

  @override
  Future<ChatRoomModel> getChatRoomData() async {
    var chatRoom = ChatRoomModel(
      id: '123456',
      type: ChatRoomType.oneToOne,
      userInChat: [
        user1,
        user2,
      ],
      message: [
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'bsasad asd sad sad asd asd sad asd sad sadurh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'bsasad asd sad sad asd asd sad asd sad sadurh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'bsasad asd sad sad asd asd sad asd sad sadurh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user1,
          id: '1',
          text: '1 2 3',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user1,
          id: '3',
          text: 'lmao',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user1,
          id: '2',
          text: 'dark ',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user1,
          id: '1',
          text: 'test',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user1,
          id: '3',
          text: 'lmao',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user1,
          id: '2',
          text: 'dark ',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'dark',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'lmao',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'bsasad asd sad sad asd asd sad asd sad sadurh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'burh',
          createdAt: 1634272400,
        ),
        TextMessageModel(
          author: user2,
          id: '2',
          text: 'bur sad a     sad  sad asd sadh',
          createdAt: 1634278400,
        ),
        ImageMessageModel(
          author: user1,
          id: '5',
          name: 'hi sad asd hi',
          size: 12.6,
          uri:
              'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
          createdAt: 1634278400,
        )
      ],
    ).toJson();
    return ChatRoomModel.fromJson(chatRoom);
  }
}
