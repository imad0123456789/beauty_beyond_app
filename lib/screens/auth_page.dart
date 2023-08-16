import 'package:beauty_beyond_app/components/login_form.dart';
import 'package:beauty_beyond_app/components/sign_up_form.dart';
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
  bool isSignIn  = true;
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
              isSignIn? Row(
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
                      ) ,
                      //Config.spaceSmall,
                      Text(
                        isSignIn
                        ? AppText.enText['signIn_text']!
                        : AppText.enText['register_text']!
                        ,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 100,),
                  const SizedBox(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/logo.png'),
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ) : Row(
                children: [
                  Text('Sign Up Page'),
                ],
              ),
              //Config.spaceSmall,
              isSignIn ? LoginForm() : SignUpForm(),
              Config.spaceSmall,
              isSignIn ? Center(
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
              ) : Container(

              ),
              const Spacer(),

              Column(
                  children: <Widget> [
                    /*
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      SocialButton(social: 'google'),
                      SocialButton(social: 'facebook'),

                    ],
                  ),

                     */

                  Config.spaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Text(
                        isSignIn ?
                        AppText.enText['signUp_text']!
                        : AppText.enText['registered_text']!,
                        style:  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            isSignIn = !isSignIn;
                          });
                        },
                        child:  Text(
                          isSignIn ? 'Sign Up' : 'Sign In',
                          style:  const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Config.primaryColor,
                          ),),
                      )
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