import 'dart:async';
import '../bloc/user_events.dart';
import '../bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/UserProvider.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialState()) {
    on<GetUserEvent>(_getUserList);
    on<AddUserEvent>(_addUser);
  }

  FutureOr<void> _getUserList(GetUserEvent event,
      Emitter<UserState> emit) async {
    emit(LoadingState());
    try {
      List<User> user = await ApiProvider().getUsers();
      emit(SuccessGetUserState(user));
    } catch (error) {
      print(error);
      emit(ErrorGetUserState());
    }
  }

  FutureOr<void> _addUser(AddUserEvent event, Emitter<UserState> emit)async {
    emit(LoadingState());
    try{
      bool isCreated = await ApiProvider().postUser(
          name: event.name, gender: event.gender, email: event.email);
      if(isCreated){
        emit(SuccessAddUserState());
      }else{
        emit(ErrorAddUserState());
      }
    }catch(error){
      print('error is ${error.toString()}');
      emit(ErrorAddUserState());
    }
  }
}
