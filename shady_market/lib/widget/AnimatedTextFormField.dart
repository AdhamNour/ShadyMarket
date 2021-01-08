import 'package:flutter/material.dart';

class AnimatedTextFormField extends StatelessWidget {
  final String hintText, name;
  final String Function(String newValue) onSaved, validator;
  final IconData postFixIcon;
  final TextEditingController textEditingController;
  final FocusNode myFocusNode, nextFieldFocusNode;
  final Color activeColor;

  AnimatedTextFormField({
    this.hintText,
    this.name,
    this.onSaved,
    this.validator,
    this.postFixIcon,
    this.textEditingController,
    this.myFocusNode,
    this.nextFieldFocusNode,
    @required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: ThemeData(primaryColor: activeColor),
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.indigo[500],
              ),
            ),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: name,
            prefixIcon: Icon(postFixIcon),
            labelStyle: TextStyle(fontSize: 25),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          cursorColor: activeColor,
          style: TextStyle(color: activeColor),
          onFieldSubmitted: (value) {
            print("Hello form the $name");
            FocusScope.of(context).requestFocus(nextFieldFocusNode);
          },
          focusNode: myFocusNode,
          onSaved: onSaved,
          validator: validator,
          obscureText: name.toLowerCase().contains("password"),
          controller: textEditingController,
        ),
      ),
    );
  }
}
