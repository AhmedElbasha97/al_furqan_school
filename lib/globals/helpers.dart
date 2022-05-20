import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:al_furqan_school/I10n/AppLanguage.dart';
import 'package:al_furqan_school/I10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

Widget changeLangPopUp(BuildContext context) {
  var appLanguage = Provider.of<AppLanguage>(context);
  return CupertinoActionSheet(
    title:  Text('${AppLocalizations.of(context)!.translate('language')}'),
    message:
         Text('${AppLocalizations.of(context)!.translate('changeLanguage')}'),
    actions: <Widget>[
      CupertinoActionSheetAction(
        child:  const Text('English'),
        onPressed: () {
          appLanguage.changeLanguage(const Locale("en"));
          Navigator.pop(context);
        },
      ),
      CupertinoActionSheetAction(
        child:  const Text('عربى'),
        onPressed: () {
          appLanguage.changeLanguage(const Locale("ar"));
          Navigator.pop(context);
        },
      )
    ],
    cancelButton: CupertinoActionSheetAction(
      child: const Text('رجوع'),
      isDefaultAction: true,
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    ),
  );
}

////////////////////////////////////////////////
/// Page Navigation pages
////////////////////////////////////////////////
void popPage(BuildContext context) {
  Navigator.of(context).pop();
}

void pushPage(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void pushPageReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

////////////////////////////////////////////////
/// utilities
////////////////////////////////////////////////
bool emailvalidator(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

////////////////////////////////////////////////
////////////////////////////////////////////////

void showTheDialog(BuildContext context, String title, String body,
    {Widget? extraAction}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      List<Widget> actions = [];
      actions.add(
        ElevatedButton(
          child: Text(AppLocalizations.of(context)!.translate('back')!),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
      if (extraAction != null) {
        actions.add(extraAction);
      }
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text(title),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            children: <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: actions,
      );
    },
  );
}

launchURL(String url,String socialAppName,context) async {
  if(url!="") {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showTheDialog(context,"لا يمكن فتح $socialAppName","غير متاح اي لينك للتواصل علي هذه المنصه لان حاول لاحقا");
      throw 'Could not launch $url';
    }
  }else{
    showTheDialog(context,"لا يمكن فتح $socialAppName","غير متاح اي لينك للتواصل علي هذه المنصه لان حاول لاحقا");
  }
}
