
import 'package:attach_club/bloc/search_connections/search_connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/views/search_connections/search_connections_text_field.dart';
import 'package:attach_club/views/search_connections/search_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchConnections extends StatefulWidget {
  const SearchConnections({super.key});

  @override
  State<SearchConnections> createState() => _SearchConnectionsState();
}

class _SearchConnectionsState extends State<SearchConnections> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SearchConnectionsBloc, SearchConnectionsState>(
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
            final list = context.read<SearchConnectionsBloc>().resultsList;
            return Column(
              children: [
                Container(
                  width: width,
                  color: const Color(0xFF26293B),
                  child: SearchConnectionsTextField(
                    controller: controller,
                  ),
                ),
                Expanded(
                  child: (state is SearchConnectionsLoading)
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 0.02682403433 * height),
                                for (var i = 0; i < list.length; i++)
                                  SearchProfileCard(
                                    userData: list[i],
                                  ),
                                const SizedBox(height: paddingDueToNav),
                              ],
                            ),
                          ),
                        ),
                ),
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
        ),
      ),
    );
  }
}
