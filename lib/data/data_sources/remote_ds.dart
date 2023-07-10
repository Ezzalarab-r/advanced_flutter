import '../network/app_api.dart';
import '../requestes/login_request.dart';
import '../responses/responses.dart';

abstract class RemoteDS {
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails(int storeId);
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthResponse> register(RegisterRequest loginRequest);
}

class RemoteDSImpl implements RemoteDS {
  final AppServiceClient _appServiceClient;
  RemoteDSImpl(this._appServiceClient);

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.fotgotPassword(email);
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.userName,
      registerRequest.countryMobileCode,
      registerRequest.mobileNumber,
      registerRequest.email,
      registerRequest.password,
      "", //registerRequest.profilePicture,
    );
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails(int storeId) async {
    return await _appServiceClient.getStoreDetails(storeId);
  }
}
