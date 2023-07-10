import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/store_details.dart';
import '../../domain/usecases/store_details_uc.dart';
import '../common/state_renderer/state_renderer.dart';
import '../base/base_vm.dart';
import '../common/state_renderer/state_renderer_empl.dart';

class StoreDetailsVM extends BaseVM
    with StoreDetailsVMInput, StoreDetailsVMOutput {
  final StreamController _storeDetailsSC = BehaviorSubject<StoreDetails>();

  final StoreDetailsUC _storeDetailsUC;

  StoreDetailsVM(this._storeDetailsUC);

  @override
  void start() {
    _getStoreDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _storeDetailsSC.close();
  }

  _getStoreDetails() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      inputState.add(
        LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
          message: "Loading Store Details",
        ),
      );
    });

    (await _storeDetailsUC.execute(1)).fold(
      (failure) {
        inputState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message,
        ));
      },
      (storeData) {
        inputState.add(ContentState());
        _storeDetailsSC.add(storeData);
      },
    );
  }

  // Inputs
  //

  @override
  Sink get inputStoreDetails => _storeDetailsSC.sink;

  // Outputs
  //

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsSC.stream.map((data) => data);
}

abstract class StoreDetailsVMOutput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsVMInput {
  Stream<StoreDetails> get outputStoreDetails;
}
