import 'user_model.dart';

class UsersResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> users;

  UsersResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });

  bool get hasMorePages => page < totalPages;

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];

    return UsersResponse(
      page: json['page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 0,
      users: data
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert UsersResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': users.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'UsersResponse(page: $page, perPage: $perPage, total: $total, totalPages: $totalPages, users: ${users.length})';
  }
}
