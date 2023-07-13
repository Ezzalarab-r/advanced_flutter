// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../../domain/entities/slider_object.dart';
import '../../domain/entities/slider_view_object.dart';
import '../base/base_vm.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingVM extends BaseVM with OnBoardingVMInputs, OnBoardingVMOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentPageIndex = 0;

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    int previousIndex = ++_currentPageIndex;
    if (previousIndex == _list.length) {
      previousIndex = 0;
    }
    return previousIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentPageIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int pageIndex) {
    _currentPageIndex = pageIndex;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObjeect =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // On Boarding Private Functions

  List<SliderObject> _getSliderData() => [
        SliderObject(
          title: AppStrings.onBoardingTitle1.tr(),
          subTitle: AppStrings.onBoardingSubTitle1.tr(),
          image: ImagesAssets.artificialBrain,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle2.tr(),
          subTitle: AppStrings.onBoardingSubTitle2.tr(),
          image: ImagesAssets.python,
        ),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      sliderObject: _list[_currentPageIndex],
      slidesCount: _list.length,
      curretPageIndex: _currentPageIndex,
    ));
  }
}

abstract class OnBoardingVMInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(int pageIndex);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingVMOutputs {
  Stream<SliderViewObject> get outputSliderViewObjeect;
}
