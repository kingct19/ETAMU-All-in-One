import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchAppOrStore({
  required String androidPackageName,
  required String iosAppStoreUrl,
}) async {
  if (Platform.isAndroid) {
    final intent = AndroidIntent(
      action: 'action_view',
      package: androidPackageName,
    );
    try {
      await intent.launch();
    } catch (e) {
      final Uri playStoreUri =
          Uri.parse("https://play.google.com/store/apps/details?id=$androidPackageName");
      await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
    }
  } else if (Platform.isIOS) {
    final Uri appStoreUri = Uri.parse(iosAppStoreUrl);
    await launchUrl(appStoreUri, mode: LaunchMode.externalApplication);
  }
}
