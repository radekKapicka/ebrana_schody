import 'package:crypt/crypt.dart';
import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/pages/navpages/home_page.dart';
import 'package:ebrana_schody/pages/navpages/main_page.dart';
import 'package:ebrana_schody/pages/registration_page.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/achievement.dart';
import '../db/floors_database.dart';
import '../db/user.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final loginController = TextEditingController();
  final pwdController = TextEditingController();

  String login = "";
  String pwd = "";
  final formKeyLog = GlobalKey<FormState>();

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
                          key: formKeyLog,
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
                              AppLargeText(text: "Přihlášení", color: AppColors.textColor1),
                              SizedBox(height: 20,),
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
                                  refreshUsers();
                                  setState(() {
                                        () => this.pwd = value;
                                  });
                                },
                              ),
                              SizedBox(height: 20,),
                              ElevatedButton(
                                  child:
                                  AppText(text: "Přihlásit se"),
                                  onPressed: (){
                                    //refreshUsers();
                                    if(formKeyLog.currentState!.validate()){
                                      check();
                                    }
                                  }
                              ),
                              SizedBox(height: 20,),
                              AppText(text: "Nemáte ještě účet?"),
                              SizedBox(height: 20,),
                              ElevatedButton(
                                child:
                                  AppText(text: "Zaregistrovat se"),
                                  onPressed: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const RegistrationPage())
                                    );
                                  }
                                ),
                            ],
                          ),
                        )
                  ),
              ],
            ),
      ),
    );
  }

  Future check() async{

    User user = User(email: "", login: "", password: "", floors: 0);

    for(int i=0;i<=users.length-1;i++){
      if((users[i].login == "@"+loginController.text) && (users[i].password == Crypt.sha256(pwdController.text, salt: "radekjenejvetsiborec").toString())){
        user = users[i];

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainPage(activeUser: user),
        ));
        break;
      }else{
        if(i == users.length-1){
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: AppLargeText(text: "Přihlášení se nepodařilo"),
                content: AppText(text:"Bylo zadáno špatné heslo nebo login"),
                actions: [
                  ElevatedButton(
                    child:
                    AppText(text: "Zkusit znovu"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
          );
        }
      }
    }
  }
}
