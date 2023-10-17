import 'package:beauty_beyond_app/screens/auth.dart';
import 'package:beauty_beyond_app/screens/auth_page.dart';
import 'package:beauty_beyond_app/screens/booking_page.dart';
import 'package:beauty_beyond_app/screens/doctor_details.dart';
import 'package:beauty_beyond_app/screens/success_booked.dart';
import 'package:beauty_beyond_app/utils/authentication.dart';
import 'package:beauty_beyond_app/utils/config.dart';
import 'package:beauty_beyond_app/utils/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => AthenticationData()),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Beauty & Beyond App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey.shade700,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
          )
        ),
        initialRoute: '/',
        routes: {
          // this is initial rout of the app
          // which is auth page (login and sign up)
          '/':(context) => const Auth(),
          
          'auth' :(context) => const AuthPage(),
          'main': (context) => const MainLayout(),
          // 'doc_details': (context) => const DoctorDetails(),
          // 'booking_page': (context) => const BookingPage(),
          'success_booking': (context) => const AppointmentBooked(),
        },
        //home: const MyHomePage(),
      ),
    );
  }
}

//
