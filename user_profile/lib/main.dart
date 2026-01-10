import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:user_profile/di/dependency_injection.dart';
import 'package:user_profile/ui/screens/user_list_screen.dart';
import 'package:user_profile/ui/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Get providers from dependency injection
  final providers = await DependencyInjection.getProviders();

  // Run the app
  runApp(UserProfileApp(providers: providers));
}

// Main application widget
class UserProfileApp extends StatelessWidget {
  final List<SingleChildWidget> providers;

  const UserProfileApp({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
