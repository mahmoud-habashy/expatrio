import 'package:coding_challenge/data/models/user_model.dart';
import 'package:coding_challenge/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getUserById({required int userId}) async {
    emit(UserFetchLoading());
    try {
      UserModel? result = await UserRepository.getUserById(userId: userId);
      if (result != null) {
        emit(UserFetchSuccess(userModel: result));
      } else {
        emit(UserFetchError());
      }
    } catch (err) {
      emit(UserFetchError(errorMessage: err.toString()));
    }
  }
}
