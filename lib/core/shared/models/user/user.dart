import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class User {
  // Fields to find in the database.
  // NOTE: Check if I use @JsonKey(ignore: true) in those fields
  static const emailField = 'email';
  static const imageUrlField = 'imageUrl';
  static const isOnlineField = 'isOnline';

  User({
    required this.username,
    required this.fullname,
    required this.email,
    this.isOnline = true,
    this.imageUrl,
    this.password,
  });

  @JsonKey(ignore: true)
  String id = '';

  final String username, fullname, email;

  /// Can be null when it's necessary.
  final String? imageUrl;

  final bool isOnline;

  /// It's no final because this is changed to null when I fetch the data
  String? password;

  /// Remove the encryted password from this model
  clean() => password = null;

  /// Useful when the id comes from the database and it's necessary to stored
  setId(String value) => id = value;

  /// Return `true` if this User represents in a good way the data from Firebase
  bool validate() => password == null && id.isNotEmpty;

  User copyWith({
    String? username,
    String? fullname,
    String? email,
    String? imageUrl,
    bool? isOnline,
  }) {
    return User(
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      isOnline: isOnline ?? this.isOnline,
      imageUrl: imageUrl ?? this.imageUrl,
      password: this.password,
    );
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
