import 'dart:math';

import 'package:ebrana_schody/db/achievement.dart';
import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db/user.dart';

class StatPage extends StatefulWidget {
  const StatPage({Key? key, required this.activeUser}) : super(key: key);

  final User activeUser;

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {

  late List<Achievement> achievements;
  late List<User> users;

  @override
  void initState(){
    super.initState();
    checkAchievements();
  }

  Future checkAchievements() async {
    this.achievements = await FloorsDatabase.instance.readAllAchievements();
    this.users = await FloorsDatabase.instance.readAllUsersForStats();

  }

  List mountains = [
    107,
    533,
    885,
    987,
    1603,
    2949,
  ];

  List mountainsNames = [
    "Vaalserberg",
    "Sněžka",
    "Gerlachovský štít",
    "Zugspitze",
    "Mont Blanc",
    "Mount Everest",
  ];

  List mountainsImages = [
    "vaalsberg.png",
    "snezka.jpg",
    "gerlach.png",
    "zug.png",
    "mb.png",
    "everest.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                //logo-top
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppLargeText(text: widget.activeUser.login, color: AppColors.textColor1,size: 20),
                            SizedBox(height: 10),
                            Container(
                                padding:const EdgeInsets.only(left:50, right: 50),
                                child:
                                AppText(text: "Seznam dosažených achievementů uživatele "+widget.activeUser.login+"!"))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                  width: double.maxFinite,
                  //height: double.maxFinite,
                  child: ListView.builder(
                      physics: ScrollPhysics(parent: null),
                      shrinkWrap: true,
                      itemCount: mountains.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index){
                        return Column(
                          children: [
                            //achievement
                            Container(
                              width: double.maxFinite,
                              //height: 200,
                              margin: const EdgeInsets.only(left:20,right: 20),
                              padding: const EdgeInsets.only(left:20,right: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        padding:const EdgeInsets.only(left:20, right: 20,),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(80),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "img/"+mountainsImages[index]
                                                ),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      Container(
                                        //transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                                        width: 200,
                                        padding:const EdgeInsets.only(left:20, top:20, bottom:20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            AppLargeText(text: mountainsNames[index], color: AppColors.textColor2,size: 18),
                                            AppText(text: "Počet vystoupaných pater odpovídá výšce dané hory."),
                                            SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:200,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(width: 4,color: AppColors.textColor2)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: (widget.activeUser.floors.toDouble()/mountains[index])*200,
                                                  constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
                                                  transform: Matrix4.translationValues(0.0, -4.0, 0.0),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(width: 4,color: AppColors.textColor1)
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            AppText(text: widget.activeUser.floors.toString()+"/"+mountains[index].toString()),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        );
                      }),
                ),
              ]
          ),
        )
    );
  }
}
