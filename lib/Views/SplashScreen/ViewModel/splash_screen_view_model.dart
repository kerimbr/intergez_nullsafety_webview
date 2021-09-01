
import 'package:mobx/mobx.dart';
part 'splash_screen_view_model.g.dart';

class SplashScreenViewModel = _SplashScreenViewModelBase with _$SplashScreenViewModel;

abstract class _SplashScreenViewModelBase with Store{

  @observable
  bool _updateAvaible = false;

  @computed
  bool get updateAvaible => _updateAvaible;

  @action
  void setUpdateAvaible(bool value) => _updateAvaible = value;

}