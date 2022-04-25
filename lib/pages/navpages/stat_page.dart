import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatPage extends StatelessWidget {
  const StatPage({Key? key}) : super(key: key);

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
                            AppLargeText(text: "@jmeno", color: AppColors.textColor1,size: 20),
                            SizedBox(height: 10),
                            Container(
                                padding:const EdgeInsets.only(left:50, right: 50),
                                child:
                                AppText(text: "Seznam dosažených achievementů uživatele @giga_chad!"))
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
                      itemCount: 5,
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
                                                    "img/snezka.jpg"
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
                                            AppLargeText(text: "Sněžka", color: AppColors.textColor2,size: 18),
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
                                                  width: 150,
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
                                            AppText(text: "450/460"),
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
