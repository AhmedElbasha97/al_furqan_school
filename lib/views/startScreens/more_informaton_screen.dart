import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../homeScreen.dart';
class MoreInformationScreen extends StatefulWidget {
  const MoreInformationScreen({Key? key}) : super(key: key);

  @override
  State<MoreInformationScreen> createState() => _MoreInformationScreenState();
}

class _MoreInformationScreenState extends State<MoreInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:  IconThemeData(color: mainColor),
        backgroundColor: white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo 2020 new.png",
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitHeight,),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.6,
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: mainColor,width: 2),
                    borderRadius: BorderRadius.circular(10)

                ),
                height: MediaQuery.of(context).size.height*0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,//.horizontal
                    child: Text(
                      "لطالما كان اختيار المدرسة المناسبة لأطفالنا مهمة صعبة، حيث أن حياتهم الاجتماعية والمهنية المستقبلية تعتمد بشكل أساسي على رحلتهم خلال التعليم المدرسي، ولذلك فأن من المهم توفير البيئة والتعليم الصحيح لهم، وتشجيع وتنمية قدراتهم الخاصة لإعدادهم للمستقبل بشكل سليم." +
                          "أخلاق، انضباط وتفوق. من المتفق عليه ان التعليم وحده غير كاف لتكوين شخصيات أطفالنا بكفاءة، ففي مدارس الريان الخاصة نحن لا نركز على الجانب الأكاديمي فقط، بل نعمل أيضا وبجهد على أخلاق وانضباط الطلبة، وتوجيهم حسب تقاليد وأخلاق المجتمع العربي عامة والقطري خاصة، بالإضافة الى تطوير الجانب الذهني والاجتماعي والعاطفي والبدني، لإنشاء جيل مسؤول وواعي يستطيع مواجهة تحديات المجتمع أينما وجدت" +
                          "وتمتلك مدارس الفرقان الخاصة إمكانيات وميزات تعليمية وتقنية فريدة لتوفير جو أكاديمي متكامل للطلبة، بالإضافة الى أنظمة عالمية متطورة تمكن أولياء الأمور من متابعة أحوال أبنائهم والتعاون مع المدرسين بشكل دوري ودائم. كما انا مدارس الفرقان الخاصة تحتوي على مساحات خضراء شاسعة وملاعب ومكتبات ومختبرات لتساعد الطلبة على تنمية الجانب الإبداعي لديهم." +
                          "أن جميع العاملين في مدارس الريان الخاصة من إداريين وتربويين، خططوا وعملوا معا لتوفير مستوى تعليمي متميز وبيئة صحية وأخلاقية فريدة، وندعوكم الى زيارتنا والتعرف أكثر على منشأتنا وكوادرنا، ولمساعدتكم والرد على جميع استفساراتكم." +
                          "مع كل الاحترام والتقدير، " ,

                      style:  TextStyle(
                        fontSize: 16.0, color: mainColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
