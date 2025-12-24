import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDS remoteDS;

  AuthRepoImpl(this.remoteDS);

  @override
  Future<User> login(String phone) async {
    return await remoteDS.login(phone);
  }
}
