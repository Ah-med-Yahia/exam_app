import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';

Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();
    return SuccessResponse<T>(data: response);
  } catch (error) {
    return ErrorResponse<T>(error: RemoteException(message: error.toString()));
  }
}
 