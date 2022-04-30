import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebrana_schody/misc/colors.dart';

import '../../db/achievement.dart';
import '../../db/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.activeUser}) : super(key: key);

  final User activeUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Achievement> achievementsAll;
  late List<User> users;

  @override
  void initState(){
    super.initState();

    checkAchievements();
  }

  Future checkAchievements() async {
    this.achievementsAll = (await FloorsDatabase.instance.readAllAchievements());
    this.users = await FloorsDatabase.instance.readAllUsersForStats();
  }

  List mountains = [
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
            /*Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              width: double.maxFinite,
              height: double.maxFinite,
              child: ListView.builder(
                physics: ScrollPhysics(parent: null),
                shrinkWrap: true,
                itemCount: achievementsAll.length,
                itemBuilder: (_,index){
                  checkAchievements();
                  return Column(
                    children: [
                      AppText(text:achievementsAll[index].id.toString()),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
              ),
            ),*/
              ListView.builder(
                physics: ScrollPhysics(parent: null),
                shrinkWrap: true,
                itemCount: achievementsAll.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index){
                  checkAchievements();
                  return Column(
                    children: [
                      //karta
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
                            Container(
                              transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                              width: 80,
                              height: 80,
                              margin:const EdgeInsets.only(top:20),
                              padding:const EdgeInsets.only(left:20, right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "img/"+mountainsImages[achievementsAll[index].achievementlvl]
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                              child: Column(
                                children: [
                                  AppLargeText(text: achievementsAll[index].user_id, color: AppColors.textColor1,size: 20),
                                  SizedBox(height: 10),
                                  AppText(text: "Uživatel "+achievementsAll[index].user_id+" právě vystoupal na úrověň hory "+ mountains[achievementsAll[index].achievementlvl] +"!")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 70),
                    ],
                  );
                  })
          ]
        ),
      )
    );
  }
}
