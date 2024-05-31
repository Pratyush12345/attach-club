import 'dart:math';
import 'dart:developer' as developer;
import 'package:attach_club/bloc/connections/connections_bloc.dart' as cbloc;
import 'package:attach_club/bloc/profile/profile_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/divider.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/profile/product_card_with_enquiry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/components/rating.dart';
import '../../core/components/text_field.dart';

class ProfileShimmerLoader extends StatefulWidget {
  
  const ProfileShimmerLoader({
    super.key,
    });

  @override
  State<ProfileShimmerLoader> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileShimmerLoader>  {
  // final nameController = TextEditingController();
  
  
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // return Scaffold();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(context.read<ProfileBloc>().userData.name),
      //   centerTitle: false,
      // ),
      body:  Shimmer.fromColors(
            direction: ShimmerDirection.ltr,
            baseColor:  Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  SizedBox(
                    width: double.infinity,
                    height: 0.3841201717 * height,
                    child: Stack(
                      children: [
                        
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xFF181B2F),
                              ],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.darken,
                          child: SizedBox(
                            width: double.infinity,
                            height: 0.3240343348 * height,
                            child: 
                            Container(
                                height: 0.3240343348 * height,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            //child: _getBannerImage(userData),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white,),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 147,
                            height: 147,
                            decoration: BoxDecoration(
                              border:  Border.all(
                                color: Colors.white,
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(73.5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(73.5),
                              child :Container(
                                height: 147,
                                width: 147,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                   SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                           Container(
                          height: 8.0,
                          width: 100.0,
                          color: Colors.white,
                         ),
                         const SizedBox(height: 5),
                         
                          Container(
                          height: 10.0,
                          width: 100.0,
                          color: Colors.white,
                         ),

                          Column(
                            children: [
                               const SizedBox(height: 16),
                               const  SizedBox(height: 4),
                               Container(
                                   height: 10.0,
                                  width: 100.0,
                                  color: Colors.white,
                                ),
                               Container(
                                height: 10.0,
                                width: 100.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                              
                               CustomButton(
                                onPressed: (){},
                                
                                            
            
                                  
                                title:  "",
                                buttonWidth: 0.4179069767,
                               
                              ),
                              const SizedBox(width: 18.0,),
                              CustomButton(
                                onPressed: (){},
                                
                                            
            
                                  
                                title:  "",
                                buttonWidth: 0.4179069767,
                               
                              ),
                          ],
                        ),
                        
                          Column(
                            children: [
                              const CustomDivider(),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 0.06944444444 * width,
                                  runSpacing: 12,
                                  children: [
                                    for (var i in context
                                        .read<ProfileBloc>()
                                        .socialLinksList)
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: SizedBox(
                                          width: 74,
                                          height: 74,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 11.0,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  (i.socialMedia.imageUrl
                                                          .isNotEmpty)
                                                      ? i.socialMedia.imageUrl
                                                      : "assets/svg/whatsapp.svg",
                                                  width: 26,
                                                  height: 26,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 6.0,
                                                  ),
                                                  child: Text(
                                                    i.title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        const CustomDivider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 10.0,
                                width: 100.0,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                            Container(
                                height: 4.0,
                                width: 100.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 10.0,
                                      width: 100.0,
                                      color: Colors.white,
                                    ),
                                   
                                  ],
                                ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: width,
                                height: 0.3805150215 * height,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, i) {
                                    
                                      return const Padding(
                                        padding:  EdgeInsets.only(
                                          right: 25.0,
                                        ),
                                      );
                                  }  
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                    
                      ],
                    ),
                  )
                ],
              ),
            ),
           )
          );
      
  }
}

