import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../presentation/resources/strings_manager.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // error from Dio response
      failure = _handleError(error);
    } else {
      // unknown error / default error
      failure = ErrorSource.unKnown.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return ErrorSource.connectionTimeOut.getFailure();
    case DioErrorType.sendTimeout:
      return ErrorSource.sendTimeOut.getFailure();
    case DioErrorType.receiveTimeout:
      return ErrorSource.recieveTimeOut.getFailure();
    case DioErrorType.badCertificate:
      if (error.response != null) {
        if (error.response!.statusCode != null &&
            error.response!.statusMessage != null) {
          return Failure(
            code: error.response!.statusCode!,
            message: error.response!.statusMessage!,
          );
        } else {
          return ErrorSource.unKnown.getFailure();
        }
      } else {
        return ErrorSource.unKnown.getFailure();
      }
    case DioErrorType.badResponse:
      if (error.response != null) {
        if (error.response!.statusCode != null &&
            error.response!.statusMessage != null) {
          return Failure(
            code: error.response!.statusCode!,
            message: error.response!.statusMessage!,
          );
        } else {
          return ErrorSource.unKnown.getFailure();
        }
      } else {
        return ErrorSource.unKnown.getFailure();
      }
    case DioErrorType.cancel:
      return ErrorSource.cancle.getFailure();
    case DioErrorType.connectionError:
      return ErrorSource.noInternetConnection.getFailure();
    case DioErrorType.unknown:
      return ErrorSource.unKnown.getFailure();
  }
}

enum ErrorSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectionTimeOut,
  cancle,
  recieveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unKnown,
}

extension DataSourceExtention on ErrorSource {
  Failure getFailure() {
    switch (this) {
      case ErrorSource.success:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.noContent:
        return Failure(
          code: ResponseCode.noContent,
          message: AppStrings.noContent.tr(),
        );
      case ErrorSource.badRequest:
        return Failure(
          code: ResponseCode.badRequest,
          message: AppStrings.badRequest.tr(),
        );
      case ErrorSource.forbidden:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.unAuthorized:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.notFound:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.internalServerError:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.connectionTimeOut:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.cancle:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.recieveTimeOut:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.sendTimeOut:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.cacheError:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.noInternetConnection:
        return Failure(
          code: ResponseCode.success,
          message: AppStrings.success.tr(),
        );
      case ErrorSource.unKnown:
        return Failure(
          code: ResponseCode.unknown,
          message: AppStrings.unknown.tr(),
        );
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unAuthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 200;

  // not standard
  static const int connectionTimeOut = -1;
  static const int cancle = -2;
  static const int recieveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

class ApiInternalStatus {
  static const int success = 1;
  static const int failure = 0;
}
