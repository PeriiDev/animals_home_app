import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInsidePage extends StatefulWidget {
  ChatInsidePage({Key? key}) : super(key: key);

  @override
  State<ChatInsidePage> createState() => _ChatPageState();
}

late TextEditingController chatController;

class _ChatPageState extends State<ChatInsidePage> {
  @override
  void initState() {
    chatController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  bool isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: ((context, index) => Text('$index')),
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                height: 50,
                child: _inputChat(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              onChanged: (text) {
                setState(() {
                  if (text.trim().length > 0) {
                    isWriting = true;
                  } else {
                    isWriting = false;
                  }
                });
              },
              //controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            child: Platform.isIOS
                ? CupertinoButton(child: Text('Enviar'), onPressed: () {})
                : Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: (!isWriting) ? null : () {},
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}
