import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../../home/domain/models/call_type.dart';
import '../../domain/models/history_call.dart';
import '../getX/calls_controller.dart.dart';

/// The item to show in the history call
class HistoryItemCall extends StatelessWidget {
  const HistoryItemCall({Key? key, required this.history}) : super(key: key);

  final HistoryCall history;

  @override
  Widget build(BuildContext context) {
    final isIncoming = history.callType.type == CallType.incoming;
    return GetBuilder<CallsController>(
      builder: (c) {
        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage(history.imgUrl ?? Utils.defaultProfileImg),
          ),
          title: TextCustom(
            history.fullname,
            fontWeight: FontWeight.bold,
          ),
          subtitle: Row(
            children: [
              Icon(
                isIncoming ? Icons.call_received : Icons.call_made,
                color: isIncoming ? Colors.green : Colors.red,
              ),
              Space(
                0.001,
                isHorizontal: true,
              ),
              TextCustom(history.date),
            ],
          ),
          trailing: IconButton(
            onPressed: () => c.onChat(history),
            icon: Icon(Icons.message),
          ),
        );
      },
    );
  }
}
