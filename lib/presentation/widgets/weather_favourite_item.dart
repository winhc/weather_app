import 'package:flutter/material.dart';

class WeatherFavouriteItem extends StatelessWidget {
  const WeatherFavouriteItem(
      {required this.gradientColors,
      super.key,
      required this.cityName,
      required this.temperature,
      required this.date,
      required this.condition,
      required this.higestTemperature,
      required this.lowestTemperature,
      required this.onTap});

  final List<Color> gradientColors;
  final Function() onTap;
  final String cityName,
      date,
      condition,
      temperature,
      higestTemperature,
      lowestTemperature;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        padding: const EdgeInsets.all(8),
        height: 110,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      cityName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(date,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
                Text(condition,
                    style: const TextStyle(color: Colors.white, fontSize: 12))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 45,
                  width: 90,
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '°c',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        child: Text(
                          temperature,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Text("$higestTemperature°c/$lowestTemperature°c",
                    style: const TextStyle(color: Colors.white))
              ],
            )
          ],
        ),
      ),
    );
  }
}
