import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/local_ds.dart';
import '../data/data_sources/remote_ds.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repositories/repository_impl.dart';
import '../domain/repositories/repository.dart';
import '../domain/usecases/forgot_password_uc.dart';
import '../domain/usecases/home_uc.dart';
import '../domain/usecases/login_uc.dart';
import '../domain/usecases/register_uc.dart';
import '../domain/usecases/store_details_uc.dart';
import '../presentation/forgot_password/forgot_password_vm.dart';
import '../presentation/login/login_vm.dart';
import '../presentation/main/home/home_vm.dart';
import '../presentation/register/register_vm.dart';
import '../presentation/store_details/store_details_vm.dart';
import 'app_preferences.dart';

final gi = GetIt.instance;

// Global Dependancies //
Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // AppPreference
  gi.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  gi.registerLazySingleton<AppPreferences>(
      () => AppPreferences(gi<SharedPreferences>()));

  // Network Info
  gi.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  // TODO check if there is problem
  gi.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(gi<InternetConnectionChecker>()));

  // Dio
  gi.registerLazySingleton<DioFactory>(() => DioFactory(gi<AppPreferences>()));
  Dio dio = await gi<DioFactory>().getDio();

  // App Service Client
  gi.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // Remote Data Source
  gi.registerLazySingleton<RemoteDS>(
      () => RemoteDSImpl(gi<AppServiceClient>()));

  // Local Data Source
  gi.registerLazySingleton<LocalDS>(() => LocalDSImpl());

  // Repository
  gi.registerLazySingleton<Repository>(() => RepositoryImpl(
        gi<NetworkInfo>(),
        gi<RemoteDS>(),
        gi<LocalDS>(),
      ));
}

Future<void> initLoginModule() async {
  if (!gi.isRegistered<LoginUC>()) {
    gi.registerFactory<LoginUC>(() => LoginUC(gi<Repository>()));
    gi.registerFactory<LoginVM>(() => LoginVM(gi<LoginUC>()));
  }
}

Future<void> initForgotPasswordModule() async {
  if (!gi.isRegistered<ForgotPasswordUC>()) {
    gi.registerFactory<ForgotPasswordUC>(
        () => ForgotPasswordUC(gi<Repository>()));
    gi.registerFactory<ForgotPasswordVM>(
        () => ForgotPasswordVM(gi<ForgotPasswordUC>()));
  }
}

Future<void> initRegisterModule() async {
  if (!gi.isRegistered<RegisterUC>()) {
    gi.registerFactory<RegisterUC>(() => RegisterUC(gi<Repository>()));
    gi.registerFactory<RegisterVM>(() => RegisterVM(gi<RegisterUC>()));
    gi.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

Future<void> initHomeModule() async {
  if (!gi.isRegistered<HomeUC>()) {
    gi.registerFactory<HomeUC>(() => HomeUC(gi<Repository>()));
    gi.registerFactory<HomeVM>(() => HomeVM(gi<HomeUC>()));
  }
}

Future<void> initStoreDetails() async {
  if (!gi.isRegistered<StoreDetailsUC>()) {
    gi.registerFactory<StoreDetailsUC>(() => StoreDetailsUC(gi<Repository>()));
    gi.registerFactory<StoreDetailsVM>(
        () => StoreDetailsVM(gi<StoreDetailsUC>()));
  }
}
