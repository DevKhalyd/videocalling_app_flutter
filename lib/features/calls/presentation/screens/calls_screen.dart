import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../domain/models/history_call.dart';
import '../getX/calls_controller.dart.dart';
import '../widgets/history_item_call.dart';

class CallsScreen extends StatelessWidget {
  /// Show the history of the calls for this user
  const CallsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.textFormFIeldColor,
      body: GetBuilder<CallsController>(
        init: CallsController(),
        builder: (c) {
          return StreamBuilderCustom<List<HistoryCall>>(
            stream: c.historyCalls,
            onData: (_, snapshot) {
              final data = snapshot.data;

              if (data?.isEmpty ?? true)
                return IconDescription(
                  Icons.call,
                  'No calls yet',
                );

              final list = data!;

              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    final item = list[index];
                    return HistoryItemCall(history: item);
                  });
            },
          );
        },
      ),
    );
  }
}
