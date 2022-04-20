import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "bg-image.jpg",
    "logo.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(itemBuilder: (_, index){
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "img/"+images[0]
              ),
              fit: BoxFit.cover
            )
          ),
          child: Container(
            margin: const EdgeInsets.only(top:150,left:20, right:20),
            child: Center(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppLargeText(text: "Přihlášení", color: AppColors.textColor1),
                      SizedBox(height: 20,),
                      ResponsiveButton(textButton: "Přihlásit se"),
                      SizedBox(height: 20,),
                      AppText(text: "Nemáte ještě účet?"),
                      SizedBox(height: 20,),
                      ResponsiveButton(textButton: "Zaregistrovat se"),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
