// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_screen_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SplashScreenViewModel on _SplashScreenViewModelBase, Store {
  Computed<bool>? _$updateAvaibleComputed;

  @override
  bool get updateAvaible =>
      (_$updateAvaibleComputed ??= Computed<bool>(() => super.updateAvaible,
              name: '_SplashScreenViewModelBase.updateAvaible'))
          .value;

  final _$_updateAvaibleAtom =
      Atom(name: '_SplashScreenViewModelBase._updateAvaible');

  @override
  bool get _updateAvaible {
    _$_updateAvaibleAtom.reportRead();
    return super._updateAvaible;
  }

  @override
  set _updateAvaible(bool value) {
    _$_updateAvaibleAtom.reportWrite(value, super._updateAvaible, () {
      super._updateAvaible = value;
    });
  }

  final _$_SplashScreenViewModelBaseActionController =
      ActionController(name: '_SplashScreenViewModelBase');

  @override
  void setUpdateAvaible(bool value) {
    final _$actionInfo = _$_SplashScreenViewModelBaseActionController
        .startAction(name: '_SplashScreenViewModelBase.setUpdateAvaible');
    try {
      return super.setUpdateAvaible(value);
    } finally {
      _$_SplashScreenViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
updateAvaible: ${updateAvaible}
    ''';
  }
}
