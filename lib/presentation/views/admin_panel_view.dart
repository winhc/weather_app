import 'package:flutter/material.dart';
import 'package:weather/utils/validator_util.dart';

class AdminPanelView extends StatelessWidget {
  AdminPanelView({super.key});
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _messageTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (contezt, index) {
                    return const Card(
                      child: ListTile(
                        title: Text("Title"),
                        subtitle: Text('data'),
                        subtitleTextStyle: TextStyle(fontSize: 20),
                      ),
                    );
                  })),
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
                    return ValidatorUtil.validateBasic(value, "Title", context);
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
                          return ValidatorUtil.validateBasic(
                              value, "Message", context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                          onPressed: _sendMessage,
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

  void _sendMessage() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      debugPrint("send message");
    }
  }
}
