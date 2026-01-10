import 'user_model.dart';

class UsersResponse {
  final int page;
  final int perPage;
  final String seed;
  final List<UserModel> users;

  UsersResponse({
    required this.page,
    required this.perPage,
    required this.users,
    this.seed = '',
  });

  bool get hasMorePages => users.isNotEmpty;

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    final info = json['info'] as Map<String, dynamic>? ?? {};
    final results = json['results'] as List<dynamic>? ?? [];

    return UsersResponse(
      page: info['page'] as int? ?? 1,
      perPage: info['results'] as int? ?? 10,
      seed: info['seed'] as String? ?? '',
      users: results
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert UsersResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'info': {
        'page': page,
        'results': perPage,
        'seed': seed,
      },
      'results': users.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'UsersResponse(page: $page, perPage: $perPage, seed: $seed, users: ${users.length})';
  }
}
