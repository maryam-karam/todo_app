import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuer=MediaQuery.of(context).size;
    var theme=Theme.of(context);
    return Container(
      width: mediaQuer.width,
      height: 115,
      margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            color:theme.primaryColor ,
            height: 90,
            width: 5,
          ),
        ],
      ),
    );
  }
}
