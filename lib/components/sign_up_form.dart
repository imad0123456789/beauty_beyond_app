import 'package:beauty_beyond_app/components/button.dart';
import 'package:beauty_beyond_app/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass= true;
  bool spinner = false;

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                hintText: 'Username',
                labelText: 'Username',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.person_2_outlined),
                prefixIconColor: Config.primaryColor,
              ),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                hintText: 'Email Address',
                labelText: 'Email',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Config.primaryColor,
              ),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Config.primaryColor,
              obscureText: obsecurePass,
              decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.lock_outline),
                  prefixIconColor: Config.primaryColor,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecurePass = !obsecurePass;
                        });
                      },
                      icon: obsecurePass
                          ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black38,
                      )
                          : const Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ))),
            ),
            Config.spaceSmall,

            Button(
                width: double.infinity,
                title: 'Sign up',
                onPressed: ()  async {
                  setState(() {
                    spinner = true ;
                  });
                  signUp();
                  Navigator.of(context).pushNamed('main');
                },
                disable: false
            )


          ],
        ),
      ),
    );
  }
}