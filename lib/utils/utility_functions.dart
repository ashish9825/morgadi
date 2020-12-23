import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as customTab;

class UtilityFunction {
  Widget loadingIndicator(double size, double borderWidth, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRipple(
            color: color,
            size: size,
            borderWidth: borderWidth,
          ),
        ],
      ),
    );
  }

  launchWhatsapp(String text) async {
    final link = WhatsAppUnilink(phoneNumber: '+918827429035', text: '$text');
    await launch('$link');
  }

  morgadiBottomSheet(BuildContext context, String heading,
      List<Widget> sections, double headingSize) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext bc) {
        return Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 24,
            ),
            child: Wrap(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        heading,
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: headingSize),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFF7F98),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 4,
                        width: 20,
                      ),
                    ],
                  ),
                ),
                Wrap(
                  children: sections,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  launchUrl(BuildContext context, String url) async {
    try {
      await customTab.launch(
        url,
        option: customTab.CustomTabsOption(
          toolbarColor: Colors.black,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          // or user defined animation.
          animation: customTab.CustomTabsAnimation(
            startEnter: 'slide_up',
            startExit: 'android:anim/fade_out',
            endEnter: 'android:anim/fade_in',
            endExit: 'slide_down',
          ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
