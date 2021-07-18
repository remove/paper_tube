part of 'aero_bloc.dart';

@immutable
abstract class AeroState {}

class AeroInitial extends AeroState {
  AeroInitial(this.open);

  final bool open;
}

class SwitchState extends AeroState {
  SwitchState(this.open);

  final bool open;
}
