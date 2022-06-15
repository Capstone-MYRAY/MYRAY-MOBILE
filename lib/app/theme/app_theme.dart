import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class AppTheme {
  static double scaleFactor = 1;

  static double textScaleFactor(double value) {
    return Get.textScaleFactor * value;
  }

  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryColor,
    Color? secondaryColor,
    Color? divider,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    Color? textColor,
    required Color errorColor,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;
    return ThemeData(
      brightness: brightness,
      canvasColor: background,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1.0,
        thickness: 1.0,
      ),
      cardColor: cardBackground,
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      backgroundColor: background,
      errorColor: errorColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        primaryContainer: primaryColor,
        secondary: secondaryColor!,
        secondaryContainer: secondaryColor,
        surface: textColor!,
        background: background,
        error: errorColor,
        onPrimary: buttonText,
        onSecondary: buttonText,
        onSurface: textColor,
        onBackground: buttonText,
        onError: buttonText,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: primaryColor,
        selectionHandleColor: primaryColor,
        cursorColor: primaryColor,
      ),
      appBarTheme: AppBarTheme(
        color: cardBackground,
        elevation: 2.0,
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        titleTextStyle: baseTextTheme.headline4!.copyWith(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: textScaleFactor(20.0),
        ),
        iconTheme: IconThemeData(
          color: secondaryColor,
        ),
        // titleTextStyle: baseTextTheme.headline6,
        actionsIconTheme: IconThemeData(
          color: secondaryColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: secondaryColor,
        size: 20,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return primaryColor;
            }

            if (states.contains(MaterialState.disabled)) {
              return divider;
            }

            return null; //use component default
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
          ),
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(32)),
          textStyle: MaterialStateProperty.all(
            baseTextTheme.bodyText2!.copyWith(
              color: buttonText,
              fontSize: textScaleFactor(16.0),
            ),
          ),
          elevation: MaterialStateProperty.all(1.0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(primaryColor),
          overlayColor: MaterialStateProperty.all(
            primaryColor.withOpacity(0.2),
          ),
          minimumSize: MaterialStateProperty.all(const Size(100, 32)),
          textStyle: MaterialStateProperty.all(
            baseTextTheme.bodyText2!.copyWith(
              fontSize: textScaleFactor(16.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              width: 2.0,
              color: primaryColor,
              style: BorderStyle.solid,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: cardBackground,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        focusColor: primaryColor,
        errorStyle: TextStyle(color: errorColor),
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: textScaleFactor(16.0),
          color: primaryColor,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          color: disabled,
          fontSize: textScaleFactor(13.0),
        ),
        iconColor: secondaryColor,
        prefixIconColor: secondaryColor,
        suffixIconColor: secondaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: secondaryColor,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: disabled!,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 1.0,
        backgroundColor: cardBackground,
        selectedItemColor: primaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: textColor.withOpacity(0.5),
        selectedIconTheme: IconThemeData(
          color: primaryColor,
          size: 32,
        ),
        selectedLabelStyle: baseTextTheme.subtitle2!.copyWith(
          fontSize: 13.0,
          color: primaryColor,
          fontWeight: FontWeight.w700,
        ),
        unselectedIconTheme: IconThemeData(
          color: textColor.withOpacity(0.5),
          size: 32.0,
        ),
        unselectedLabelStyle: baseTextTheme.subtitle2!.copyWith(
          fontSize: 13.0,
          color: textColor.withOpacity(0.5),
          fontWeight: FontWeight.normal,
        ),
      ),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        headline1: baseTextTheme.headline1!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: textScaleFactor(30.0),
        ),
        headline2: baseTextTheme.headline2!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: textScaleFactor(26.0),
        ),
        headline3: baseTextTheme.headline3!.copyWith(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: textScaleFactor(24.0),
        ),
        headline4: baseTextTheme.headline4!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: textScaleFactor(20.0),
        ),
        headline5: baseTextTheme.headline5!.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: textScaleFactor(18.0),
        ),
        headline6: baseTextTheme.headline6!.copyWith(
          color: primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: textScaleFactor(16.0),
        ),
        bodyText1: baseTextTheme.bodyText1!.copyWith(
          color: textColor,
          fontSize: textScaleFactor(15.0),
          fontWeight: FontWeight.w500,
        ),
        bodyText2: baseTextTheme.bodyText2!.copyWith(
          color: textColor,
          fontSize: textScaleFactor(13.0),
        ),
        button: baseTextTheme.button!.copyWith(
          color: cardBackground,
          fontSize: textScaleFactor(16.0),
        ),
        caption: baseTextTheme.caption!.copyWith(
          color: disabled,
          fontSize: textScaleFactor(13.0),
          fontWeight: FontWeight.w400,
        ),
        overline: baseTextTheme.overline!.copyWith(
          color: textColor,
          fontSize: textScaleFactor(11.0),
          fontWeight: FontWeight.w500,
        ),
        subtitle1: baseTextTheme.subtitle1!.copyWith(
          color: textColor,
          fontSize: 15.0,
        ),
        subtitle2: baseTextTheme.subtitle2!.copyWith(
          color: textColor,
          fontSize: 11.0,
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: AppColors.backgroundColor,
        cardBackground: AppColors.white,
        primaryColor: AppColors.primaryColor,
        secondaryColor: AppColors.iconColor,
        divider: AppColors.cancelColor,
        buttonText: AppColors.white,
        disabled: AppColors.grey,
        errorColor: AppColors.errorColor,
        textColor: AppColors.black,
      );
}
