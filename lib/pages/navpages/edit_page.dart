import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_large_text.dart';
import 'package:ebrana_schody/widgets/input_text.dart';
import 'package:ebrana_schody/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left:20, right: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            //statistiky
            Center(child: AppLargeText(text: "Změna hesla:", size: 20, color: AppColors.textColor1)),
            SizedBox(height: 20),
            InputText(hintText: "Zadejte své staré heslo", labelText: "Staré heslo",secureText: true),
            SizedBox(height: 20),
            InputText(hintText: "Zadejte nové heslo", labelText: "Nové heslo",secureText: true),
            SizedBox(height: 20),
            Center(child: ResponsiveButton(textButton: "Změnit",width: 200)),
            SizedBox(height: 40),
            Center(child: AppLargeText(text: "Editace:", size: 20, color: AppColors.textColor1)),
            SizedBox(height: 20),
            Center(child: ResponsiveButton(textButton: "Synchronizovat",width: 200)),
            SizedBox(height: 20),
            Center(child: ResponsiveButton(textButton: "Resetovat statistiky",width: 220)),
            SizedBox(height: 20),
          ]
      ),
    );
  }
}