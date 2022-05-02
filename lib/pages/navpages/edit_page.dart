import 'package:crypt/crypt.dart';
import 'package:ebrana_schody/db/floors_database.dart';
import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/pages/navpages/main_page.dart';
import 'package:ebrana_schody/pages/navpages/settings_page.dart';
import 'package:ebrana_schody/pages/navpages/settings_page_stats.dart';
import 'package:ebrana_schody/pages/navpages/stat_page.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

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

  late List<Achievement> achievements;

  late Stream<StepCount> _stepCountStream;
  String _steps = '?';

  int myStep=0;

  @override
  void initState(){
    super.initState();
    checkAchievements();
    initPlatformState();
  }


  Future checkAchievements() async {
    this.achievements = await FloorsDatabase.instance.readAllAchievements();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      myStep+=1;
      _steps = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  List mountains = [
    107,
    533,
    885,
    987,
    1603,
    2949,
  ];

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
                    AppText(text: "Synchronizovat statistiky"),
                    onPressed: (){
                      checkAchievements();
                      StatSync();
                    }
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    child:
                    AppText(text: "Resetovat patra"),
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: AppLargeText(text: "Reset statistik"),
                            content: AppText(text:"Opravdu chcete resetovat statistiky?"),
                            actions: [
                              ElevatedButton(
                                child:
                                AppText(text: "ANO"),
                                  onPressed: (){
                                    StatReset();
                                  }
                              ),
                              ElevatedButton(
                                child:
                                AppText(text: "NE"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          )
                      );
                      //FloorsDatabase.instance.deleteAchi();
                    }
                ),
              ),
              SizedBox(height: 20),
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
        builder: (context) => MainPage(activeUser: widget.activeUser),
      ));
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: AppLargeText(text: "Změna hesla proběhla v pořádku"),
            content: AppText(text:"Vaše heslo bylo změněno"),
            actions: [
              ElevatedButton(
                child:
                AppText(text: "OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          )
      );
    }else{
      //throw Exception("staré heslo je zadané špatně");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: AppLargeText(text: "Změna hesla se nepodařila"),
            content: AppText(text:"Staré heslo je zadané špatně"),
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

  Future StatReset() async{
    final user = widget.activeUser.copy(
        id: widget.activeUser.id,
        email: widget.activeUser.email,
        login: widget.activeUser.login,
        password: widget.activeUser.password,
        floors: 0);

    await FloorsDatabase.instance.update(user);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainPage(activeUser: user),
    ));
  }

  Future StatSync() async{

    final user = widget.activeUser.copy(
        id: widget.activeUser.id,
        email: widget.activeUser.email,
        login: widget.activeUser.login,
        password: widget.activeUser.password,
        floors: widget.activeUser.floors + myStep);
    myStep = 0;

    if(widget.activeUser.floors >= mountains[0] && widget.activeUser.floors < mountains[1]){
      final achievement = Achievement(
          user_id: widget.activeUser.login,
          datestamp: DateTime.now(),
          achievementlvl: 0);

        await FloorsDatabase.instance.createAchievement(achievement);
    }else if(widget.activeUser.floors >= mountains[1] && widget.activeUser.floors < mountains[2]){
      final achievement = Achievement(
          user_id: widget.activeUser.login,
          datestamp: DateTime.now(),
          achievementlvl: 1);

      await FloorsDatabase.instance.createAchievement(achievement);
    }else if(widget.activeUser.floors >= mountains[2] && widget.activeUser.floors < mountains[3]){
      final achievement = Achievement(
          user_id: widget.activeUser.login,
          datestamp: DateTime.now(),
          achievementlvl: 2);

      await FloorsDatabase.instance.createAchievement(achievement);
    }else if(widget.activeUser.floors >= mountains[3] && widget.activeUser.floors < mountains[4]){
      final achievement = Achievement(
          user_id: widget.activeUser.login,
          datestamp: DateTime.now(),
          achievementlvl: 3);

      await FloorsDatabase.instance.createAchievement(achievement);
    }else if(widget.activeUser.floors >= mountains[4] && widget.activeUser.floors < mountains[5]){
      final achievement = Achievement(
          user_id: widget.activeUser.login,
          datestamp: DateTime.now(),
          achievementlvl: 4);

      await FloorsDatabase.instance.createAchievement(achievement);
    }else if(widget.activeUser.floors >= mountains[5]){
      final achievement = Achievement(
          user_id: widget.activeUser.login,
          datestamp: DateTime.now(),
          achievementlvl: 5);

      await FloorsDatabase.instance.createAchievement(achievement);
    }

    await FloorsDatabase.instance.update(user);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainPage(activeUser: user),
    ));

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: AppLargeText(text: "Synchronizace v pořádku"),
          content: AppText(text:"Statistiky byly úspěšně synchronizovány"),
          actions: [
            ElevatedButton(
              child:
              AppText(text: "OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
    );
  }
}