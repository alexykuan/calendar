import 'package:flutter/material.dart';

// Bilibili M3 浅色主题
final lightTheme = ThemeData(
  useMaterial3: true, // 启用 Material Design 3
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFF729D), // B站品牌粉（核心种子色）
    brightness: Brightness.light,
    // 核心品牌色
    primary: const Color(0xFFFF729D), // B站主粉（按钮/选中态）
    primaryContainer: const Color(0xFFFFD6E3), // 主色容器（浅粉背景）
    onPrimary: Colors.white, // 主色上的文字/图标
    onPrimaryContainer: const Color(0xFF930039), // 主色容器文字
    secondary: const Color(0xFF00A1D6), // B站辅蓝（链接/次要操作）
    secondaryContainer: const Color(0xFFD1ECF7), // 辅色容器（浅蓝背景）
    onSecondary: Colors.white, // 辅色上的文字/图标
    onSecondaryContainer: const Color(0xFF003347), // 辅色容器文字
    tertiary: const Color(0xFFFF9D00), // 三级色（橙色/提醒/直播标识）
    tertiaryContainer: const Color(0xFFFFE0B2), // 三级色容器
    onTertiary: Colors.white, // 三级色上的文字
    onTertiaryContainer: const Color(0xFF3D2700), // 三级色容器文字
    // 功能色
    error: const Color(0xFFFF4D4F), // 错误色（B站红色）
    errorContainer: const Color(0xFFFFD9D9), // 错误容器
    onError: Colors.white, // 错误色文字
    onErrorContainer: const Color(0xFF410002), // 错误容器文字
    // 中性色（背景/文字）
    surface: Colors.white, // 页面主背景
    surfaceVariant: const Color(0xFFF7F7F9), // 卡片/模块背景（B站浅灰）
    surfaceContainerHighest: const Color(0xFFF7F7F9),
    onSurface: const Color(0xFF18191C), // 主要文字（B站深灰）
    onSurfaceVariant: const Color(0xFF6D717A), // 次要文字（B站中灰）
    background: Colors.white, // 全局背景
    onBackground: const Color(0xFF18191C), // 背景文字
    outline: const Color(0xFFC9CDD4), // 边框/分隔线
    outlineVariant: const Color(0xFFE5E6EB), // 弱边框/次要分隔线
    shadow: const Color(0x1A000000), // 阴影色
  ),
  // 文本样式（贴合B站字体风格）
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: Color(0xFF18191C),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF18191C),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF18191C),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF18191C),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF6D717A),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF18191C),
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xFF6D717A),
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Color(0xFF6D717A),
    ),
  ),
  // 组件样式（贴合B站交互风格）
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent, // 移除M3默认的appBar tint
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFF18191C),
    ),
    iconTheme: IconThemeData(color: Color(0xFF18191C)),
    actionsIconTheme: IconThemeData(color: Color(0xFF18191C)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFFFF729D), // 选中态粉色
    unselectedItemColor: Color(0xFF6D717A), // 未选中灰色
    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF729D),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Color(0xFFFF729D)),
      foregroundColor: const Color(0xFFFF729D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
);

// Bilibili M3 深色主题
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFF729D),
    brightness: Brightness.dark,
    // 核心品牌色（深色模式提亮）
    primary: const Color(0xFFFF94B3), // 深色主粉
    primaryContainer: const Color(0xFFAD0046), // 深色主色容器
    onPrimary: const Color(0xFF18191C), // 主色文字（深色下改为黑色）
    onPrimaryContainer: const Color(0xFFFFD6E3), // 主色容器文字
    secondary: const Color(0xFF64CCF1), // 深色辅蓝
    secondaryContainer: const Color(0xFF005A7C), // 深色辅色容器
    onSecondary: const Color(0xFF18191C), // 辅色文字
    onSecondaryContainer: const Color(0xFFD1ECF7), // 辅色容器文字
    tertiary: const Color(0xFFFFC046), // 深色三级橙
    tertiaryContainer: const Color(0xFF805800), // 深色三级容器
    onTertiary: const Color(0xFF18191C), // 三级色文字
    onTertiaryContainer: const Color(0xFFFFE0B2), // 三级容器文字
    // 功能色
    error: const Color(0xFFFF7B7B), // 深色错误色
    errorContainer: const Color(0xFF93000A), // 深色错误容器
    onError: const Color(0xFF18191C), // 错误色文字
    onErrorContainer: const Color(0xFFFFD9D9), // 错误容器文字
    // 中性色（深色模式）
    surface: const Color(0xFF18191C), // B站深色背景
    surfaceVariant: const Color(0xFF212226), // 深色卡片背景
    surfaceContainerHighest: const Color(0xFF212226), // 深色卡片背景
    onSurface: const Color(0xFFF5F5F7), // 深色主要文字
    onSurfaceVariant: const Color(0xFFC9CDD4), // 深色次要文字
    background: const Color(0xFF18191C), // 深色全局背景
    onBackground: const Color(0xFFF5F5F7), // 深色背景文字
    outline: const Color(0xFF47484C), // 深色边框
    outlineVariant: const Color(0xFF2C2D31), // 深色弱边框
    shadow: const Color(0xFF000000), // 深色阴影
  ),
  // 文本样式（深色模式）
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: Color(0xFFF5F5F7),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFFF5F5F7),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFFF5F5F7),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFFF5F5F7),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFFC9CDD4),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFFF5F5F7),
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xFFC9CDD4),
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Color(0xFFC9CDD4),
    ),
  ),
  // 组件样式（深色模式）
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF18191C),
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFFF5F5F7),
    ),
    iconTheme: IconThemeData(color: Color(0xFFF5F5F7)),
    actionsIconTheme: IconThemeData(color: Color(0xFFF5F5F7)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF18191C),
    selectedItemColor: Color(0xFFFF94B3), // 深色选中粉
    unselectedItemColor: Color(0xFFC9CDD4), // 深色未选中灰
    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF94B3),
      foregroundColor: const Color(0xFF18191C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Color(0xFFFF94B3)),
      foregroundColor: const Color(0xFFFF94B3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
);
