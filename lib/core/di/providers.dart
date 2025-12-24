import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/datasources/auth_remote_ds.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../network/api_client.dart';

final dioProvider = Provider((ref) => Dio());

final apiClientProvider =
Provider((ref) => ApiClient(ref.read(dioProvider)));

final authRemoteDSProvider =
Provider((ref) => AuthRemoteDS(ref.read(apiClientProvider)));

final authRepoProvider =
Provider<AuthRepository>(
        (ref) => AuthRepoImpl(ref.read(authRemoteDSProvider)));

final loginUseCaseProvider =
Provider((ref) => LoginUseCase(ref.read(authRepoProvider)));
