import 'package:flutter/material.dart';

class WeatherTitle extends StatelessWidget {
  WeatherTitle(
      {required this.city,
      required this.country,
      required this.date,
      super.key});

  late String city, country, date;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Text(
          '$city,',
          style: const TextStyle(fontSize: 30),
        ),
        Text(
          country,
          style: const TextStyle(fontSize: 20),
        ),
        Wrap(
          children: [
            Text(
              date,
              style: const TextStyle(color: Colors.black87),
            )
          ],
        )
      ],
    );
  }
}
