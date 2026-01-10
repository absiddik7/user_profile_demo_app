
class AppUtils {
  AppUtils._();

  static String sanitizeSearchQuery(String query) {
    // Remove leading/trailing whitespace
    String sanitized = query.trim();
    sanitized = sanitized.replaceAll(RegExp(r'[^\w\s\-\.]'), '');
    sanitized = sanitized.replaceAll(RegExp(r'\s+'), ' ');

    return sanitized;
  }

  // Case-insensitive search
  static bool matchesSearch(String name, String query) {
    if (query.isEmpty) return true;

    final sanitizedQuery = sanitizeSearchQuery(query).toLowerCase();
    final sanitizedName = name.toLowerCase();

    return sanitizedName.contains(sanitizedQuery);
  }

  // Format error message for display
  static String formatErrorMessage(dynamic error) {
    if (error is String) {
      return error;
    }
    return error.toString();
  }

  // Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }

  // Get initials from name
  static String getInitials(String name) {
    if (name.isEmpty) return '';

    final nameParts = name.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return nameParts[0][0].toUpperCase();
  }
}
