part of 'userlist_cubit.dart';

class UserlistState {}

class UserlistInitial extends UserlistState {}

class UserLoadingState extends UserlistState {}

class UserLoadedState extends UserlistState {
  UserLoadedState(this.users);
  List<User> users = [];
}

class UserErrorState extends UserlistState {
  UserErrorState(this.message);
  final String? message;
}
