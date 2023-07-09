import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../common/state_renderer/state_renderer_empl.dart';

abstract class BaseVMInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseVMOutputs {
  Stream<FlowState> get outputState;
}

abstract class BaseVM extends BaseVMInputs with BaseVMOutputs {
  final StreamController _inputSC = BehaviorSubject<FlowState>();

  @override
  void dispose() {
    _inputSC.close();
  }

  @override
  Sink get inputState => _inputSC.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputSC.stream.map((flowState) => flowState);
}
