import 'package:flutter/material.dart';

class WeatherToast {
  void showToast(BuildContext context,
      {required IconData icon, required String message}) {
    showWeatherToast(context,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ));
  }

  void showWeatherToast(BuildContext context, {required Widget child}) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          bottom: 16.0,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
