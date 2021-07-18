import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:paper_tube/chat/bloc/aero_bloc.dart';

enum AeroListener { ricer, none }

class MyBloc extends Bloc<AeroListener, int> {
  MyBloc(this.aeroBloc) : super(0) {
    streamSubscription = aeroBloc.stream.listen((event) {
      if (event is SwitchState) {
        add(AeroListener.ricer);
      }
    });
  }

  final AeroBloc aeroBloc;
  StreamSubscription? streamSubscription;

  @override
  Stream<int> mapEventToState(event) async* {
    if (event == AeroListener.ricer) {
      print("收到了Ricer");
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
