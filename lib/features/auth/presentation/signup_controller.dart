import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../infrastructure/auth_repository.dart';

part 'signup_controller.g.dart';

@riverpod
class SignupController extends _$SignupController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signUp(
            email: email,
            password: password,
            fullName: fullName,
            phone: phone,
          ),
    );
  }
}
