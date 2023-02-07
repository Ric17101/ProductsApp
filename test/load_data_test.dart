import 'package:app/api/api_service.dart';
import 'package:app/api/models/data.dart';
import 'package:app/state/actions/actions.dart';
import 'package:app/state/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  test('Initial state.', () {
    var storeTester = StoreTester<AppState>(initialState: AppState.init());

    expect(storeTester.state.data, const Data());
  });

  test('Get Data request action then populate AppState data products', () async {
    var storeTester = StoreTester<AppState>(initialState: AppState.init());
    expect(storeTester.state.data, const Data());
    expect(storeTester.state.data.products, isEmpty);

    storeTester.dispatch(GetDataAction());

    TestInfo<AppState> info = await storeTester.waitUntil(GetDataAction);

    expect(info.state.data.products, isNotEmpty);
    expect(info.state.data.products.length, 10);
  });
}
