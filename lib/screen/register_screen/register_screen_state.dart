import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:state_notifier/state_notifier.dart';

part 'register_screen_state.freezed.dart';

@freezed
abstract class RegisterScreenState with _$RegisterScreenState {
  const factory RegisterScreenState({
    @Default('') String FaceBookID,
  }) = _RegisterScreenState;
}

class RegisterScreenController extends StateNotifier<RegisterScreenState> with LocatorMixin {
  RegisterScreenController({
    required this.context,
    required this.preference,
  }) : super (const RegisterScreenState());

  final BuildContext context;
  final Preference preference;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTap() {

  }





}
