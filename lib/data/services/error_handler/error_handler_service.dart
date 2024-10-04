abstract class ErrorHandlerService {
  Future<void> recordError(
    error,
    StackTrace stackTrace, {
    context,
  });
}
