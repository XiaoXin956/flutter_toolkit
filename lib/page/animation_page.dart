

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {

  bool isFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: Stack(
          children: [

            Center(child: AnimatedContainer(
              color: Colors.red,
              curve: Curves.easeInOutCubicEmphasized,
              duration: Duration(seconds: 2),
              width: isFlag?50:100,
              height:  isFlag?50:100,
            ),),
            AnimatedContainer(
              color: Colors.yellow,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 2),
              width:  isFlag?50:100,
              height:  isFlag?50:100,
            ),

            Positioned(child: ElevatedButton(onPressed: (){
              setState(() {
                isFlag = !isFlag;
              });
            }, child: Text("点击")),bottom: 0,),


          ],
        )
      ),
    );
  }
}
