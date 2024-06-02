import 'package:attach_club/models/greeting.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GreetingSmallGrid extends StatefulWidget {
  final String imageurl;
  const GreetingSmallGrid({super.key, required this.imageurl});

  @override
  State<GreetingSmallGrid> createState() => _GreetingSmallGridState();
}

class _GreetingSmallGridState extends State<GreetingSmallGrid> with AutomaticKeepAliveClientMixin<GreetingSmallGrid>{
  
   @override
  bool get wantKeepAlive => true;
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        cacheKey:  widget.imageurl,
                                         imageUrl: widget.imageurl,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                              decoration: BoxDecoration(
                                              image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                              ),
                                            ));
                                          },
                                        placeholder: (context, url) {
                                          return Shimmer.fromColors(
                                            direction: ShimmerDirection.ltr,
                                              baseColor:  Colors.grey[800]!,
                                              highlightColor: Colors.grey[600]!,
                                        
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                       
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
    
}  
}                 
                     
