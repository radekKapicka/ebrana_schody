import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/db/user.dart';
import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class registrationPage extends StatefulWidget {

  const registrationPage({Key? key, required this.values}) : super(key: key);

  final List<String> values;

  @override
  State<registrationPage> createState() => _registrationPageState();
}
class _registrationPageState extends State<registrationPage> {
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
                    AppLargeText(text: "Registrace", color: AppColors.textColor1),
                    SizedBox(height: 20,),
                    InputText(hintText: "Přihlašovací jméno", labelText: "Login", secureText: false),
                    SizedBox(height: 20,),
                    InputText(hintText: "E-mailová adresa", labelText: "E-mail", secureText: false),
                    SizedBox(height: 20,),
                    InputText(hintText: "Zvolte si heslo", labelText: "Heslo", secureText: true),
                    SizedBox(height: 20,),
                    InputText(hintText: "Kotrola zadání hesla", labelText: "Kontrola hesla", secureText: true),
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
  Future addUser() async{
    final user = User(
        email: widget.values[0],
        login: 'test',
        password: 'test',
        floors: 0);

    await FloorsDatabase.instance.create(user);
  }
}
