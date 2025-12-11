sealed class EditProfileIntent {}

class LoadUserData extends EditProfileIntent {}

class UsernameChanged extends EditProfileIntent {
  final String username;
  UsernameChanged(this.username);
}

class FirstNameChanged extends EditProfileIntent {
  final String firstName;
  FirstNameChanged(this.firstName);
}

class LastNameChanged extends EditProfileIntent {
  final String lastName;
  LastNameChanged(this.lastName);
}

class EmailChanged extends EditProfileIntent {
  final String email;
  EmailChanged(this.email);
}

class PhoneChanged extends EditProfileIntent {
  final String phone;
  PhoneChanged(this.phone);
}

class ChangePasswordRequested extends EditProfileIntent {}

class ProfileImagePicked extends EditProfileIntent {
  final String imagePath; 
  ProfileImagePicked(this.imagePath);
}

class UpdateProfilePressed extends EditProfileIntent {}
