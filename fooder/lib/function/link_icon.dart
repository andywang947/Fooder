import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fooder/constants.dart';

class LinkIconButton extends StatelessWidget {
  final String url;

  const LinkIconButton({super.key, required this.url});

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw '無法開啟網址： $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.link, color: AppColors.linkTextColor),
      onPressed: _launchUrl,
    );
  }
}
