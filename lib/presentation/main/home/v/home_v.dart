import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/entities/store.dart';
import 'package:advanced_flutter/presentation/resources/colors_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/banner.dart' as b;
import '../../../../domain/entities/service.dart' as s;
import '../../../common/state_renderer/state_renderer_empl.dart';
import '../../../main/home/vm/home_vm.dart';

class HomeV extends StatefulWidget {
  const HomeV({super.key});

  @override
  State<HomeV> createState() => _HomeVState();
}

class _HomeVState extends State<HomeV> {
  final HomeVM _homeVM = gi<HomeVM>();

  _bind() {
    _homeVM.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _homeVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _homeVM.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                  context: context,
                  contentScreenWidget: _getContnetWidget(),
                  retryActionFunction: () {
                    _homeVM.start();
                  },
                ) ??
                const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _getContnetWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStorse()
      ],
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<List<b.Banner>>(
      stream: _homeVM.outputBanners,
      builder: (context, snapshot) => _getBannerWidget(snapshot.data),
    );
  }

  Widget _getBannerWidget(List<b.Banner>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners.map((banner) {
          return SizedBox(
            width: double.infinity,
            child: Card(
              elevation: AppSize.s1_5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSize.s12),
                ),
                side: BorderSide(color: ColorManager.white, width: AppSize.s1),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSize.s12),
                ),
                child: Image.network(
                  banner.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: AppSize.s200,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p2,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getServices() {
    return StreamBuilder<List<s.Service>>(
      stream: _homeVM.outputServices,
      builder: (context, snapshot) => _getServicesWidget(snapshot.data),
    );
  }

  Widget _getServicesWidget(List<s.Service>? services) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        child: Container(
          height: AppSize.s150,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services.map((service) {
              return Card(
                elevation: AppSize.s4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.s12),
                  ),
                  side: BorderSide(
                      color: ColorManager.primary, width: AppSize.s1),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSize.s12),
                      ),
                      child: Image.network(
                        service.image,
                        fit: BoxFit.cover,
                        width: AppSize.s100,
                        height: AppSize.s100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          service.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _getStorse() {
    return StreamBuilder<List<Store>>(
      stream: _homeVM.outputStores,
      builder: (context, snapshot) => _getStoresWidget(snapshot.data),
    );
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null) {
      return Container(
        padding: const EdgeInsets.all(AppSize.s10),
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
        child: Flex(direction: Axis.vertical, children: [
          GridView.count(
            crossAxisCount: AppSize.s2.toInt(),
            crossAxisSpacing: AppSize.s8,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(stores.length, (index) {
              Store store = stores[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                },
                child: Card(
                  elevation: AppSize.s4,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.s4),
                    ),
                    side: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s4),
                    ),
                    child: Image.network(
                      store.image,
                      fit: BoxFit.cover,
                      width: AppSize.s80,
                      height: AppSize.s80,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ]),
      );
    } else {
      return const SizedBox();
    }
  }
}
