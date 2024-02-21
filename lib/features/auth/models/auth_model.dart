import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class User with _$User {
  // Define the fields and their types
  const factory User({
    required String name,
    required int age,
    @JsonKey(name: 'is_admin') // Specify the custom name for the field
    required bool isAdmin,
    @Default([]) List<String> hobbies,
  }) = _User;

  // Define the fromJson and toJson methods
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Map<String, dynamic> toJson() => _$UserToJson(this);
}
