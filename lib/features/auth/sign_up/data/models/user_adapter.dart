import 'package:hive/hive.dart';
import 'user_model.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      username: reader.readString(),
      firstName: reader.readString(),
      lastName: reader.readString(),
      email: reader.readString(),
      phone: reader.readString(),
      role: reader.readString(),
      isVerified: reader.readBool(),
      id: reader.readString(),
      createdAt: DateTime.parse(reader.readString()),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.username);
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.email);
    writer.writeString(obj.phone);
    writer.writeString(obj.role);
    writer.writeBool(obj.isVerified);
    writer.writeString(obj.id);
    writer.writeString(obj.createdAt.toIso8601String());
  }
}
