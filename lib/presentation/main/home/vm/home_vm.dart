import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/service.dart';
import '../../../../domain/entities/store.dart';
import '../../../../domain/entities/banner.dart';
import '../../../../domain/usecases/home_uc.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../base/base_vm.dart';
import '../../../common/state_renderer/state_renderer_empl.dart';

class HomeVM extends BaseVM with HomeVMInput, HomeVMOutput {
  final StreamController _bannersSC = BehaviorSubject<List<Banner>>();
  final StreamController _servicesSC = BehaviorSubject<List<Service>>();
  final StreamController _storesSC = BehaviorSubject<List<Store>>();

  final HomeUC _homeUC;

  HomeVM(this._homeUC);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _bannersSC.close();
    _servicesSC.close();
    _storesSC.close();
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
    print("add LoadingState   ++++++++");

    (await _homeUC.execute(null)).fold(
      (failure) {
        inputState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message,
        ));
      },
      (homeObject) {
        _bannersSC.add(homeObject.data.banners);
        _servicesSC.add(homeObject.data.services);
        _storesSC.add(homeObject.data.stores);
        inputState.add(ContentState());
      },
    );
  }

  // Inputs
  //

  @override
  Sink get inputBanners => _bannersSC.sink;

  @override
  Sink get inputServices => _servicesSC.sink;

  @override
  Sink get inputStores => _storesSC.sink;

  // Outputs
  //

  @override
  Stream<List<Banner>> get outputBanners =>
      _bannersSC.stream.map((banner) => banner);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesSC.stream.map((service) => service);

  @override
  Stream<List<Store>> get outputStores =>
      _storesSC.stream.map((store) => store);
}

abstract class HomeVMOutput {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeVMInput {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<Banner>> get outputBanners;
}
