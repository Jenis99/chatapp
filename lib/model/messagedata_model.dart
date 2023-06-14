class MessagesData {
  String? message;
  String? receiverId;
  String? senderId;
  int? timeStamp;
  String? type;

  MessagesData(
      {this.message,
        this.receiverId,
        this.senderId,
        this.timeStamp,
        this.type});

  MessagesData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    timeStamp = json['timeStamp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['receiverId'] = this.receiverId;
    data['senderId'] = this.senderId;
    data['timeStamp'] = this.timeStamp;
    data['type'] = this.type;
    return data;
  }
}
