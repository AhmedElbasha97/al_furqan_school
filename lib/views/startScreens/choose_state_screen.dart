import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:al_furqan_school/globals/widgets/expandable_text.dart';
import 'package:al_furqan_school/views/homeScreen.dart';
import 'package:al_furqan_school/views/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import 'contreller/start_screen_controller.dart';
class ChooseStateScreen extends StatefulWidget {
  const ChooseStateScreen({Key? key}) : super(key: key);

  @override
  State<ChooseStateScreen> createState() => _ChooseStateScreenState();
}

class _ChooseStateScreenState extends State<ChooseStateScreen> {
  @override
  CarouselController _carosuelController = CarouselController();
  int _current =0;
  var accountType ="hii";
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: StartScreen(),
      builder: (StartScreen controller) => Scaffold(
        body: controller.isLoading?Loader():Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CarouselSlider.builder(
                        carouselController: _carosuelController,
                        itemCount: controller.imageData.length,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return CachedNetworkImage(imageUrl: controller.imageData[index].img??"",
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height*0.45,
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) => SizedBox(
                              height: MediaQuery.of(context).size.height*0.45,
                              width: MediaQuery.of(context).size.width,
                              child:  FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CircularProgressIndicator(color: mainColor,),
                              ),
                            ),

                            errorWidget: (context, url, error) =>SizedBox(
                              height: MediaQuery.of(context).size.height*0.45,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset("assets/images/logo 2020 new.png"),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: controller.imageData.length == 1?false:true,
                          enlargeCenterPage: false,
                          scrollPhysics: controller.imageData.length == 1?NeverScrollableScrollPhysics():BouncingScrollPhysics(),
                          height: MediaQuery.of(context).size.height*0.45,
                          viewportFraction: 1.0,

                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor,width: 2),
                              borderRadius: BorderRadius.circular(10)

                          ),
                          height: MediaQuery.of(context).size.height*0.17,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,//.horizontal
                              child:  Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "من نحن",
                                          style: appText.copyWith(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),

                                      ),
                                    ),
                                  ),
                                  ExpandableText(
                                    "لطالما كان اختيار المدرسة المناسبة لأطفالنا مهمة صعبة، حيث أن حياتهم الاجتماعية والمهنية المستقبلية تعتمد بشكل أساسي على رحلتهم خلال التعليم المدرسي، ولذلك فأن من المهم توفير البيئة والتعليم الصحيح لهم، وتشجيع وتنمية قدراتهم الخاصة لإعدادهم للمستقبل بشكل سليم." +
                                        "أخلاق، انضباط وتفوق. من المتفق عليه ان التعليم وحده غير كاف لتكوين شخصيات أطفالنا بكفاءة، ففي مدارس الريان الخاصة نحن لا نركز على الجانب الأكاديمي فقط، بل نعمل أيضا وبجهد على أخلاق وانضباط الطلبة، وتوجيهم حسب تقاليد وأخلاق المجتمع العربي عامة والقطري خاصة، بالإضافة الى تطوير الجانب الذهني والاجتماعي والعاطفي والبدني، لإنشاء جيل مسؤول وواعي يستطيع مواجهة تحديات المجتمع أينما وجدت" +
                                        "وتمتلك مدارس الفرقان الخاصة إمكانيات وميزات تعليمية وتقنية فريدة لتوفير جو أكاديمي متكامل للطلبة، بالإضافة الى أنظمة عالمية متطورة تمكن أولياء الأمور من متابعة أحوال أبنائهم والتعاون مع المدرسين بشكل دوري ودائم. كما انا مدارس الفرقان الخاصة تحتوي على مساحات خضراء شاسعة وملاعب ومكتبات ومختبرات لتساعد الطلبة على تنمية الجانب الإبداعي لديهم." +
                                        "أن جميع العاملين في مدارس الريان الخاصة من إداريين وتربويين، خططوا وعملوا معا لتوفير مستوى تعليمي متميز وبيئة صحية وأخلاقية فريدة، وندعوكم الى زيارتنا والتعرف أكثر على منشأتنا وكوادرنا، ولمساعدتكم والرد على جميع استفساراتكم." +
                                        "مع كل الاحترام والتقدير، " , trimLines: 3, readMoreButtonTitle: 'اظهر المزيد',readLessButtonTitle: 'اظهر اقل',readMoreStyle: TextStyle(
                                    fontSize: 16.0, color: teal, fontWeight: FontWeight.bold
                                  ),textStyle: TextStyle(
                                    fontSize: 16.0, color: mainColor,
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            color: mainColor,
                              border: Border.all(color: mainColor,width: 2),
                              borderRadius: BorderRadius.circular(10)

                          ),
                          width: MediaQuery.of(context).size.width*0.95,
                          child: Padding(

                            padding: const EdgeInsets.all(10),
                            child: ListTile(

                              onTap: () {

                              },
                              tileColor: mainColor,
                              title:  ExpandableNotifier(

                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: false,
                                        child: ExpandablePanel(

                                          theme:  ExpandableThemeData(

                                            iconColor: white,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment.center,
                                            tapBodyToCollapse: true,
                                          ),
                                          header: Container(

                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "المدارس",maxLines: null,
                                                  softWrap: true,
                                                  style: TextStyle(fontSize: 15, color: white),
                                                ),

                                              ],
                                            ),
                                          ),
                                          expanded:Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => const HomeScreen(),
                                                  ));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.05,
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                    color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "مدرسة الفرقان الابتدائية",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => const HomeScreen(),
                                                  ));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.05,
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "مدرسة الفرقان الاعدادية",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => const HomeScreen(),
                                                  ));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.05,
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,

                                                      children: [
                                                        Text(
                                                          "مدرسة الفرقان الثانوية",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          collapsed: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("اختر المرحله",style: TextStyle(fontSize: 15, color: white),),
                                          ),
                                          builder: (_, collapsed, expanded) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, bottom: 10),
                                              child: Expandable(
                                                collapsed: collapsed,
                                                expanded: expanded,

                                                theme: const ExpandableThemeData(
                                                    crossFadePoint: 0),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),),
                          ),),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: mainColor,
                              border: Border.all(color: mainColor,width: 2),
                              borderRadius: BorderRadius.circular(10)

                          ),
                          width: MediaQuery.of(context).size.width*0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(

                              onTap: () {

                              },
                              tileColor: mainColor,
                              title:  ExpandableNotifier(

                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: false,
                                        child: ExpandablePanel(

                                          theme:  ExpandableThemeData(
                                            iconColor: white,
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment.center,
                                            tapBodyToCollapse: true,
                                          ),
                                          header: Container(

                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "المكاتب والأقسام",maxLines: null,
                                                  softWrap: true,
                                                  style: TextStyle(fontSize: 15, color: white),
                                                ),

                                              ],
                                            ),
                                          ),
                                          expanded:Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => const HomeScreen(),
                                                  ));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.05,
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "قسم 1",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => const HomeScreen(),
                                                  ));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.05,
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "قسم 2",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => const HomeScreen(),
                                                  ));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.05,
                                                  width: MediaQuery.of(context).size.width*0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,

                                                      children: [
                                                        Text(
                                                          "قسم 3",
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),

                                          collapsed: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("اختر قسم",style: TextStyle(fontSize: 15, color: white),),
                                          ),
                                          builder: (_, collapsed, expanded) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, bottom: 10),
                                              child: Expandable(
                                                collapsed: collapsed,
                                                expanded: expanded,

                                                theme: const ExpandableThemeData(
                                                    crossFadePoint: 0),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),),
                          ),),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
