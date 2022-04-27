import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/pages/navpages/edit_page.dart';
import 'package:ebrana_schody/pages/navpages/settings_page_stats.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List pages = [
    SettingsPageStats(),
    EditPage(),
  ];
  int currentIndex =0;
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                //logo-top
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top:200, left:20),
                      width:200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "img/logo.png"
                              )
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          if(clickCounter % 2 == 0){
                            currentIndex = 1;
                          }else{
                            currentIndex = 0;
                          }
                          clickCounter++;
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(left:60,right: 20,top: 10),
                        //padding: const EdgeInsets.only(left:20,right: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: currentIndex == 1 ? AssetImage(
                                "img/x.png"
                            ):
                            AssetImage(
                                "img/pencil.png"
                            ),
                            //fit: BoxFit.cover
                          ),
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
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                        width: 80,
                        height: 80,
                        margin:const EdgeInsets.only(top:20),
                        padding:const EdgeInsets.only(left:20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            image: DecorationImage(
                                image: AssetImage(
                                    "img/chad.jpeg"
                                ),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                        padding:const EdgeInsets.only(left:20, right: 20),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppLargeText(text: "@jmeno", color: AppColors.textColor1,size: 20),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                      pages[currentIndex],
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}
