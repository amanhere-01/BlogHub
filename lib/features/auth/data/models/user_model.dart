
import '../../../../core/common/entities/user.dart';


class UserModel extends User {       // don't import supabase User
  UserModel({
    required super.id,
    required super.name,
    required super.email
  });

  factory UserModel.fromJson(Map<String,dynamic> map){    // this will convert Json to UserModel
    return UserModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? ''
    );
  }
}
