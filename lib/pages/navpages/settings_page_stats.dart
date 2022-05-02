import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pedometer/pedometer.dart';
import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

import '../../db/floors_database.dart';
import '../../db/user.dart';


String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class SettingsPageStats extends StatefulWidget {
  const SettingsPageStats({Key? key,required this.activeUser}) : super(key: key);

  final User activeUser;

  @override
  State<SettingsPageStats> createState() => _SettingsPageStatsState();
}

class _SettingsPageStatsState extends State<SettingsPageStats> {

  var x;
  var y;
  var z;

  late List<User> users = [User(email: "", login: "", password: "", floors: widget.activeUser.floors)];
  late User user = new User(email: "", login: "", password: "", floors: widget.activeUser.floors);
  List<String> pom1 = [];

  @override
  void initState() {
    super.initState();
    refreshUsers();
    accelerometerEvents.listen((AccelerometerEvent event) {
      x = event.x;
      y = event.y;
      z = event.z;
    });
  }

  Future refreshUsers() async{
    this.user = await FloorsDatabase.instance.readUser(widget.activeUser.login);
    this.users = await FloorsDatabase.instance.readAllUsersForStats();
    getUser();
  }
  
  Future getUser() async{
    for(int i =0;i<=users.length-1;i++){
      pom1.add(users[i].login);
    }
    print(pom1.indexOf(widget.activeUser.login)+1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            //statistiky
            Center(child: AppLargeText(text: "Statistiky uživatele:", size: 20, color: AppColors.textColor1)),
            SizedBox(height: 20),
            Container(
              width: double.maxFinite,
              //height: double.maxFinite,
              child: Column(
                      children: [
                        //stat
                        AppLargeText(text: "Aktuální pozice v leaderboards:",size: 18,color: AppColors.textColor2,),
                        SizedBox(height: 20),
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(left:20,right: 20),
                          padding: const EdgeInsets.only(left:10,right: 10),
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
                              AppLargeText(text: (pom1.indexOf(widget.activeUser.login)+1).toString(), size: 18,color: AppColors.white)
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        AppLargeText(text: "Počet celkově nastoupaných pater:",size: 18,color: AppColors.textColor2,),
                        SizedBox(height: 20),
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(left:20,right: 20),
                          padding: const EdgeInsets.only(left:10,right: 10),
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
                              AppLargeText(text: user.floors.toString(), size: 18,color: AppColors.white,)
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
            ),
          ]
      ),
    );
  }
}
