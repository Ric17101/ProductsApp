import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_result.freezed.dart';

@freezed
abstract class AsyncResult<T> with _$AsyncResult<T> {
  const factory AsyncResult.success(T? value) = Data<T>;

  const factory AsyncResult.loading(T? value) = Loading<T>;

  const factory AsyncResult.error([String? message]) = Error<T>;
}
