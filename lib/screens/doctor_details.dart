
import 'package:beauty_beyond_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beauty_beyond_app/components/custom_appbar.dart';

import '../components/button.dart';


class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  // for favarite button
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        appTitle: 'Doctor Details',
        icon:  const FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFav = !isFav;
                });
              },
              icon: FaIcon(isFav ? Icons.favorite_rounded
                  : Icons.favorite_outline,
                  color: Colors.red,
              ))
        ],
      ),
      body:  SafeArea(
        child: Column(
          children: <Widget>[
            AboutDoctor(
            ),
            DetailBody(),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(20),
            child: Button(
              width: double.infinity,
              title: 'Book Appointment',
              onPressed: () {
                //navigate to booking page
                Navigator.of(context).pushNamed('booking_page');
                /*
                Navigator.of(context).pushNamed('booking_page',
                arguments: {"doctor_id": doctor['doc_id']});

                 */
              },
              disable: false,
            ),
            ),

          ],
        ),
      ),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children:  <Widget>[
          const CircleAvatar(
            radius: 65,
            backgroundImage: AssetImage('assets/doctor01.jpg'),
            backgroundColor: Colors.white,
          ),
          Config.spaceSMedium,
          const Text('Dr. Kassem Mannaki',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Syddansk Universitet,  Holstebro sygehus, speciallægepraksis i Holstebro.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'BEAUTY & BEYOUND',
              style: TextStyle(
                color: Config.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )
    );
  }
}


// Details

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:  <Widget>[
          Config.spaceSmall,
            const DoctorInfo(),
          Config.spaceSMedium,
           const Text(
             'About Doctor',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
           ),
          //Config.spaceSmall,
          const Text(
            'Dr. Kassem Mannaki, Uddannet læge i 2015, Klinisk basisuddannelse på Holstebro sygehus i 2015-2016, Uddannet speciallæge i almen medicin i 2022'
              'Arbejder aktuelt som vikar i flere speciallægepraksis i Holstebro.',
          style: TextStyle(
            fontWeight: FontWeight.w500,
              height: 1.5,
          ),
            softWrap: true,
            textAlign: TextAlign.justify,
          )
          //
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children:   <Widget>[
        InfoCard(
          label: 'Patient',
          value: '110',
        ),
         SizedBox(
           width: 15,
         ),
        InfoCard(
          label: 'Experiences',
          value: '5 years',
        ),
         SizedBox
           (width: 15,
         ),
        InfoCard(
          label: 'Rating',
          value: '4.5',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label, required this.value}) : super(key: key);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Config.primaryColor,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 15,
          ),
          child: Column(
            children:  <Widget>[
              Text(
                label,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                ),),
              const SizedBox(
                height: 10,),
              Text(
                value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                ),),
            ],
          ),
        ));
  }
}



