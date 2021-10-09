import 'package:flutter/material.dart';

import 'home_bottom_item.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // 10 - 40
        height: kToolbarHeight + 40,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: kToolbarHeight + 10,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeBottomItem(
                      iconSelected: Icons.message,
                      iconNotSelected: Icons.message_outlined,
                      label: 'Messages',
                      isSelected: true,
                      onPressed: () {
                        print('Pressed');
                      },
                    ),
                    SizedBox(),
                    HomeBottomItem(
                      iconSelected: Icons.message,
                      iconNotSelected: Icons.message_outlined,
                      label: 'Messages',
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        // ALlow to see the splash in this widget
                        child: Material(
                          color: Colors.transparent,
                          shape: CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          child: IconButton(
                            onPressed: () {
                              print('Pressed');
                            },
                            icon: Icon(
                              Icons.videocam_sharp,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  )),
            ),
          ],
        ));
  }
}
