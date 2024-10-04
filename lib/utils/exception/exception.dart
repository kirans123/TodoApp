class RepoException implements Exception {
  final String message;

  RepoException(this.message);

  @override
  String toString() => message; // Ensure `toString()` returns the message
}
