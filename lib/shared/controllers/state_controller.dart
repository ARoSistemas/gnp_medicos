import 'package:get/get.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

class AppStateController extends GetxController {
  // Datos principales
  final Rx<UserModel> _user = UserModel.empty().obs;
  final Rx<bool> _isDoctor = true.obs;

  /// Setters

  /// UserModel
  set user(UserModel newUser) => _user.value = newUser;

  /// Is doctor
  set isDoctor(bool value) => _isDoctor.value = value;

  /// Getters
  UserModel get user => _user.value;

  bool get isDoctor => _isDoctor.value;

  bool get isLoggedIn => _user.value.token.jwt.isEmpty;

  // Reset general (por ejemplo, al cerrar sesión)
  void reset() {
    _user.value = UserModel.empty();
    _isDoctor.value = true;
  }
}
