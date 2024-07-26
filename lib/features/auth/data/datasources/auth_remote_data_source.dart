import 'package:blog_hub/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource{

  Session? get currentSession;
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel?> currentUserData();
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource{
  final SupabaseClient supabaseClient;
  const AuthRemoteDataSourceImplementation(this.supabaseClient);

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signIn({required String email, required String password})  async{
    try{
      final AuthResponse response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password
      );
      if (response.user == null) {
        throw Exception('Sign-up failed: User is null. ');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> signUp({required String name, required String email, required String password}) async {
    try{
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name
        }
      );
      if (response.user == null) {
        throw Exception('Sign-up failed: User is null. ');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel?> currentUserData() async {    // this function returns all the data of current user from 'profiles' table
    try{
      if(currentSession!=null) {
        final userData = await supabaseClient.from('profiles').select().eq('id', currentSession!.user.id);    // From profiles table select all the columns where id=currentSession.id
        return UserModel.fromJson(userData.first);  // the above query will return a list. Reason is if we hadn't use .eq in query it will return list
      }
      return null;
    } catch(e){
      throw Exception(e.toString());
    }
  }



}