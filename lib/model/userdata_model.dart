class UserData {
  String? userEmail;
  String? userId;
  String? userName;
  String? userProfileUrl;

  UserData({this.userEmail, this.userId, this.userName, this.userProfileUrl});

  UserData.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'];
    userId = json['userId'];
    userName = json['userName'];
    userProfileUrl = json['userProfileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userEmail'] = this.userEmail;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userProfileUrl'] = this.userProfileUrl;
    return data;
  }
}
