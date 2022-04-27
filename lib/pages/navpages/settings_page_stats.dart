import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPageStats extends StatelessWidget {
  const SettingsPageStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            //statistiky
            Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              width: double.maxFinite,
              //height: double.maxFinite,
              child: ListView.builder(
                  physics: ScrollPhysics(parent: null),
                  shrinkWrap: true,
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index){
                    return Column(
                      children: [
                        //stat
                        AppLargeText(text: "Aktuální pozice v leaderboards:",size: 18,color: AppColors.textColor2,),
                        SizedBox(height: 20),
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(left:20,right: 20),
                          padding: const EdgeInsets.only(left:20,right: 20),
                          decoration: BoxDecoration(
                            color: AppColors.textColor1,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppLargeText(text: "1", size:20,color: Colors.white,)
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    );
                  }),
            ),
          ]
      ),
    );
  }
}
