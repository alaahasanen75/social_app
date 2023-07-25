class ChatModel {
  String? senderId;
  String? reseverId;
  String? text;
  String? textTime;

  ChatModel({this.reseverId, this.text, this.senderId, this.textTime});
  ChatModel.fromJson(Map<String, dynamic>? json) {
    reseverId = json!['reseverId'];
    senderId = json['senderId'];
    text = json['text'];
    textTime = json['textTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      ' reseverId': reseverId!,
      'senderId': senderId!,
      ' textTime': textTime,
      'text': text,
    };
  }
}
