import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

final loginProvider =
StateNotifierProvider<LoginNotifier, AsyncValue<User>>(
      (ref) => LoginNotifier(ref.read(loginUseCaseProvider)),
);

class LoginNotifier extends StateNotifier<AsyncValue<User>> {
  final LoginUseCase useCase;

  LoginNotifier(this.useCase) : super(const AsyncValue.loading());

  Future<void> login(String phone) async {
    state = const AsyncValue.loading();
    try {
      final user = await useCase(phone);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
