import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      width: 48,
      height: 48,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
          Image.asset(
            "assets/images/cloudy.png",
            width: 25,
            height: 25,
          )
        ],
      ),
    );
  }
}
