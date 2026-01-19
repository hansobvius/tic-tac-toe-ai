// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelState, Store {
  late final _$userBoardStateAtom = Atom(
    name: 'HomeViewModelState.userBoardState',
    context: context,
  );

  @override
  List<List<int>> get userBoardState {
    _$userBoardStateAtom.reportRead();
    return super.userBoardState;
  }

  @override
  set userBoardState(List<List<int>> value) {
    _$userBoardStateAtom.reportWrite(value, super.userBoardState, () {
      super.userBoardState = value;
    });
  }

  late final _$oponentBoardStateAtom = Atom(
    name: 'HomeViewModelState.oponentBoardState',
    context: context,
  );

  @override
  List<List<int>> get oponentBoardState {
    _$oponentBoardStateAtom.reportRead();
    return super.oponentBoardState;
  }

  @override
  set oponentBoardState(List<List<int>> value) {
    _$oponentBoardStateAtom.reportWrite(value, super.oponentBoardState, () {
      super.oponentBoardState = value;
    });
  }

  late final _$HomeViewModelStateActionController = ActionController(
    name: 'HomeViewModelState',
    context: context,
  );

  @override
  void setPlay({required int row, required int column}) {
    final _$actionInfo = _$HomeViewModelStateActionController.startAction(
      name: 'HomeViewModelState.setPlay',
    );
    try {
      return super.setPlay(row: row, column: column);
    } finally {
      _$HomeViewModelStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userBoardState: ${userBoardState},
oponentBoardState: ${oponentBoardState}
    ''';
  }
}
