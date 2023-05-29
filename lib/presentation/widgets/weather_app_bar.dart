import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeatherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      title: CupertinoSearchTextField(
        onChanged: (value) {
          // Handle search text changes here
        },
        onSubmitted: (value) {
          // Handle search text submission here
        },
        placeholder: 'Search',
        placeholderStyle: const TextStyle(
          color: CupertinoColors.placeholderText,
          fontSize: 16.0,
        ),
        prefixIcon: const Icon(CupertinoIcons.search),
        borderRadius: BorderRadius.circular(8.0),
        backgroundColor: CupertinoColors.lightBackgroundGray,
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_horiz_rounded),
          position: PopupMenuPosition.under,
          elevation: 14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onSelected: (item) {
            switch (item) {
              case 1:
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const WeatherAppBar();
                }));
                break;
              case 2:
                debugPrint("Add to favourite");
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your Favourite'),
                    Icon(Icons.list_rounded),
                  ],
                )),
            const PopupMenuItem(
                value: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Favourite'),
                    Icon(Icons.favorite_border_rounded),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
