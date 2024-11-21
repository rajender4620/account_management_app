import 'package:account_management/model/users.dart';
import 'package:account_management/ui/userlist/cubit/userlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key, required this.users}) : super(key: key);

  final List<User> users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        title: const Text('Registered Users'),
        actions: const [LogoutUserDialouge()],
      ),
      body: BlocBuilder<UserlistCubit, UserlistState>(
        builder: (context, state) {
          if (state is UserlistInitial) {
            print('initial');
            context.read<UserlistCubit>().init(users);
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadedState) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No users found.'));
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.grey.shade100,
                        child: Text(
                          user.firstName!.substring(0, 1).toUpperCase(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.mobileNumber ?? ''),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text('Delete Account'),
                                content: const Text(
                                    'Are You Sure You want to delete Account'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'NO',
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<UserlistCubit>()
                                          .deleteUser(user.firstName ?? '');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Deleted Successfully')),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'YES',
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
            );
          } else if (state is UserErrorState) {
            return Center(child: Text(state.message ?? ''));
          }
          return const Center(child: Text('Press to load users.'));
        },
      ),
    );
  }
}

class LogoutUserDialouge extends StatelessWidget {
  const LogoutUserDialouge({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are You Sure You want to Logout'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'NO',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'YES',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.logout));
  }
}
