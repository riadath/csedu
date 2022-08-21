import 'package:csedu/Constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPress;
  final Color textColor;
  const RoundedButton({
    Key? key,
    required this.buttonText,
    required this.onPress,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: screenSize.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: Container(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(gPrimaryColor),
            ),
            onPressed: onPress,
            child: Text(buttonText, style: TextStyle(color: textColor)),
          ),
        ),
      ),
    );
  }
}
