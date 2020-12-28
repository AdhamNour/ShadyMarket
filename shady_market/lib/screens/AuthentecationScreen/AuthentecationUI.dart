import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './AuthentactionLogic.dart';

import './AuthentecationBackGroundAnimated.dart';
import '../../widget/AnimatedButton.dart';
import '../../widget/AnimatedTextFormField.dart';
import '../../widget/SocialMediaAuth.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isSignUP = false;
  final _formKey = GlobalKey<FormState>();
  FocusNode _fullNameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  TextEditingController _fullNameTextEditingController,
      _emailTextEditingController,
      _passwordTextEditingController,
      _confirmPasswordTextEditingController;
  @override
  void initState() {
    super.initState();
    _fullNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _fullNameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _fullNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AuthScreenBackgroundAnimation(
        height: size.height,
        width: size.width,
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Text(
                'Sign ${isSignUP ? "Up" : "In"}',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      child: isSignUP
                          ? AnimatedTextFormField(
                              name: "Full Name",
                              postFixIcon: Icons.account_circle,
                              activeColor: Colors.cyan[100],
                              myFocusNode: _fullNameFocusNode,
                              nextFieldFocusNode: _emailFocusNode,
                              textEditingController:
                                  _fullNameTextEditingController,
                            )
                          : Container(),
                      height: isSignUP ? 80 : 0,
                    ),
                    AnimatedTextFormField(
                      name: "E-Mail",
                      postFixIcon: Icons.mail,
                      activeColor: Colors.cyan[100],
                      myFocusNode: _emailFocusNode,
                      nextFieldFocusNode: _passwordFocusNode,
                      textEditingController: _emailTextEditingController,
                    ),
                    AnimatedTextFormField(
                      name: "Password",
                      postFixIcon: Icons.vpn_key,
                      activeColor: Colors.cyan[100],
                      myFocusNode: _passwordFocusNode,
                      nextFieldFocusNode:
                          isSignUP ? _confirmPasswordFocusNode : null,
                      textEditingController: _passwordTextEditingController,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      child: isSignUP
                          ? AnimatedTextFormField(
                              name: "Confirm Password",
                              postFixIcon: Icons.vpn_key,
                              activeColor: Colors.cyan[100],
                              myFocusNode: _confirmPasswordFocusNode,
                              textEditingController:
                                  _confirmPasswordTextEditingController,
                            )
                          : Container(),
                      height: isSignUP ? 80 : 0,
                    ),
                    AnimatedButton(
                      child: Text("Sign ${isSignUP ? "Up" : "In"}"),
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 300))
                            .then((value) {
                          if (isSignUP) {
                            AuthentcationLogicUtils.SignUP(
                                email: _emailTextEditingController.text,
                                password: _passwordTextEditingController.text,
                                full_name: _fullNameTextEditingController.text);
                          } else {
                            AuthentcationLogicUtils.SignIn(
                                email: _emailTextEditingController.text,
                                password: _passwordTextEditingController.text,
                                ctx: context);
                          }
                        });
                      },
                      colors: isSignUP
                          ? [Colors.cyan, Colors.indigo]
                          : [Colors.green, Colors.red],
                    )
                  ],
                ),
              ),
              SocialMediaAuth(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.white),
                        children: [
                      TextSpan(
                          text: 'SignUP',
                          style: TextStyle(color: Colors.amber[300]),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isSignUP = !isSignUP;
                              });
                            })
                    ])),
              )
            ]),
          ),
        ),
        colors: [Colors.indigo, Colors.indigo[800]],
        secondaryColors: [Colors.green[400], Colors.green[800]],
        counterClockwise: isSignUP,
      ),
    );
  }
}
