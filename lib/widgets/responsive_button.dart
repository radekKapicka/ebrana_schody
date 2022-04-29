import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  final String textButton;

  ResponsiveButton({Key? key, required this.textButton, this.width, this.isResponsive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.textColor1,
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(text: textButton,color: AppColors.white),
          Padding(padding:EdgeInsets.fromLTRB(10, 0, 0, 0),
            child:Image.asset("img/arrow-2.png",height: 20)
          ),
        ],
      ),
    );
  }
}
