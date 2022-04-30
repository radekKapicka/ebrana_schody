import 'package:crypt/crypt.dart';
import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/pages/navpages/settings_page.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db/achievement.dart';
import '../../db/user.dart';
import '../../widgets/app_text.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.activeUser}) : super(key: key);

  final User activeUser;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final pwdController = TextEditingController();
  final pwdNewController = TextEditingController();
  String pwd = "";
  String pwdNew = "";

  final formKeyEdit = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left:20, right: 20),
      child: Form(
        key: formKeyEdit,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              //statistiky
              Center(child: AppLargeText(text: "Změna hesla:", size: 20, color: AppColors.textColor1)),
              SizedBox(height: 20),
              TextFormField(
                controller: pwdController,
                decoration: InputDecoration(
                  hintText: "Zadejte své staré heslo",
                  labelText: "Staré heslo",
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
              SizedBox(height: 20),
              TextFormField(
                controller: pwdNewController,
                decoration: InputDecoration(
                  hintText: "Zadejte nové heslo",
                  labelText: "Nové heslo",
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
                        () => this.pwdNew = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    child:
                    AppText(text: "Změnit heslo"),
                    onPressed: (){
                      if(formKeyEdit.currentState!.validate()){
                        OldPassControll();
                      }
                    }
                ),
              ),
              SizedBox(height: 40),
              Center(child: AppLargeText(text: "Editace:", size: 20, color: AppColors.textColor1)),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    child:
                    AppText(text: "Přidat achievement"),
                    onPressed: (){
                      var test3 = widget.activeUser.id;
                      final achievement = Achievement(
                          user_id: widget.activeUser.login,
                          datestamp: DateTime.now(),
                          achievementlvl: 5);
                          FloorsDatabase.instance.createAchievement(achievement);
                          print(FloorsDatabase.instance.readAllAchievements());
                    }
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    child:
                    AppText(text: "Resetovat patra"),
                    onPressed: (){
                        StatReset();
                    }
                ),
              ),
            ]
        ),
      ),
    );
  }

  Future OldPassControll() async{

    if(widget.activeUser.password == Crypt.sha256(pwdController.text, salt: "radekjenejvetsiborec").toString()){
      final user = widget.activeUser.copy(
          id: widget.activeUser.id,
          email: widget.activeUser.email,
          login: widget.activeUser.login,
          password: Crypt.sha256(pwdNewController.text, salt: "radekjenejvetsiborec").toString(),
          floors: widget.activeUser.floors);

      await FloorsDatabase.instance.update(user);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SettingsPage(activeUser: widget.activeUser),
      ));
    }else{
      throw Exception("staré heslo je zadané špatně");
    }
  }
  Future StatReset() async{
    final user = widget.activeUser.copy(
        id: widget.activeUser.id,
        email: widget.activeUser.email,
        login: widget.activeUser.login,
        password: widget.activeUser.password,
        floors: 1100);

    await FloorsDatabase.instance.update(user);
  }
}