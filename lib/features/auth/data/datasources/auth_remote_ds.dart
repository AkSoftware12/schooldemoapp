import '../../../../core/network/api_client.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class AuthRemoteDS {
  final ApiClient client;

  AuthRemoteDS(this.client);

  Future<User> login(String phone) async {
    final res = await client.post('/login', data: {'phone': phone});
    return UserModel.fromJson(res.data);
  }
}
