import 'package:get/get.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

/// A GetX controller that manages the global application state.
///
/// This class holds essential user-related data that needs to be accessible
/// throughout the app, such as the authenticated user's profile, their role,
/// and their specific permissions for different parts of the application.
/// It is intended to be a single source of truth for the user's session state.
class AppStateController extends GetxController {
  final Rx<UserModel> _user = UserModel.empty().obs;
  final Rx<UserModel> _userLogued = UserModel.empty().obs;
  final Rx<bool> _isDoctor = true.obs;
  final RxMap<String, dynamic> _userPermissions = <String, dynamic>{}.obs;
  final Rx<String> _version = ''.obs;

  /// *******************************************************
  /// Setters
  /// *******************************************************

  /// Sets the user's permissions map.
  set userPermissions(Map<String, dynamic> newPermisosMap) =>
      _userPermissions.value = newPermisosMap;

  /// Sets the currently authenticated user model.
  set user(UserModel newUser) => _user.value = newUser;

  set userLogued(UserModel newUser) => _userLogued.value = newUser;

  /// Sets whether the current user has a doctor role.
  set isDoctor(bool value) => _isDoctor.value = value;
  
  set version(String value) => _version.value = value;

  /// *******************************************************
  /// Getters
  /// *******************************************************

  /// The currently authenticated user's data.
  UserModel get user => _user.value;

  UserModel get userLogued => _userLogued.value;

  /// Returns `true` if the user is a doctor, `false` otherwise.
  bool get isDoctor => _isDoctor.value;

  /// Returns `true` if the user's JWT is empty.
  ///
  /// **Note:** The logic for this getter is inverted. It returns `true` when
  /// the user is effectively logged out (i.e., has no token).
  bool get isLoggedIn => _user.value.token.jwt.isEmpty;

  /// A map containing the user's permissions, where keys are feature/page
  /// names and values determine access.
  Map<String, dynamic> get userPermissions => _userPermissions;

  String get version => _version.value;

  /// Resets all state variables to their initial empty state.
  ///
  /// This is typically called during a sign-out process to clear the
  /// user's session data.
  void reset() {
    _user.value = UserModel.empty();
    _isDoctor.value = true;
    _userPermissions.value = {};
  }
}
