import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebrana_schody/misc/colors.dart';

import '../../db/floors_database.dart';
import '../../db/user.dart';

class LadderPage extends StatefulWidget {
  const LadderPage({Key? key}) : super(key: key);

  @override
  State<LadderPage> createState() => _LadderPageState();
}

class _LadderPageState extends State<LadderPage> {

  late List<User> users;

  @override
  void initState(){
    super.initState();
    refreshUsers();
  }

  Future refreshUsers() async{
    this.users = await FloorsDatabase.instance.readAllUsersForStats();

  }

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
                  transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                  width: double.maxFinite,
                  //height: 200,
                  margin: const EdgeInsets.only(left:20,right: 20),
                  padding: const EdgeInsets.only(left:20,right: 20, top: 10, bottom:10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 4,color: AppColors.textColor1)
                        ),
                  ),
                  child:
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppLargeText(text: "pořadí",color: AppColors.textColor1, size: 22),
                          AppLargeText(text: "jméno", color: AppColors.textColor1,size: 22),
                          AppLargeText(text: "patra", color: AppColors.textColor1,size: 22)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -65.0, 0.0),
                  width: double.maxFinite,
                  //height: double.maxFinite,
                  child: ListView.builder(
                      physics: ScrollPhysics(parent: null),
                      shrinkWrap: true,
                      itemCount: users.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index){
                        return Column(
                          children: [
                            //radek
                            Container(
                              width: double.maxFinite,
                              //height: 200,
                              margin: const EdgeInsets.only(left:20,right: 20),
                              padding: const EdgeInsets.only(left:20,right: 20, top: 10, bottom:10),
                              decoration: BoxDecoration(
                                color: index.isEven ? Colors.white: AppColors.lightGrey,
                              ),
                              child:
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppLargeText(text: "#"+(index+1).toString(),color: AppColors.textColor2, size: 20),
                                      AppLargeText(text: users[index].login, color: AppColors.textColor2,size: 20),
                                      AppLargeText(text: users[index].floors.toString(), color: AppColors.textColor2,size: 20),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
