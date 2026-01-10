// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile/core/services/cache_service.dart';
import 'package:user_profile/core/services/connectivity_service.dart';
import 'package:user_profile/core/services/dio_client.dart';
import 'package:user_profile/core/services/user_service.dart';
import 'package:user_profile/core/providers/user_provider.dart';
import 'package:user_profile/ui/screens/user_list_screen.dart';
import 'package:user_profile/ui/theme/app_theme.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('User list screen loads correctly', (WidgetTester tester) async {
    // Setup SharedPreferences mock
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Create services
    final dioClient = DioClient();
    final cacheService = CacheService(prefs: prefs);
    final connectivityService = ConnectivityService();
    final userService = UserService(dioClient: dioClient);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UserProvider(
          userService: userService,
          cacheService: cacheService,
          connectivityService: connectivityService,
        ),
        child: MaterialApp(
          title: AppStrings.appName,
          theme: AppTheme.lightTheme,
          home: const UserListScreen(),
        ),
      ),
    );

    // Verify that the app bar title is displayed
    expect(find.text(AppStrings.userListTitle), findsOneWidget);

    // Verify that the search bar is present
    expect(find.byType(TextField), findsOneWidget);

    // Wait for initial loading
    await tester.pump();
  });
}
