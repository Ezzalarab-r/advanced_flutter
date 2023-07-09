import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/entities/home_data.dart';
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
                const Center(child: Text("unknown error"));
          },
        ),
      ),
    );
  }

  Widget _getContnetWidget() {
    return StreamBuilder<HomeData>(
        stream: _homeVM.outputHomeData,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("null data"));
          }
          HomeData homeObjectData = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBannersCarousel(homeObjectData.banners),
              _getSection(AppStrings.services),
              _getServices(homeObjectData.services),
              _getSection(AppStrings.stores),
              _getStorse(homeObjectData.stores)
            ],
          );
        });
  }

  Widget _getBannersCarousel(List<b.Banner> banners) {
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
              side: BorderSide(
                color: ColorManager.white,
                width: AppSize.s1,
              ),
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

  Widget _getServices(List<s.Service> services) {
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
                side:
                    BorderSide(color: ColorManager.primary, width: AppSize.s1),
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
  }

  Widget _getStorse(List<Store> stores) {
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
  }
}
