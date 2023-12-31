import 'dart:typed_data';

import 'package:beauty_beyond_app/components/button.dart';
import 'package:beauty_beyond_app/models/user_model.dart';
import 'package:beauty_beyond_app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

//final storage = FirebaseStorage.instance;
final _firestore = FirebaseFirestore.instance; // cloud

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final ImagePicker _picker = ImagePicker();
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _familyController = TextEditingController();
  final _mobileController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  bool spinner = false;
  Uint8List? imageBytes;

  Future signUp() async {
    try {
      // create user
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim());
      if (newUser.user == null) {
        return;
      }

      // add user details
      _addUserDetails();

      // add profile image for new user
      if (imageBytes != null) {
        Reference ref = FirebaseStorage.instance.ref().child(newUser.user!.uid);
        try {
          await ref.putData(imageBytes!);
          final value = ref.getDownloadURL();
          print(value);
        } catch (error) {
          print(error);
        }
      }
      Navigator.of(context).pushNamed('main');
      setState(() {
        spinner = false;
      });
    } catch (error) {
      print(error);
      spinner = false;
    }
  }

  Future _addUserDetails() async {
    final userModel = UserModel(
        name: _nameController.text.trim(),
        family: _familyController.text.trim(),
        email: _emailController.text.trim(),
        mobileNumber: _mobileController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        type: UserType.user.name,
        details: 'New User');

    await FirebaseFirestore.instance
        .collection('users')
        .add(userModel.toDocument())
        .then((value) {
      print('Added User Details successfully');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              imageProfile(),
              Config.spaceSmall,
              //user name
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                cursorColor: Config.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  prefixIconColor: Config.primaryColor,
                ),
              ),
              Config.spaceSmall,
              TextFormField(
                controller: _familyController,
                keyboardType: TextInputType.text,
                cursorColor: Config.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'UserFamily',
                  labelText: 'UserFamily',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  prefixIconColor: Config.primaryColor,
                ),
              ),
              Config.spaceSmall,

              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.text,
                cursorColor: Config.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Mobile',
                  labelText: 'Mobile',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  prefixIconColor: Config.primaryColor,
                ),
              ),
              Config.spaceSmall,
              //age
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.text,
                cursorColor: Config.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Age',
                  labelText: 'Age',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  prefixIconColor: Config.primaryColor,
                ),
              ),
              Config.spaceSmall,
              //email
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
                  onPressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    signUp();
                    // Navigator.of(context).pushNamed('main');
                  },
                  disable: false)
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
        child: Stack(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Config.primaryColor,
            child: imageBytes == null
                ? Image.asset('assets/unknown.png')
                : Image.memory(imageBytes!),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: Colors.white),
                color: Config.primaryColor,
              ),
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                color: Colors.white,
                onPressed: () {
                  pickUploadImage();
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
              ),
            )),
      ],
    ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 50,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.camera,
                  color: Colors.green,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
              ),
              Text(
                'Camera',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.image,
                  color: Colors.red,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
              Text(
                'Gallery',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    imageBytes = await pickedFile?.readAsBytes();
    setState(() {});
  }

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );
    imageBytes = await image?.readAsBytes();
  }
}
