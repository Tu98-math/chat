import 'dart:math';

import 'package:chat/api/custom_api.dart';
import 'package:chat/configuration/chat_room_configuration.dart';
import 'package:chat/controller/chat_room_controller.dart';
import 'package:chat/model/chat_room/chat_room.dart';
import 'package:chat/model/message/message.dart';
import 'package:chat/model/message/text_message.dart';
import 'package:chat/model/user.dart';
import 'package:chat/widgets/chat_input_field.dart';
import 'package:flutter/material.dart';

class ChatRoom<T extends ChatRoomModel> extends StatefulWidget {
  const ChatRoom({
    Key? key,
    required this.api,
    required this.chatRoomConfiguration,
    required this.controller,
  }) : super(key: key);

  final MyApi api;
  final ChatRoomConfiguration<T> chatRoomConfiguration;
  final ChatRoomController<MessageModel> controller;

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late final ChatRoomModel _chatRoom;

  int messageLength = 0;

  bool loading = false;

  @override
  void initState() {
    _loadData();
    scrollController.addListener(() async {
      if (scrollController.position.pixels == 0 && !loading) {
        if (_chatRoom.message.length - messageLength >= 10) {
          setState(() {
            loading = true;
          });
          await Future.delayed(const Duration(milliseconds: 1500), () {});
          setState(() {
            messageLength += 10;
            loading = false;
          });
        } else if (_chatRoom.message.length - messageLength > 0) {
          setState(() {
            loading = true;
          });
          await Future.delayed(const Duration(milliseconds: 1500), () {});
          setState(() {
            messageLength = _chatRoom.message.length;
            loading = false;
          });
        }
      } else {
        // You're at the bottom.
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    _chatRoom = await widget.api.getChatRoomData();
    widget.controller.addNewMessageNetwork(_chatRoom.message);

    setState(() {
      messageLength = _chatRoom.message.length < 10
          ? messageLength = _chatRoom.message.length
          : 10;
    });
  }

  UserModel user1 = const UserModel(
    id: '1',
    firstName: 'Pham',
    lastName: 'Long',
    imageUrl:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
  );

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    Size size = MediaQuery.of(context).size;
    Future<void> sendTextMassage(String textMessage) async {
      var mess = TextMessageModel(
        author: user1,
        id: rng.nextInt(100).toString(),
        text: textMessage,
        chatDeliveryStatus: ChatDeliveryStatus.sending,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );
      widget.controller.addNewMessageLocal([mess]);
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
      await Future.delayed(const Duration(milliseconds: 1500), () {});
      widget.controller.addNewMessageNetwork([mess]);
    }

    return Column(
      children: [
        loading ? widget.chatRoomConfiguration.loadingMessageItem : Container(),
        Expanded(
          child: Scaffold(
            body: Container(
              decoration: widget.chatRoomConfiguration.decoration,
              child: StreamBuilder<ChatDataSnapshot>(
                stream: widget.controller.bsSnapshot,
                builder: (context, snapshot) {
                  if (snapshot.data == null) return Container();
                  if (snapshot.data!.snapshotStatus == ChatLoaderStatus.error) {
                    return Center(
                      child: Text(
                        'error'.toUpperCase(),
                      ),
                    );
                  } else {
                    List<MessageModel> allData = snapshot.data!
                        .getAll(filter: widget.chatRoomConfiguration.filter);
                    return CustomScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                widget.chatRoomConfiguration.itemBuilder(
                              allData[allData.length - messageLength + index],
                            ),
                            childCount: messageLength,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: snapshot.data!.snapshotStatus ==
                                    ChatLoaderStatus.loadMore
                                ? const CircularProgressIndicator(
                                    color: Colors.blue,
                                  )
                                : Container(),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
        ChatInputField(
          press: sendTextMassage,
        ),
      ],
    );
  }
}
