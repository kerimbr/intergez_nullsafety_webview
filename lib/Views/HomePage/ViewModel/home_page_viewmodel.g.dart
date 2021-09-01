// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageViewModel on _HomePageViewModelBase, Store {
  Computed<bool>? _$searchPanelShowComputed;

  @override
  bool get searchPanelShow =>
      (_$searchPanelShowComputed ??= Computed<bool>(() => super.searchPanelShow,
              name: '_HomePageViewModelBase.searchPanelShow'))
          .value;

  final _$urlAtom = Atom(name: '_HomePageViewModelBase.url');

  @override
  String get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  final _$progressAtom = Atom(name: '_HomePageViewModelBase.progress');

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  final _$_searchPanelShowAtom =
      Atom(name: '_HomePageViewModelBase._searchPanelShow');

  @override
  bool get _searchPanelShow {
    _$_searchPanelShowAtom.reportRead();
    return super._searchPanelShow;
  }

  @override
  set _searchPanelShow(bool value) {
    _$_searchPanelShowAtom.reportWrite(value, super._searchPanelShow, () {
      super._searchPanelShow = value;
    });
  }

  final _$_HomePageViewModelBaseActionController =
      ActionController(name: '_HomePageViewModelBase');

  @override
  void setSearchPanelShow(bool value) {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.setSearchPanelShow');
    try {
      return super.setSearchPanelShow(value);
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUrl(String url) {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.setUrl');
    try {
      return super.setUrl(url);
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProgress(double prog) {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.setProgress');
    try {
      return super.setProgress(prog);
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
url: ${url},
progress: ${progress},
searchPanelShow: ${searchPanelShow}
    ''';
  }
}
