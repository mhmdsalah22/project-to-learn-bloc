import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_events.dart';
import '../bloc/user_state.dart';
import '../bloc/user_bloc.dart';
import '../data/UserProvider.dart';

class MyBlocPage extends StatefulWidget {
  const MyBlocPage({Key? key}) : super(key: key);

  @override
  State<MyBlocPage> createState() => _MyBlocPageState();
}

class _MyBlocPageState extends State<MyBlocPage> {
  bool change = true;
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.person_add),
      ),
      body: buildBloc(),
    );
  }

  Widget buildBloc() {
    return BlocBuilder<UserBloc , UserState>(
        builder: (context , state){
          if (state is SuccessAddUserState) {
            return const Center(
              child: Text(
                ' Success Creating User',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            );
          }
          if (state is ErrorAddUserState) {
            return const Center(
              child: Text(
                'ERROR !!!!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            );
          }

          if(state is ErrorGetUserState){
            return const Center(
              child: Text(
                'ERROR !!!!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            );
          }
          if(state is LoadingState ){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is SuccessGetUserState){
           List<User> users = state.users;
           return buildUserList(users);
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      context.read<UserBloc>().add(GetUserEvent());
                    },
                    child:const Text(
                    'GET USER ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      context.read<UserBloc>().add(AddUserEvent(name:'mohammed salah alamassi', email: 'aabonahed@gmail.com' , gender: 'male'));
                    },
                    child:const Text(
                      'ADD USER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),),
                ),
              ],
            ),

          );
        }
        );
  }

  Widget buildUserList(List<User> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
          );
        });
  }
}
