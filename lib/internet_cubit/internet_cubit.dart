import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState>{
    Connectivity connecitivity = Connectivity();
    StreamSubscription? connectivitySubscription;

    InternetCubit() : super(InternetState.initial){
      connectivitySubscription = connecitivity.onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
       emit(InternetState.connected);
      }else{
        emit(InternetState.lost);
      }
    });


   
  }

  @override
  Future<void> close() {
connectivitySubscription!.cancel();
return super.close();
  }



}