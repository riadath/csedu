import 'package:csedu/constants.dart';
import 'package:flutter/material.dart';

import 'rounded_input_field.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const RoundedPasswordField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _ifObscureText = true;

  void _toggleShowPassword() {
    setState(() {
      _ifObscureText = !_ifObscureText;
      // print(_ifObscureText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        obscureText: _ifObscureText,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.lock,
            color: gPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: (_ifObscureText)
                ? const Icon(Icons.remove_red_eye, color: gPrimaryColor)
                : const Icon(
                    Icons.remove_red_eye_outlined,
                    color: gPrimaryColor,
                  ),
            onPressed: _toggleShowPassword,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
