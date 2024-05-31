import 'package:attach_club/constants.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/views/dashboard/link_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class DashboardShimmer extends StatefulWidget {
  
  const DashboardShimmer({super.key});

  @override
  State<DashboardShimmer> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardShimmer>  {
  
  
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return  Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
            baseColor:  Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.02575107296 * height),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Container(
              width: double.infinity,
              height: 0.160944206 * height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  height: 0.160944206 * height,
                  color: Colors.white,
                )
                
                  
              ),
            ),
          ),
          SizedBox(height: 0.02575107296 * height),
           Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Container(
                  width: 100.0,
                  height: 10,
                  color: Colors.white,
                )
          ),
          SizedBox(height: 0.01931330472 * height),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 16,
              children: [
                // for (var i in analyticsData)
                SizedBox(
                  width: horizontalPadding - 16,
                ),
                LinkCard(
                  grp: "ANALYTICS",
                  prefix: Text(
                    "",
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  title: "",
                ),
                 LinkCard(
                  grp: "ANALYTICS",
                  prefix: Text(
                    "",
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  title: "",
                ),
                LinkCard(
                  grp: "ANALYTICS",
                  prefix: Text(
                    "",
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  title: "",
                ),
              ],
            ),
          ),
          SizedBox(height: 0.02575107296 * height),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Container(
                  width: 100.0,
                  height: 10,
                  color: Colors.white,
                )
          ),
          SizedBox(height: 0.01931330472 * height),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 16,
                children: [
                  
                    LinkCard(
                      grp: "CONNECTED USER",
                      prefix: Text(
                    "",
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                      title: "",
                    ),
                     LinkCard(
                      grp: "CONNECTED USER",
                      prefix: Text(
                    "",
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                      title: "",
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 0.02575107296 * height),
           Padding(
            padding: const  EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.0,
                  height: 10,
                  color: Colors.white,
                )
           
              ],
            ),
          ),
          SizedBox(height: 0.01716738197 * height),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 12,
              children: [
                const SizedBox(width: horizontalPadding - 12),
                
                    Container(
                       height: 200.0,
                       width: 0.39069 * width,
                       color: Colors.white,
                    ),
                    Container(
                       height: 200.0,
                       width: 0.39069 * width,
                       color: Colors.white,
                    ),
                    Container(
                       height: 200.0,
                       width: 0.39069 * width,
                       color: Colors.white,
                    )
              ],
            ),
          ),
          SizedBox(height: 0.02575107296 * height),
          const SizedBox(height: paddingDueToNav)
        ],
      ),
    );
          
  }
}
