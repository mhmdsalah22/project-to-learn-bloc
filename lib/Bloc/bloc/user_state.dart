import '../data/UserProvider.dart';

abstract class UserState {}

class InitialState extends UserState {}

class LoadingState extends UserState {}

class SuccessGetUserState extends UserState {
  late List<User> users;
  SuccessGetUserState(this.users);
}

class ErrorGetUserState extends UserState {}

class SuccessAddUserState extends UserState {}

class ErrorAddUserState extends UserState {}
