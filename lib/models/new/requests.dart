

import 'dart:convert';

Requsts requstsFromJson(String str) => Requsts.fromJson(json.decode(str));

String requstsToJson(Requsts data) => json.encode(data.toJson());

class Requsts {
  Requsts({
    this.status,
    this.msg,
  });

  String? status;
  String? msg;

  factory Requsts.fromJson(Map<String, dynamic> json) => Requsts(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
  };
}
