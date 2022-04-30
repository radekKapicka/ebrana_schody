import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/db/user.dart';
import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/pages/navpages/home_page.dart';
import 'package:ebrana_schody/pages/welcome_page.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';

import 'navpages/main_page.dart';

class RegistrationPage extends StatefulWidget {

  const RegistrationPage({Key? key}) : super(key: key);

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
  final formKey = GlobalKey<FormState>();

  late List<User> users;

  @override
  Widget build(BuildContext context) {

    Future refreshUsers() async{
      //setState(() => isLoading = true);
      this.users = await FloorsDatabase.instance.readAllUsers();
      //setState(() => isLoading = false);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top:150,left:20, right:20),
                child:
                Form(
                  key: formKey,
                  child: Column(
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
                      TextFormField(
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
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
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
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)){
                            return "Zadej email ve správném tvaru";
                          }else{
                            return null;
                          }
                        },
                        onChanged: (value){
                          setState(() {
                                () => this.email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
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
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$').hasMatch(value!)){
                            return "8 znaků, velké, malé písmeno a jedno číslo";
                          }else{
                            return null;
                          }
                        },
                        onChanged: (value){
                          setState(() {
                                () => this.pwd = value;
                          });
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
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
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$').hasMatch(value!)){
                            return "8 znaků, velké, malé písmeno a jedno číslo";
                          }else{
                            return null;
                          }
                        },
                        onChanged: (value){
                          refreshUsers();
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
                          refreshUsers();
                          if(formKey.currentState!.validate()){
                            addUser();
                          }
                          }
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          child:
                          AppText(text: "Zpět k přihlášení"),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const WelcomePage())
                            );
                          }
                      ),
                      //AppText(text: login),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
  Future addUser() async{
    if(pwdController.text == pwdControllController.text && !users.contains(loginController.text)){
      final user = User(
          email: emailController.text,
          login: "@"+loginController.text,
          password: Crypt.sha256(pwdController.text, salt: "radekjenejvetsiborec").toString(),
          floors: 0);
      await FloorsDatabase.instance.create(user);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MainPage(activeUser: user),
      ));
      //print(pwdController.text);
    }else{
      throw Exception("hesla se neshodují nebo login již existuje");
    }
    //print(loginController.text);
    //await FloorsDatabase.instance.create(user);
  }
}
