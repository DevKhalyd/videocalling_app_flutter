import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/utils.dart';

import '../../getX/home_controller.dart';
import 'home_bottom_item.dart';

/// The button navigation of the home
class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        assignId: true,
        id: HomeController.idUnique,
        builder: (c) {
          return Container(
              height: kToolbarHeight + 40,
              width: double.infinity,
              color: Utils.textFormFIeldColor,
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
                          Expanded(
                            child: HomeBottomItem(
                              iconSelected: Icons.message,
                              iconNotSelected: Icons.message_outlined,
                              label: c.tabs[0],
                              onPressed: c.onTabMessageSelected,
                              isSelected: c.isTabMessageSelected,
                            ),
                          ),
                          Expanded(
                            child: HomeBottomItem(
                              iconSelected: Icons.call,
                              iconNotSelected: Icons.call_outlined,
                              label: c.tabs[1],
                              onPressed: c.onTabCallSelected,
                              isSelected: c.isTabCallSelected,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Videocall button
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
                                color: Utils.acentColor,
                                shape: BoxShape.circle,
                              ),
                              // ALlow to see the splash in this widget
                              child: Material(
                                color: Colors.transparent,
                                shape: CircleBorder(),
                                clipBehavior: Clip.hardEdge,
                                child: IconButton(
                                  onPressed: c.onVideocall,
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
        });
  }
}
