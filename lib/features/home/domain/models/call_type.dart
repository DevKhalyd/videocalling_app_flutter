import 'package:json_annotation/json_annotation.dart';

part 'call_type.g.dart';

/// Handle the call type
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
