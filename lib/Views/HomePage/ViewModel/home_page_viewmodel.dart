import 'package:mobx/mobx.dart';
part 'home_page_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store{

  @observable
  String url = "https://www.intergez.com/";

  @observable
  double progress = 0;

  @observable
  bool _searchPanelShow = false;

  @computed
  bool get searchPanelShow => _searchPanelShow;

  @action
  void setSearchPanelShow(bool value) => _searchPanelShow = value;


  @action
  void setUrl(String url) => this.url = url;

  @action
  void setProgress(double prog) => progress = prog;





}