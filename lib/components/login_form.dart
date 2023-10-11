import 'package:beauty_beyond_app/components/button.dart';
import 'package:beauty_beyond_app/models/user_model.dart';
import 'package:beauty_beyond_app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils/authentication.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  bool spinner = false;

  Future signInAndGetUserData() async {
    print("LOGGINNNNN");
    final user = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim());
    print("GET DATAAAA");

    // get user data from firestore
    QueryDocumentSnapshot<Map<String, dynamic>> userDataDocument =
        (await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: _emailController.text.trim())
                .get())
            .docs
            .single;

    final userModel = UserModel.fromDocument(userDataDocument);

    // set data
    AthenticationData.userData = userModel;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
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
                title: 'Sign in',
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    await signInAndGetUserData();

                    Navigator.of(context).pushNamed('main');
                  } catch (error) {
                    print(error);
                    spinner = false;
                  }
                },
                disable: false)
          ],
        ),
      ),
    );
  }
}
