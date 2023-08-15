import 'package:beauty_beyond_app/components/login_form.dart';
import 'package:beauty_beyond_app/components/social_botton.dart';
import 'package:beauty_beyond_app/utils/text.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        AppText.enText['welcome_text']!,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Config.primaryColor,
                        ),
                      ),
                      Config.spaceSmall,
                      Text(
                        AppText.enText['signIn_text']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 80,),
                  const SizedBox(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/logo.png'),
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
              Config.spaceSmall,
              const LoginForm(),
              Config.spaceSmall,
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppText.enText['forgot-password']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                  children: <Widget> [
                    Center(
                    child: Text(
                      AppText.enText['social-login']!,
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Config.spaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget> [
                      SocialButton(social: 'google'),
                      SocialButton(social: 'facebook'),

                    ],
                  ),

                  Config.spaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Text(
                        AppText.enText['signUp_text']!,
                        style:  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const Text(
                        'Sign Up',
                        style:  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),)
                    ],
                  ),
                ]
              ),
            ],
          ),
        ),
      )
    );
  }
}
