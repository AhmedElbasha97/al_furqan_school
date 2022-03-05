import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الطلاب المسجلين"),
        centerTitle: true,
        iconTheme:  IconThemeData(color: white),
        backgroundColor: mainColor,
      ),
      body:ListView.builder(
        itemCount: 10,
        
        itemBuilder:   (BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: mainColor,
            width: 2
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("اسم الطالب ",style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
                const Text("المرحالة الدراسية",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),)
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,color: mainColor,)
          ],
        ),
      ),
    );
    

        } ,
      )
    );
  }
}
