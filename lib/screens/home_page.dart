
import 'package:beauty_beyond_app/components/appointment_card.dart';
import 'package:beauty_beyond_app/components/doctor_card.dart';
import 'package:beauty_beyond_app/components/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/config.dart';


late User signedInUser;

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);





  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  final _authE = FirebaseAuth.instance.currentUser?.email;

  List<Map<String, dynamic>> medCat= [
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"Preliminary",
    },
    {
      "icon":FontAwesomeIcons.syringe,
      "category":"Botox",
    },
    {
      "icon":FontAwesomeIcons.syringe,
      "category":"Filler",
    },
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"Another",
    },
  ];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (error) {
      print(error);
    }
  }

  Widget imageProfile() {
    return Center(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              initialData: null,
              future: getProfileImage(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return Text('Image not found');
                }
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(snapshot.data!),
                );
              },
            ),
          ],
        ));
  }


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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget> [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      Text(
                      '$_authE!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    /*
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile01.png'),
                      ),
                    )

                     */
                    SizedBox(width: 25,),
                    imageProfile(),
                  ],
                ),

                // sign out button
                TextButton(
                  onPressed: () {
                    // Perform sign out operation here
                    Navigator.of(context).pop(true);
                    _auth.signOut();
                    Navigator.of(context).pushNamed('auth');
                  },
                  child: const Text('Sign Out',
                  style: TextStyle(
                    fontSize: 18,

                  ),),
                ),

                Config.spaceSMedium,
                //category listing
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SizedBox(
                  height: Config.heightSize * 0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(medCat.length, (index){
                      return Card(
                        margin: const EdgeInsets.only(right: 20),
                        color: Config.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10) ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:<Widget> [
                              FaIcon(
                                  medCat[index]['icon'],
                                  color: Colors.white
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                medCat[index]['category'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                 'Appointment Today',
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                //display appointment card
                const AppointmentCard(),
                Config.spaceSmall,
                const Text(
                  'Top Doctors',
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //list of top doctors
                Config.spaceSmall,
                Column(
                  children: List.generate(2, (index){
                    return  const DoctorCard(
                      route: 'doc_details',
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  // get profile Image
  Future<String> getProfileImage() async {
    try {
      return await FirebaseStorage.instance.ref().child(
          _auth.currentUser!.uid).getDownloadURL();
    }
    catch (error) {
      return await FirebaseStorage.instance.ref().child('unknown.png').getDownloadURL();
    }
  }
}




