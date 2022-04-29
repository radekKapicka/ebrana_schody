import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/db/user.dart';
import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {

  const RegistrationPage({Key? key, required this.values}) : super(key: key);

  final String values;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
class _RegistrationPageState extends State<RegistrationPage> {
  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final pwdControllController = TextEditingController();
  String login = "";
  String email = "";
  String pwd = "";
  String pwdControll = "";

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
                    //InputText(hintText: "Přihlašovací jméno", labelText: "Login", secureText: false),
                    TextField(
                      controller: loginController,
                      decoration: InputDecoration(
                        hintText: "Přihlašovací jméno",
                        labelText: "Login",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: AppColors.textColor2,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: false,
                      onChanged: (value){
                        setState(() {
                          () => this.login = value;
                        });
                      },
                      onSubmitted: (value){
                        setState(() {
                              () => this.login = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Zadejte Váš email",
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: AppColors.textColor2,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: false,
                      onChanged: (value){
                        setState(() {
                              () => this.email = value;
                        });
                      },
                      onSubmitted: (value){
                        setState(() {
                              () => this.email = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: pwdController,
                      decoration: InputDecoration(
                        hintText: "Zvolte si heslo",
                        labelText: "Heslo",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: AppColors.textColor2,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      onChanged: (value){
                        setState(() {
                              () => this.pwd = value;
                        });
                      },
                      onSubmitted: (value){
                        setState(() {
                              () => this.pwd = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: pwdControllController,
                      decoration: InputDecoration(
                        hintText: "Kotrola zadání hesla",
                        labelText: "Kontrola hesla",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: AppColors.textColor2,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      onChanged: (value){
                        setState(() {
                              () => this.pwdControll = value;
                        });
                      },
                      onSubmitted: (value){
                        setState(() {
                              () => this.pwdControll = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      child:
                        AppText(text: "Zaregistrovat se"),
                        onPressed: (){
                          addUser();
                        }
                    ),
                    //AppText(text: login),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
  Future addUser() async{
    if(pwdController.text == pwdControllController.text){
      final user = User(
          email: emailController.text,
          login: loginController.text,
          password: pwdController.text,
          floors: 0);
      await FloorsDatabase.instance.create(user);
      //print("uspech"+emailController.text+loginController.text+pwdController.text);
    }else{
      throw Exception("hesla se neshodují");
    }
    //print(loginController.text);
    //await FloorsDatabase.instance.create(user);
  }
}
