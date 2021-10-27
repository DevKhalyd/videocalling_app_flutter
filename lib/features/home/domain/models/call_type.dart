import 'package:json_annotation/json_annotation.dart';

part 'call_type.g.dart';

/// Handle the call type.
///
/// How to know what type corresponds to each user?
///
/// If the ID of the caller is equal to this current user so it's outcoming otherwise incoming.
@JsonSerializable()
class CallType {
  static const outcoming = 0;
  static const incoming = 1;

  const CallType({required this.type});

  const CallType.outcomingType({this.type = outcoming});

  final int type;

  factory CallType.fromJson(Map<String, dynamic> json) =>
      _$CallTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CallTypeToJson(this);
}
