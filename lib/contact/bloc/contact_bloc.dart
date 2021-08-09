import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paper_tube/im/im_core.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial());
  final IMCore _imCore = IMCore();

  @override
  Future<void> close() {
    print("$this关闭流");
    return super.close();
  }

  @override
  void onTransition(Transition<ContactEvent, ContactState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is ContactLoadCompleted) {
      yield ContactListening();
    } else if (event is ContactAddInput) {
      yield ContactResult(await _imCore.getUserInfo(event.userId));
    }
  }
}
