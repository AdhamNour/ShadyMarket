import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_icons.dart';

class SocialMediaAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('OR'),
        Text('Sign in With'),
        Row(
          children: [
            IconButton(icon: Icon(SocialMediaIcons.facebook), onPressed: null),
            IconButton(
              icon: Icon(SocialMediaIcons.google),
              onPressed: null,
            ),
            IconButton(icon: Icon(Icons.phone), onPressed: null),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}
