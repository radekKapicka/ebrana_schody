import 'package:ebrana_schody/misc/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {

  final String hintText;
  final String labelText;
  final bool secureText;

  const InputText({Key? key,required this.hintText, required this.labelText,required this.secureText}) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                fontSize: 18,
                color: AppColors.textColor2,
              ),
              border: OutlineInputBorder(),
              ),
            obscureText: widget.secureText,
          )
        ],
      ),
    );
  }
}
