
import 'package:attach_club/bloc/dashboard/dashboard_bloc.dart' as dbloc;
import 'package:attach_club/bloc/search_connections/Search_provider.dart';
import 'package:attach_club/bloc/search_connections/search_connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/models/search_user_data.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/search_connections/search_connections_text_field.dart';
import 'package:attach_club/views/search_connections/search_profile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchConnections extends StatefulWidget {
  const SearchConnections({super.key,});

  @override
  State<SearchConnections> createState() => _SearchConnectionsState();
}

class _SearchConnectionsState extends State<SearchConnections> with AutomaticKeepAliveClientMixin {
   @override
  bool get wantKeepAlive => true;
  final controller = TextEditingController();
  
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
     scrollController.removeListener(_scrollListener);
     scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       scrollController.addListener(_scrollListener);
    });
    super.initState();
  }

  void _scrollListener() {

    if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      setState(() {
       animationController.reverse();
      });
    } else if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      setState(() {
       animationController.forward();
      });
     }
  }

  List<SearchUserData> removeLists(List<SearchUserData> list1, List<SearchUserData> list2) {

   Set<String> set2 = list2.map((item) =>item.userData.uid! ).toSet();
   List<SearchUserData> listcopy = List<SearchUserData>.from(list1);
   // Remove items from the first list where the ID is in the second list
  listcopy.removeWhere((item) => set2.contains(item.userData.uid));
  return listcopy;
}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Consumer<ChangeScreenProvider>(
          builder: (context, model, child) {
            return BlocConsumer<SearchConnectionsBloc, SearchConnectionsState>(
              listener: (context, state) {
                if (state is ShowSnackBar) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final list = removeLists(context.read<dbloc.DashboardBloc>().suggestedProfile, context.read<SearchConnectionsBloc>().resultsList);

                if(state is SearchConnectionsLoading || state is ConnectionRequestLoading){
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      width: width,
                      color: const Color(0xFF26293B),
                      child: SearchConnectionsTextField(
                        controller: controller,
                      ),
                    ),
                     const SizedBox(height: 10.0,),
                     const Padding(
                       padding:  EdgeInsets.symmetric(
                               horizontal: horizontalPadding,
                              ),
                       child:  Align(
                         alignment: Alignment.centerLeft,
                        child: Text("Recent Searches")),
                     ),
                     const SizedBox(height: 10.0,),

                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.symmetric(
                               horizontal: horizontalPadding,
                              ),
                         child: CustomScrollView(
                            controller: scrollController,
                            slivers: [
                                SliverFixedExtentList(
                                itemExtent: context.read<SearchConnectionsBloc>().resultsList.isEmpty? 100 : 188,
                                delegate: SliverChildListDelegate(
                                [
                                  if(context.read<SearchConnectionsBloc>().resultsList.isEmpty)
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("No recent search found", style: TextStyle(color: Color(0xFF94969F)),),
                                      SizedBox(width: 4.0,),
            
                                      Icon(Icons.search, color: Color(0xFF94969F), size: 18.0,)
                                    ],
                                  ),

                                  if(context.read<SearchConnectionsBloc>().resultsList.isNotEmpty)
                                  for (var i = 0 ; i < context.read<SearchConnectionsBloc>().resultsList.length;i++)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: (i == 0) ? 0.02682403433 * height : 0,
                                      bottom: (i == list.length - 1)
                                          ? paddingDueToNav
                                          : 0,
                                    ),
                                  child: SearchProfileCard(
                                    key: ValueKey(context.read<SearchConnectionsBloc>().resultsList[i].userData.uid),
                                    userData: context.read<SearchConnectionsBloc>().resultsList[i].userData,
                                  ),
                                  )
                                ]
                              ),
                                ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, i) {
                                   if(i==0){
                                     return Column(
                                       children: [
                                         const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Suggested Profiles")),
                                         Padding(
                                          padding: EdgeInsets.only(
                                            top: (i == 0) ? 0.02682403433 * height : 0,
                                            bottom: (i == list.length - 1)
                                                ? paddingDueToNav
                                                : 0,
                                          ),
                                          child: SearchProfileCard(
                                            key: ValueKey(i),
                                            userData: list[i].userData,
                                          ),
                                                                             ),
                                       ],
                                     );
                                   }
                                   else{
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: (i == 0) ? 0.02682403433 * height : 0,
                                        bottom: (i == list.length - 1)
                                            ? paddingDueToNav
                                            : 0,
                                      ),
                                      child: SearchProfileCard(
                                        key: ValueKey(i),
                                        userData: list[i].userData,
                                      ),
                                    );
                                   }
                                  },
                                  childCount: list.length,

                                ),
                              ),

                            ],
                          ),
                       ),
                     ),

                    // Expanded(
                    //         child: list.isEmpty? const Center(child: Text("No Data Found"),):
                    //         ListView.builder(


                    //           controller: scrollController,
                    //           itemCount: list.length,
                    //           itemBuilder: (context, i) {
                    //             if( context.read<SearchConnectionsBloc>().resultsList.indexWhere((element) =>element.uid == list[i].uid)!=-1){

                    //             }


                    //           },
                    //         ),
                    //       ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final currentUser = FirebaseAuth.instance.currentUser;
                    //     final db = FirebaseFirestore.instance;
                    //     final request = ConnectionRequest(
                    //       phoneNo: phoneController.text,
                    //       status: "Received",
                    //       updateTime: "5 April 2024 at 17:12:56 UTC+5:30",
                    //       uid: fromController.text,
                    //     );
                    //     if (currentUser != null) {
                    //       await db
                    //           .collection("users")
                    //           .doc(currentUser.uid)
                    //           .collection("requests")
                    //           .doc(fromController.text)
                    //           .set(request.toMap());
                    //
                    //       final sentRequest = ConnectionRequest(
                    //         phoneNo: phoneController.text,
                    //         status: "Sent",
                    //         updateTime: "5 April 2024 at 17:12:56 UTC+5:30",
                    //         uid: currentUser.uid,
                    //       );
                    //       await db
                    //           .collection("users")
                    //           .doc(fromController.text)
                    //           .collection("requests")
                    //           .doc(currentUser.uid)
                    //           .set(sentRequest.toMap());
                    //     }
                    //   },
                    //   child: const Text(
                    //     "Send Request",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ],
                );
              },
            );
          }
        ),
      ),
    );
  }
}
