import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webnsoft_solution/utils/connecivity_bloc/connectivity_event.dart';
import 'package:webnsoft_solution/utils/connecivity_bloc/connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  Connectivity connecitivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityState.initial) {
    on<CheckConnectivityEvent>((event, emit) {
      connectivitySubscription = connecitivity.onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          emit(ConnectivityState.connected);
        } else {
          emit(ConnectivityState.lost);
        }
      });
    });
  }
}
