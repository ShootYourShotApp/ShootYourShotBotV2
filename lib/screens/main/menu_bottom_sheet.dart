import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/functions/launchEmail.dart';
import '../../utils/functions/open_url.dart';

void openMenuBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(40), topLeft: Radius.circular(40)),
    ),
    context: context,
    builder: (BuildContext context) {
      return MenuBottomSheet();
    },
  );
}

class MenuBottomSheet extends StatefulWidget {
  const MenuBottomSheet({super.key});

  @override
  State<MenuBottomSheet> createState() => _MenuBottomSheetState();
}

class _MenuBottomSheetState extends State<MenuBottomSheet> {

  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  final String referralCode = 'U4Q58R';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: width,
          decoration: const BoxDecoration(
            color: Color(0xff232323),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MenuItemWidget(
                    iconPath: 'assets/images/crown-icon.png',
                    title: 'Get Shot Your Shot Bot Pro'),
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xff434343).withValues(alpha: 0.44)),
                const SizedBox(height: 24),
                MenuItemWidget(
                    onTap: (){
                      openUrl(
                          androidUrl: "https://play.google.com/store/apps/details?id=com.sysbot.app.sysbot",
                          iosUrl: "https://apps.apple.com/us/app/shoot-your-shot-ai-wingman/id6615074058"
                      );
                    },
                    iconPath: 'assets/images/star-icon.png',
                    title: 'Rate Us',
                    iconSize: 19),
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xff434343).withValues(alpha: 0.44)),
                const SizedBox(height: 24),
                MenuItemWidget(
                    onTap: (){
                      Share.share('Download the app and use my referral code "$referralCode"');
                    },
                    iconPath: 'assets/images/ticket-icon.png',
                    title: 'Share my Referral Code',
                    iconSize: 26),
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xff434343).withValues(alpha: 0.44)),
                const SizedBox(height: 24),
                MenuItemWidget(
                    onTap: () async{
                      await getAppVersion();
                      launchEmail(
                          supportEmail: "support@shootyourshot.ai",
                          subject: "Shoot Your Shot Support",
                          body: "\n\nUser ID: 01\nApp Version: $versionName"
                      );
                    },
                    iconPath: 'assets/images/email-icon.png',
                    title: 'Contact Support',
                    iconSize: 27),
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xff434343).withValues(alpha: 0.44)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: (){
                          openUrl(
                              androidUrl: "http://shootyourshot.ai/privacy",
                              iosUrl: "http://shootyourshot.ai/privacy"
                          );
                        },
                        child: Text('Privacy', style: TextStyle(fontFamily: 'SFProRound', fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white))),
                    GestureDetector(
                        onTap: (){
                          openUrl(
                              androidUrl: "http://shootyourshot.ai/terms",
                              iosUrl: "http://shootyourshot.ai/terms"
                          );
                        },
                        child: Text('Terms', style: TextStyle(fontFamily: 'SFProRound', fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String versionName = '';

  Future<void> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        versionName = packageInfo.version;
        debugPrint(versionName);
      });
    } catch (e) {
      setState(() {
        versionName = 'Unknown';
        debugPrint(versionName);
      });
    }
  }

}

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget(
      {super.key, required this.iconPath, required this.title, this.iconSize, this.onTap});

  final String iconPath;
  final double? iconSize;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 16, bottom: 24),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(iconPath, width: iconSize ?? 25),
            const SizedBox(width: 20),
            Text(title,
                style: TextStyle(
                    fontFamily: 'SFProRound',
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 16))
          ],
        ),
      ),
    );
  }
}
