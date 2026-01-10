import 'package:user_profile/core/constants/app_constants.dart';
import 'package:user_profile/core/models/user_model.dart';
import 'package:user_profile/core/models/users_response.dart';
import 'dio_client.dart';


class UserService {
  final DioClient _dioClient;

  UserService({required DioClient dioClient}) : _dioClient = dioClient;

  // Fetch users with pagination
  Future<UsersResponse> getUsers({
    int page = 1,
    int perPage = AppConstants.itemsPerPage,
  }) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        AppConstants.usersEndpoint,
        queryParameters: {
          'page': page,
          'results': perPage,
          'seed': AppConstants.apiSeed,
        },
      );

      if (response.data != null) {
        return UsersResponse.fromJson(response.data!);
      }

      return UsersResponse(
        page: page,
        perPage: perPage,
        users: [],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Fetch a single user by seed and index
  Future<UserModel?> getUserBySeed(String seed) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        AppConstants.usersEndpoint,
        queryParameters: {
          'seed': seed,
          'results': 1,
        },
      );

      if (response.data != null) {
        final results = response.data!['results'] as List<dynamic>?;
        if (results != null && results.isNotEmpty) {
          return UserModel.fromJson(results.first as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}
