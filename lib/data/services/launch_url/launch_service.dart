abstract class LaunchService {
  Future<void> launchUrlInApp(String url);
  Future<void> launchInWebViewOrVC(String url);
  Future<void> launchInBrowser(String url);
}
