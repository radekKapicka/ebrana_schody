import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top:150,left:20, right:20),
                  child:
                        Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.only(top:50, left:20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "img/logo.png"
                                      )
                                  )
                              ),
                            ),
                            SizedBox(height: 30,),
                            AppLargeText(text: "Přihlášení", color: AppColors.textColor1),
                            SizedBox(height: 20,),
                            InputText(hintText: "Přihlašovací jméno", labelText: "Login", secureText: false),
                            SizedBox(height: 20,),
                            InputText(hintText: "Vaše heslo", labelText: "Heslo", secureText: true),
                            SizedBox(height: 20,),
                            ResponsiveButton(textButton: "Přihlásit se"),
                            SizedBox(height: 20,),
                            AppText(text: "Nemáte ještě účet?"),
                            SizedBox(height: 20,),
                            ResponsiveButton(textButton: "Zaregistrovat se"),
                          ],
                        )
                  ),
              ],
            ),
      ),
    );
  }
}
