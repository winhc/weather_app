import 'package:flutter/material.dart';
import 'package:weather/data/repositories/fcm/fcm_repository.dart';
import 'package:weather/data/repositories/fcm/fcm_repository_impl.dart';
import 'package:weather/presentation/widgets/weather_toast.dart';
import 'package:weather/service/fcm_service.dart';
import 'package:weather/utils/validator_util.dart';

import '../../data/models/notification_message_model.dart';

class AdminPanelView extends StatefulWidget {
  const AdminPanelView({super.key});

  @override
  State<AdminPanelView> createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView> {
  final List<NotificationMessage> _notificationMessageList = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final TextEditingController _titleTextEditingController =
      TextEditingController();

  final TextEditingController _messageTextEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FCMRepository _fcmRepository = FCMREpositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 239, 239),
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: AnimatedList(
            key: _listKey,
            initialItemCount: _notificationMessageList.length,
            itemBuilder: (context, index, animation) {
              final item = _notificationMessageList[index];
              return _buildMesssageItem(item, index, animation);
            },
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: messageForm(context),
          ),
        ],
      ),
    );
  }

  Widget messageForm(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTextEditingController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Title',
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return ValidatorUtil()
                        .validateBasic(value, "Title", context);
                  },
                ),
                const Divider(),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _messageTextEditingController,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Message',
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return ValidatorUtil()
                              .validateBasic(value, "Message", context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                          onPressed: () {
                            _sendMessage().then((statusCode) {
                              if (statusCode == 200) {
                                WeatherToast().showToast(context,
                                    icon: Icons.message_rounded,
                                    message: "Notification sent successfully");
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 20,
                            color: Colors.deepPurpleAccent,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<int> _sendMessage() async {
    FocusManager.instance.primaryFocus?.unfocus();
    int statusCode = 404;
    // unsubscribe to fcm topic, cuz, don't want to get message by itself
    // only send to other app
    FCMService().unSubscribeToTopic();

    if (_formKey.currentState!.validate()) {
      debugPrint("send message");
      String title = _titleTextEditingController.text;
      String message = _messageTextEditingController.text;
      if (title.isNotEmpty && message.isNotEmpty) {
        statusCode =
            await _fcmRepository.sendMessage(title: title, message: message);
        if (statusCode == 200) {
          final nextIndex = _notificationMessageList.length;
          _notificationMessageList
              .add(NotificationMessage(title: title, message: message));
          _listKey.currentState!.insertItem(nextIndex);
        }
        _cleanMessageForm();
        // after send message subscribe back to get message, when other admin app send message
        FCMService().subscribeToTopic();
      }
    }

    return statusCode;
  }

  _cleanMessageForm() {
    _titleTextEditingController.clear();
    _messageTextEditingController.clear();
  }

  Widget _buildMesssageItem(
      NotificationMessage item, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(item.title!),
          subtitle: Text(item.message!),
          subtitleTextStyle: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
