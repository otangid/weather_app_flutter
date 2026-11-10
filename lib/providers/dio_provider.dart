import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );
  final dioInstance = Dio(options);
  // Pasang interceptor global yang memegang 'ref'
  dioInstance.interceptors.add(RiverpodDioInterceptor(ref));
  return dioInstance;
}

@riverpod
class DioErrorUi extends _$DioErrorUi {
  @override
  String? build() => null; // default tidak ada error

  void setError(String message) => state = message;

  void clearError() => state = null;
}

class RiverpodDioInterceptor extends Interceptor {
  final Ref ref;
  RiverpodDioInterceptor(this.ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "An error occurred, please try again.";

    if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = "Connection timeout, please try again.";
    } else if (err.response != null) {
      errorMessage = err.response?.data?['message'] ?? "Error ${err.response?.statusCode}";
    }

    // UPDATE STATE: Update pesan error agar UI yang me-watch tahu ada error
    ref.read(dioErrorUiProvider.notifier).setError(errorMessage);

    // Jinakkan error agar aplikasi tidak crash
    return handler.resolve(
      Response(requestOptions: err.requestOptions, statusCode: err.response?.statusCode ?? 500, data: null),
    );
  }
}
