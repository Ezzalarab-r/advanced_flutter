import 'package:advanced_flutter/domain/entities/store_details.dart';

import '../../app/extensions.dart';
import '../../domain/entities/auth.dart';
import '../../domain/entities/store.dart';
import '../../domain/entities/banner.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/contacts.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/entities/home_object.dart';
import '../responses/responses.dart';
import '../constants.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    if (this == null) {
      return Customer(
        id: DataConstants.empty,
        name: DataConstants.empty,
        notificationsCount: DataConstants.zero,
      );
    } else {
      return Customer(
        id: this!.id.orEmpty(),
        name: this!.name.orEmpty(),
        notificationsCount: this!.notificationsCount.orZero(),
      );
    }
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    if (this == null) {
      return Contacts(
        phone: DataConstants.empty,
        email: DataConstants.empty,
        website: DataConstants.empty,
      );
    } else {
      return Contacts(
        phone: this!.phone.orEmpty(),
        email: this!.email.orEmpty(),
        website: this!.website.orEmpty(),
      );
    }
  }
}

extension AuthResponseMapper on AuthResponse? {
  Auth toDomain() {
    if (this == null) {
      return Auth(
        customer: Customer(
          id: DataConstants.empty,
          name: DataConstants.empty,
          notificationsCount: 0,
        ),
        contacts: Contacts(
          phone: DataConstants.empty,
          email: DataConstants.empty,
          website: DataConstants.empty,
        ),
      );
    } else {
      return Auth(
        customer: this!.customerResponse.orEmpty(),
        contacts: this!.contactsResponse.orEmpty(),
      );
    }
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse {
  String toDomain() {
    if (supportMessage == null) {
      return DataConstants.empty;
    } else {
      return supportMessage!;
    }
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id?.orZero() ?? DataConstants.zero,
      title: this?.title?.orEmpty() ?? DataConstants.empty,
      image: this?.image?.orEmpty() ?? DataConstants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id?.orZero() ?? DataConstants.zero,
      title: this?.title?.orEmpty() ?? DataConstants.empty,
      image: this?.image?.orEmpty() ?? DataConstants.empty,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(
        id: this?.id?.orZero() ?? DataConstants.zero,
        title: this?.title?.orEmpty() ?? DataConstants.empty,
        image: this?.image?.orEmpty() ?? DataConstants.empty,
        link: this?.link?.orEmpty() ?? DataConstants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                const Iterable.empty())
            .cast<Service>()
            .toList();

    List<Store> mappedStores =
        (this?.data?.stores?.map((store) => store.toDomain()) ??
                const Iterable.empty())
            .cast<Store>()
            .toList();

    List<Banner> mappedBanners =
        (this?.data?.banners?.map((bannerAd) => bannerAd.toDomain()) ??
                const Iterable.empty())
            .cast<Banner>()
            .toList();

    final data = HomeData(
      services: mappedServices,
      stores: mappedStores,
      banners: mappedBanners,
    );
    return HomeObject(data: data);
  }
}

extension StoreDetailsMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
        id: this?.id?.orZero() ?? DataConstants.zero,
        title: this?.title?.orEmpty() ?? DataConstants.empty,
        image: this?.image?.orEmpty() ?? DataConstants.empty,
        details: this?.details?.orEmpty() ?? DataConstants.empty,
        services: this?.services?.orEmpty() ?? DataConstants.empty,
        about: this?.about?.orEmpty() ?? DataConstants.empty);
  }
}
