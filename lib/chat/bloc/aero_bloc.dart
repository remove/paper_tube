import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'aero_event.dart';

part 'aero_state.dart';

class AeroBloc extends Bloc<AeroEvent, AeroState> {
  AeroBloc() : super(SwitchState(false));

  @override
  Stream<AeroState> mapEventToState(
    AeroEvent event,
  ) async* {
    if (event is SwitchButton) {
      if (state is SwitchState) {
        yield SwitchState(!(state as SwitchState).open);
      } else {
        yield SwitchState(!(state as AeroInitial).open);
      }
    }
  }

  Stream<SwitchState> changeButton() async* {
    bool open = false;
    for (int i = 0; i < 100; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield SwitchState(!open);
      open = !open;
    }
  }
}
