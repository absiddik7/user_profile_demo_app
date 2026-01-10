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
          'per_page': perPage,
        },
      );

      if (response.data != null) {
        return UsersResponse.fromJson(response.data!);
      }

      return UsersResponse(
        page: page,
        perPage: perPage,
        total: 0,
        totalPages: 0,
        users: [],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Fetch a single user by ID
  Future<UserModel?> getUserById(int id) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '${AppConstants.usersEndpoint}/$id',
      );

      if (response.data != null) {
        final data = response.data!['data'] as Map<String, dynamic>?;
        if (data != null) {
          return UserModel.fromJson(data);
        }
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}
