import 'dart:convert';

SocialLinkModel socialLinkModelFromJson(String str) => SocialLinkModel.fromJson(json.decode(str));

String socialLinkModelToJson(SocialLinkModel data) => json.encode(data.toJson());

class SocialLinkModel {
  SocialLinkModel({
    this.facebook,
    this.instagram,
    this.snapchat,
    this.whatsapp,
    this.twitter,
    this.androidLink,
    this.iosLink,
  });

  String? facebook;
  String? instagram;
  String? snapchat;
  String? whatsapp;
  String? twitter;
  String? androidLink;
  String? iosLink;

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) => SocialLinkModel(
    facebook: json["facebook"],
    instagram: json["instagram"],
    snapchat: json["snapchat"],
    whatsapp: json["whatsapp"] ,
    twitter: json["twitter"] ,
    androidLink: json["android_link"],
    iosLink: json["ios_link"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook ,
    "instagram": instagram ,
    "snapchat": snapchat,
    "whatsapp": whatsapp ,
    "twitter": twitter,
    "android_link": androidLink,
    "ios_link": iosLink,
  };
}