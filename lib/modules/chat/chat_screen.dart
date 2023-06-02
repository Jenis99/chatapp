import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chatscreen extends StatefulWidget {
  var cid = "";
  var name = "";
  var email = "";
  var photo = "";

  chatscreen({required this.cid, required this.name, required this.email, required this.photo});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  File? selectedfile;
  TextEditingController _msg = TextEditingController();
  ScrollController _scrollController = ScrollController();

  // FocusNode focusnode = FocusNode();
  var sender = "";

  bool showEmoji = false;

  FocusNode focusNode = FocusNode();

  loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sender = prefs.getString("senderid").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          setState(() {
            showEmoji = false;
          });
        }
      },
    );
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (showEmoji) {
          setState(() {
            showEmoji = false;
          });
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                (widget.photo != "")
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          widget.photo,
                          width: 45.0,
                        ),
                      )
                    : const SizedBox(),
              ]),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            ),
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xffffffff),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: (sender != "")
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Userdata")
                              .doc(sender)
                              .collection("Chats")
                              .doc(widget.cid)
                              .collection("messages")
                              .orderBy("timestamp", descending: true)
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.size <= 0) {
                                return const Center(
                                  child: Text("No Chats"),
                                );
                              } else {
                                return ListView(
                                  controller: _scrollController,
                                  reverse: true,
                                  children: snapshot.data!.docs.map((document) {
                                    if (sender == document["senderid"].toString()) {
                                      return Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: const Color(0xffFFFFFF),
                                            ),
                                            margin: const EdgeInsets.all(5.0),
                                            padding: const EdgeInsets.all(10.0),
                                            child: (document["type"].toString() == "image")
                                                ? Image.network(
                                                    document["msg"],
                                                    width: 100.0,
                                                  )
                                                : Text(
                                                    document["msg"].toString(),
                                                    style: const TextStyle(color: Color(0xff368CFF), fontSize: 18.0),
                                                  ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: const Color(0xff1853A1),
                                            ),
                                            margin: const EdgeInsets.all(10.0),
                                            padding: const EdgeInsets.all(10.0),
                                            child: (document["type"].toString() == "image")
                                                ? Image.network(
                                                    document["msg"],
                                                    width: 100.0,
                                                  )
                                                : Text(
                                                    document["msg"].toString(),
                                                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                                                  ),
                                          ),
                                        ),
                                      );
                                    }
                                  }).toList(),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      : const SizedBox(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              controller: _msg,
                              onTap: () {
                                //key
                                if (showEmoji) {
                                  setState(() {
                                    showEmoji = !showEmoji;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.emoji_emotions_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showEmoji = !showEmoji;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.attach_file),
                                      onPressed: () async {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: () async {},
                                    ),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                            right: 2,
                            left: 2,
                          ),
                          child: CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xff1853A1),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {})),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
