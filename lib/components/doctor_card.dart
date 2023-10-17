import 'package:beauty_beyond_app/models/doctor_model.dart';
import 'package:beauty_beyond_app/utils/config.dart';
import 'package:flutter/material.dart';

import '../screens/doctor_details.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCard({Key? key, required this.route, required this.doctor})
      : super(key: key);

  final String route;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.33,
                child: Image.network(
                  doctor.image,
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      doctor.category.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Text("${doctor.rating}"),
                        const Spacer(
                          flex: 1,
                        ),
                        const Text('Reviews'),
                        const Spacer(
                          flex: 1,
                        ),
                        Text('(${doctor.reviews})'),
                        const Spacer(
                          flex: 7,
                        ),
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
        onTap: () {
          // Navigator.of(context).pushNamed(route, arguments: doctor);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DoctorDetails(
                    doctor: doctor,
                  )));
        },
      ),
    );
  }
}
