import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile/core/services/cache_service.dart';
import 'package:user_profile/core/services/connectivity_service.dart';
import 'package:user_profile/core/services/dio_client.dart';
import 'package:user_profile/core/services/user_service.dart';
import 'package:user_profile/core/providers/user_provider.dart';

class DependencyInjection {
  DependencyInjection._();

  // Create all service instances
  static Future<List<SingleChildWidget>> getProviders() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    // Create service instances
    final dioClient = DioClient();
    final cacheService = CacheService(prefs: sharedPreferences);
    final connectivityService = ConnectivityService();
    final userService = UserService(dioClient: dioClient);

    return [
      // Provide UserProvider with all its dependencies
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(
          userService: userService,
          cacheService: cacheService,
          connectivityService: connectivityService,
        ),
      ),
    ];
  }
}
