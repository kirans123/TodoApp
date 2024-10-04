import 'package:dio/dio.dart';
import 'package:login_and_registration/utils/constants/constants.dart';
import 'package:login_and_registration/utils/constants/keys.dart';
import 'package:login_and_registration/utils/constants/map.dart';

class AppResponse {
  AppResponse();
  int statusCode = kSuccessCode;
  String message = '';
  Map<String, dynamic> data = const {};

  bool get isSuccess =>
      statusCode == kSuccessCode || statusCode == kRequestFullFilled;

  bool get isFailed =>
      statusCode != kSuccessCode && statusCode != kRequestFullFilled;

  AppResponse.error({
    String? message,
    this.data = const {},
    error,
    StackTrace? stackTrace,
  }) {
    statusCode = kServerErrorCode;
    this.message = message ?? kServerErrorMessage;
  }

  AppResponse.fromDioResponse(Response response) {
    try {
      Map<String, dynamic> rawData = <String, dynamic>{};
      // if response.data is Map then use it as it is
      // else if it is String or list then
      // create a map with key as payload and value as response.data
      final responseData = response.data;
      statusCode = response.statusCode ?? kServerErrorCode;

      if (responseData is Map<String, dynamic>) {
        //this is  the case for retrieving the list of records
        if (responseData.containsKey(AppKeys.data)) {
          if (responseData[AppKeys.data] is Map<String, dynamic>) {
            rawData = responseData[AppKeys.data];
          } else {
            rawData = {
              AppKeys.data: responseData[AppKeys.data],
            };
          }
          data = rawData;
          message = responseData.getString(AppKeys.message);
        } //check if response contains user key then set data as user, this is for login api
        else if (responseData.containsKey(AppKeys.user)) {
          data = responseData[AppKeys.user];
          message = responseData.getString(AppKeys.message);
        } else if (responseData.containsKey(AppKeys.error)) {
          //if response contains error key then set status code as server error code
          message = responseData.getString(AppKeys.message);
          //check if redirectedResponse has error key then return error else return success
          //from backend receiving same same status code for both success and error
          //so checking error key in response to differentiate between success and error
          statusCode = kServerErrorCode;
        } else if (responseData.containsKey(AppKeys.message)) {
          //this is used while uploading the file and while deleting the file
          message = responseData.getString(AppKeys.message);
        } else {
          message =
              (statusCode == kSuccessCode || statusCode == kRequestFullFilled
                  ? kSuccessMessage
                  : kServerErrorMessage);
        }
      } else {
        rawData = {
          AppKeys.data: responseData,
        };
        data = rawData;
        message = kSuccessMessage;
      }
    } catch (e) {
      statusCode = kServerErrorCode;
      message = kServerErrorMessage;
      data = const {};
    }
  }
}
