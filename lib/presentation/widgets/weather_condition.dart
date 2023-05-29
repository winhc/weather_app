import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherCondition extends StatelessWidget {
  WeatherCondition(
      {required this.icon,
      required this.temperature,
      required this.label,
      super.key});

  late String icon, temperature, label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 2.0,
            child: CachedNetworkImage(
              imageUrl: "http:$icon",
              width: 64.0,
              height: 64.0,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 45,
            width: temperature.length > 2 ? 85 : 65,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '°c',
                    style: TextStyle(
                        fontSize: 20, color: Colors.black.withOpacity(0.8)),
                  ),
                ),
                Positioned(
                  right: 15,
                  child: Text(
                    temperature,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
