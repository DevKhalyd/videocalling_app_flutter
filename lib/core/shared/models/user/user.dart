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
  static const tokenFCMField = 'tokenFCM';

  /// In this model this field does not exists. But in the database it does.
  ///
  /// Basically store the username as a List of strings.
  ///
  /// This allow to search usernames letter by letter.
  static const userNameQueryField = 'username_query';

  User({
    required this.username,
    required this.fullname,
    required this.email,
    this.isOnline = true,
    this.tokenFCM = '',
    this.imageUrl,
    this.password,
  });

  /// Use this constructor to test a function that needs a User object
  User.test({
    this.username = 'testUserName',
    this.fullname = 'Test One',
    this.email = 't1@gmail.com',
    this.tokenFCM = 'TOKEN FCM TEST',
    this.isOnline = true,
    this.password = 'Super Secret Password',
    this.imageUrl,
  });

  /// The id for this document in firestore. Created automatically by Firestore.
  @JsonKey(ignore: true)
  String id = '';

  final String username, fullname, email;

  /// Can be null when it's necessary.
  final String? imageUrl;

  /// The token of this user. Can be null because the IOS user can deny the notification permission.
  final String tokenFCM;

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
    String? tokenFCM,
    bool? isOnline,
  }) {
    return User(
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      isOnline: isOnline ?? this.isOnline,
      imageUrl: imageUrl ?? this.imageUrl,
      password: this.password,
      tokenFCM: tokenFCM ?? this.tokenFCM,
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
