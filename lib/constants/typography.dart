import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

// 日本オンリーの場合は固定で
const Locale kLocale = Locale("ja", "JP");

// AndroidとiOSでフォントが違う
const String kFontFamilyAndroid = ""; //空でいいの？
const String kFontFamilyCupertino = "Hiragino Sans";

final bool _android = defaultTargetPlatform == TargetPlatform.android;

final String _kFontFamily = _android
    ? kFontFamilyAndroid
    : kFontFamilyCupertino;

final TextTheme _whiteTextTheme = _android
    ? Typography.whiteMountainView
    : Typography.whiteCupertino;
final TextTheme _blackTextTheme = _android
    ? Typography.blackMountainView
    : Typography.blackCupertino;

// Flutter標準のTextThemeをベースにして
// fontFamilyとlocaleを設定したTextStyleとTextThemeで作る
final Typography kTypography = Typography(
  platform: defaultTargetPlatform,
  white: _textTheme(_whiteTextTheme),
  black: _textTheme(_blackTextTheme),
  englishLike: _textTheme(Typography.englishLike2014),
  dense: _textTheme(Typography.dense2014),
  tall: _textTheme(Typography.tall2014),
);

TextStyle _textStyle(TextStyle base) {
  return base.copyWith(
    fontFamily: _kFontFamily,
    locale: kLocale,
    textBaseline: TextBaseline.ideographic,
  );
}

TextTheme _textTheme(TextTheme base) {
  return base.copyWith(

    headline1: _textStyle(base.headline1!),
    headline2: _textStyle(base.headline2!),
    headline3: _textStyle(base.headline3!),
    headline4: _textStyle(base.headline4!),
    // headline: _textStyle(base.headline),
    subtitle1: _textStyle(base.subtitle1!),
    subtitle2: _textStyle(base.subtitle2!),


    // title: _textStyle(base.title),
    // subhead: _textStyle(base.subhead),


    bodyText1: _textStyle(base.bodyText1!),
    bodyText2: _textStyle(base.bodyText2!),


    caption: _textStyle(base.caption!),
    button: _textStyle(base.button!),
    overline: _textStyle(base.overline!),
  );
}