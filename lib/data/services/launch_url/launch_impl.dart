import 'package:login_and_registration/data/services/launch_url/launch_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchServiceImpl implements LaunchService {
  @override
  Future<void> launchUrlInApp(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Future<void> launchInWebViewOrVC(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url in WebView');
    }
  }

  @override
  Future<void> launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url in browser');
    }
  }
}
