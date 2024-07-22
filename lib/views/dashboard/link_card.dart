import 'package:attach_club/constants.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import 'dashboard_bottom_sheet.dart';

class LinkCard extends StatelessWidget {
  final Widget prefix;
  final String title;
  final String grp;
  const LinkCard({
    super.key,
    required this.grp,
    required this.prefix,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        if(title == "Share on other platforms" && grp == "CONNECTED USER"){
           String text = "${GlobalVariable.metaData.message!.replaceAll("newline ", "\n").replaceAll("#name", GlobalVariable.userData.name)} \n ${GlobalVariable.metaData.webURL! + GlobalVariable.userData.username}";
           Share.share(text);
        }
        else if(grp == "CONNECTED USER"){
          showDashboardBottomSheet(context); 
        }
        else{
           Navigator.pushNamed(context, "/settings/detailedAnalytics");
        }
      },

      child: Card(
        margin: EdgeInsets.zero,
        color:   grp == "CONNECTED USER" ? const Color(0xFFFFD16A): const Color(0xFF26293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 0.07725321888 * height,
          width: grp == "CONNECTED USER" ? 0.41 * width : 0.4 * width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                prefix,
                const SizedBox(
                  width: 6,
                ),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: title,
                      style:  TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: grp == "CONNECTED USER" ? Colors.black: primaryTextColor,
                      ),
                    ),
                  ),
                ),
                
                   SizedBox(
                    width: 15,
                    height: 15,
                    child: SvgPicture.asset(
                      "assets/svg/arrow_up_right.svg",
                      width: 15,
                      height: 15,
                      colorFilter: ColorFilter.mode(
                         grp == "CONNECTED USER" ? Colors.black : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
