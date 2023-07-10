import 'dart:async';
import '../../../domain/entities/home_data.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/home_uc.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../base/base_vm.dart';
import '../../common/state_renderer/state_renderer_empl.dart';

class HomeVM extends BaseVM with HomeVMInput, HomeVMOutput {
  final StreamController _homeDataSC = BehaviorSubject<HomeData>();

  final HomeUC _homeUC;

  HomeVM(this._homeUC);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _homeDataSC.close();
  }

  _getHomeData() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      inputState.add(
        LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
          message: "Loading Home Data",
        ),
      );
    });

    (await _homeUC.execute(null)).fold(
      (failure) {
        inputState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message,
        ));
      },
      (homeObject) {
        inputState.add(ContentState());
        _homeDataSC.add(homeObject.data);
      },
    );
  }

  // Inputs
  //

  @override
  Sink get inputHomeData => _homeDataSC.sink;

  // Outputs
  //

  @override
  Stream<HomeData> get outputHomeData => _homeDataSC.stream.map((data) => data);
}

abstract class HomeVMOutput {
  Sink get inputHomeData;
}

abstract class HomeVMInput {
  Stream<HomeData> get outputHomeData;
}
