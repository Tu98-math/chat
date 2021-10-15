import 'package:chat/configuration/chat_room_configuration.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/chat_room/chat_room.dart';
import 'package:chat/model/message/message.dart';
import 'package:chat/model/model.dart';
import 'package:flutter/material.dart';

import 'api/custom_api.dart';
import 'view/chat_room.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyApi _api;
  final ChatRoomController<MessageModel> _controller =
      ChatRoomController<MessageModel>();

  @override
  void initState() {
    _api = MyApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ChatRoom<ChatRoomModel>(
          api: _api,
          chatRoomConfiguration: ChatRoomConfiguration(
            padding: const EdgeInsets.all(20),
            filter: (data) {
              for (int i = 1; i < data.length; i++) {
                if (data[i].createdAt - data[i - 1].createdAt > 3600) {
                  data[i].isDisplayTime = true;
                }
              }
              return data;
            },
            loadingMessageItem: Container(
              height: 100,
              width: 300,
              color: Colors.blueGrey,
              child: Text("Loading ... .. . .. . . . . .. . ."),
            ),
          ),
          controller: _controller,
        ),
      ),
    );
  }
}

// class SaveAndLoadJson extends StatefulWidget {
//   const SaveAndLoadJson({ Key? key }) : super(key: key);

//   @override
//   _SaveAndLoadJsonState createState() => _SaveAndLoadJsonState();
// }

// class _SaveAndLoadJsonState extends State<SaveAndLoadJson> {

//   final MyApi _api = MyApi();
//   late final Future<ChatRoomModel> _chatRoom;

//   @override
//   void initState() {
//     _chatRoom = _api.getChatRoomData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text('Reading and Writing Files'),
//       ),
//       body: Center(
//         child: FutureBuilder<ChatRoomModel>(
//           future: _chatRoom,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Center(
//                 child: Text('Error'),
//               );
//             }
//             if (snapshot.connectionState != ConnectionState.done) {
//               return const Center(
//                   child: CircularProgressIndicator());
//             }
//             ChatRoomModel chatRoomModel = snapshot.data!;
//             return Text(chatRoomModel.message.length.toString());
//           }
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){},
//         child: const Icon(Icons.replay_outlined),
//       ),
//     );
//   }
// }
