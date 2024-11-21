import 'package:account_management/model/users.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

part 'userlist_state.dart';

class UserlistCubit extends Cubit<UserlistState> {
  UserlistCubit() : super(UserlistInitial());

  void init(List<User> users) async {
    final localStorage = await SharedPreferences.getInstance();
    final res = localStorage.get('userData');

    emit(UserLoadedState(users));
    print('initia method');
  }

  void deleteUser(String username) {
    final ls = state as UserLoadedState;
    final updatedUsers =
        ls.users.where((element) => element.firstName != username).toList();

    emit(UserLoadedState(updatedUsers));
  }
}
