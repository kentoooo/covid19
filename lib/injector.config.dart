// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'port/statistics_port.dart' as _i3;
import 'presenter/statistics_presenter.dart' as _i4;
import 'state/state.dart' as _i5;
import 'usecase/statistics_usecase.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.StatisticsPort>(() => _i3.StatisticsGateway());
  gh.factory<_i4.StasticsPresenter>(
      () => _i4.StasticsPresenter(get<_i5.ViewState>()));
  gh.factory<_i6.StatisticsUsecase>(() => _i6.StatisticsUsecase(
      get<_i3.StatisticsPort>(), get<_i4.StasticsPresenter>()));
  gh.singleton<_i5.ViewState>(_i5.ViewState());
  return get;
}
