import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? username;

  EditProfileRequest({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}
