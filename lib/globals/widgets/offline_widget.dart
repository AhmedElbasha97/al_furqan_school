import 'package:al_furqan_school/globals/commonStyles.dart';
import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
 final Function  refreshedFunc;
  const OfflineWidget({Key? key, required this.refreshedFunc }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 70,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: ElevatedButton.icon(onPressed: (){
              refreshedFunc();
            }, icon: Icon(Icons.refresh,color: mainColor,), label:  Text("حاول التصال مره اخر",style: TextStyle(color: mainColor,fontSize: 10),),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(white),
              elevation: MaterialStateProperty.all(0),
            ),),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("تحقق من اتصال الانترنت لديك"),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/cross.png",height: 20,width: 20,),
          ),

        ],
      ),
    );
  }
}
