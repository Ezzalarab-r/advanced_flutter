import 'banner.dart';
import 'service.dart';
import 'store.dart';

class HomeData {
  List<Service> services;
  List<Banner> banners;
  List<Store> stores;

  HomeData({
    required this.services,
    required this.banners,
    required this.stores,
  });
}
