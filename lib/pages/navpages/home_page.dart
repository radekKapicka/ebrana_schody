import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebrana_schody/misc/colors.dart';

import '../../db/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<User> users;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();

    refreshUsers();
  }

  Future refreshUsers() async{
    setState(() => isLoading = true);
    this.users = await FloorsDatabase.instance.readAllUsers();
    setState(() => isLoading = false);
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
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              width: double.maxFinite,
              height: double.maxFinite,
              child:isLoading
              ? CircularProgressIndicator()
              : users.isEmpty
                ? AppText(
                  text: "žádní uživatelé",
              ): ListView.builder(
                itemCount: users.length,
                itemBuilder: (_,index){
                  final user = users[index];
                  refreshUsers();
                  return AppText(text: user.login);
                },
              ),
            ),
              /*ListView.builder(
                physics: ScrollPhysics(parent: null),
                shrinkWrap: true,
                itemCount: 10,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index){
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
                                          "img/chad.jpeg"
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                              child: Column(
                                children: [
                                  AppLargeText(text: "@jmeno", color: AppColors.textColor1,size: 20),
                                  SizedBox(height: 10),
                                  AppText(text: "Uživatel @giga_chad právě dosáhl vystoupal na úrověň hory Mont Blanc!")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 70),
                    ],
                  );
                  })*/
          ]
        ),
      )
    );
  }
}
