import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/core/netowk/custom_exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        queryParameters: {
          "apiKey": "f78457c45b5b42639cfde7a62a5f4ea",
        },
        baseUrl: "http://getcar.runasp.net/api",
        headers: {
          "Accept": "multipart/form-data",
          "Content-Type": "multipart/form-data",
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    // customization
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ));
  }

  static CustomException errorHandler(DioException error) {
    String message = "";
    int? statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = "connection timeout please try again";
        break;

         case DioExceptionType.connectionError:
        message = "النت مفقووووووول";
        break;
      case DioExceptionType.sendTimeout:
        message = "send timeout please try again";
        break;
      case DioExceptionType.receiveTimeout:
        message = "receive timeout please try again";
        break;
      case DioExceptionType.badCertificate:
        message = "bad certificate please try again";
        break;
      case DioExceptionType.badResponse:
        message = "ؤاجع الداتا الي باعتها يا كبير";
        break;
      case DioExceptionType.cancel:
        message = "cancel please try again";
        break;
      default:
        message = "some thing went wrong please try again";
        break;
    }

    return CustomException(message: message, statusCode: statusCode);
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(url, queryParameters: queryParameters);
    } on DioException catch (error) {
      throw errorHandler(error);
    } catch (e) {
      throw CustomException(message: "some thing went wrong please try again");
    }
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {

        try {
    return await dio.post(url, queryParameters: queryParameters, data: data);
    } on DioException catch (error) {
      throw errorHandler(error);
    } catch (e) {
      throw CustomException(message: "some thing went wrong please try again");
    }
  }
}
