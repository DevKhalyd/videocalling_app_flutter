import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/shared/models/user/user.dart';
import '../../../../../core/widgets/mini_widgets.dart';
import '../../../../../core/widgets/shared/circle_profile_image.dart';
import '../../getX/home_search_controller.dart';
import 'tile_home_searcher.dart';

class BodyHomeSearcher extends StatelessWidget {
  const BodyHomeSearcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSearchController>(
      builder: (c) {
        final usersStream = c.users;

        if (usersStream == null)
          return IconDescription(
              Icons.keyboard, 'Enter a username to start to search');

        return StreamBuilderCustom<List<User>>(
            stream: usersStream,
            onData: (context, AsyncSnapshot<List<User>> snapshot) {
              final data = snapshot.data;

              if (data?.isEmpty ?? true)
                return IconDescription(
                    Icons.search, 'Try with another username');
              final users = data!;
              return Expanded(
                  child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final item = users[index];
                        return TileHomeSearcher(
                          username: item.username,
                          fullname: item.fullname,
                          isOnline: item.isOnline,
                          profileImage: CircleProfileImage(
                              firstLetter: item.fullname[0],
                              url: item.imageUrl),
                        );
                      }));
            });
      },
    );
  }
}
