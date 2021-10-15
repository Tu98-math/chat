import 'package:chat/model/model.dart';
import 'package:rxdart/rxdart.dart';

enum ChatSource { network, cache }

enum ChatLoaderStatus { loading, loadMore, error, done }

enum ChatDeliveryStatus {
  sending,
  failed,
  sent,
}

class ChatDataSnapshot {
  ///from network
  List<MessageModel> sentMessages = [];

  ///messages that not in network, not yet
  List<MessageModel> localMessages = [];

  ChatLoaderStatus snapshotStatus;

  ChatDataSnapshot({this.snapshotStatus = ChatLoaderStatus.loading});

  List<MessageModel> getAll(
      {int Function(MessageModel a, MessageModel b)? sort,
      List<MessageModel> Function(List<MessageModel> input)? filter}) {
    var temp = (sentMessages + localMessages);
    if (sort != null) {
      temp.sort(sort);
    } else {
      temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
    temp[0].isDisplayTime = true;
    if (filter != null) {
      return filter(temp);
    } else {
      return temp;
    }
  }
}

class ChatRoomController<T extends MessageModel> {
  BehaviorSubject<ChatDataSnapshot> bsSnapshot =
      BehaviorSubject<ChatDataSnapshot>.seeded(ChatDataSnapshot());

  // ignore: prefer_final_fields
  List<Function(ChatDataSnapshot snapshot)> _bsListener = [];

  ///OUTPUT
  void addListener(Function(ChatDataSnapshot model) callback) {
    _bsListener.add(callback);
  }

  void notify() {
    for (var element in _bsListener) {
      if (bsSnapshot.hasValue) {
        element.call(bsSnapshot.value);
      }
    }
  }

  List<MessageModel>? get _currentSentMsg => bsSnapshot.value.sentMessages;

  List<MessageModel>? get _currentLocalMsg => bsSnapshot.value.localMessages;

  ///INPUT
  void refreshMessages(Iterable<MessageModel> models,
      {bool isNetwork = true, ChatLoaderStatus? status}) {
    var currentSnapshot = bsSnapshot.value;
    if (isNetwork) {
      currentSnapshot.sentMessages.addAll(models);
    } else {
      currentSnapshot.localMessages.addAll(models);
    }
    currentSnapshot.snapshotStatus = ChatLoaderStatus.done;

    if (status != null) {
      currentSnapshot.snapshotStatus = status;
    }

    bsSnapshot.add(currentSnapshot);
    notify();
  }

  void addNewMessageLocal(Iterable<MessageModel> models) {
    var newValue = bsSnapshot.value;
    for (var element in models) {
      element.deliveryStatus = ChatDeliveryStatus.sending;
    }
    newValue.localMessages.addAll(models);
    bsSnapshot.add(newValue);
    notify();
  }

  void removeMessageLocal(Iterable<MessageModel> models) {
    var newValue = bsSnapshot.value;
    newValue.localMessages.removeWhere((element) => models.contains(element));
    bsSnapshot.add(newValue);
    notify();
  }

  void addNewMessageNetwork(Iterable<MessageModel> models) {
    var newValue = bsSnapshot.value;
    for (var element in models) {
      element.deliveryStatus = ChatDeliveryStatus.sent;
    }
    newValue.sentMessages.addAll(models);
    removeMessageLocal(models);
    bsSnapshot.add(newValue);

    notify();
  }

  void removeMessageNetwork(Iterable<MessageModel> models) {
    var newValue = bsSnapshot.value;
    newValue.sentMessages.removeWhere((element) => models.contains(element));
    bsSnapshot.add(newValue);
    notify();
  }

  void dispose() {
    bsSnapshot.drain().then((value) => bsSnapshot.close());
  }
}
