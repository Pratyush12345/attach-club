import 'dart:math';
import 'dart:developer' as developer;
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

import '../../core/components/rating.dart';
import '../../core/components/text_field.dart';

class Profile extends StatefulWidget {
  final String? uid;

  const Profile({
    super.key,
    this.uid,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final nameController = TextEditingController();
  final feedbackController = TextEditingController();
  int selectedStars = 0;

  // UserData userData = UserData(username: '');

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileBloc>();
    developer.log(widget.uid.toString());
    if (widget.uid != bloc.uid ||
        bloc.lastUpdated == null ||
        bloc.lastUpdated!.difference(DateTime.now()).inMinutes > 2) {
      if (widget.uid != null) {
        bloc.add(GetUserData(uid: widget.uid));
      } else {
        bloc.userData = context.read<UserDataNotifier>().userData;
        bloc.uid = null;
        bloc.lastUpdated = DateTime.now();
        bloc.add(const GetUserData());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // return Scaffold();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<ProfileBloc>().userData.name),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UserDataUpdated) {
              // userData = state.userData;
              context.read<UserDataNotifier>().updateUserData(state.userData);
            }
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            // if (state is OtherUserDataUpdated) {
            //   userData = state.userData;
            // }
          },
          builder: (context, state) {
            final userData = context.read<ProfileBloc>().userData;
            if (userData.username.isEmpty || state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
            final bloc = context.read<ProfileBloc>();
            return SingleChildScrollView(
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
                            child: _getBannerImage(userData),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 147,
                            height: 147,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(73.5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(73.5),
                              child: _getProfileImage(userData),
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
                        Text(
                          userData.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (userData.isBasicDetailEnabled)
                          Text(
                            userData.profession,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: primaryTextColor,
                            ),
                          ),
                        if (userData.isReviewEnabled)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              Rating(
                                selected: bloc.rating,
                                alignment: MainAxisAlignment.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${bloc.rating} stars out of 5",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${bloc.reviewCount} reviews",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )
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
                          mainAxisAlignment: (userData.phoneNo.isNotEmpty &&
                                  userData.isBasicDetailEnabled)
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            if (userData.phoneNo.isNotEmpty &&
                                userData.isBasicDetailEnabled)
                              CustomButton(
                                onPressed: () {},
                                title: "Save Contact",
                                assetName: "assets/svg/arrow_up_right.svg",
                                buttonWidth: 0.4279069767,
                                doubleSize: 10,
                                isDark: true,
                              ),
                            if (widget.uid != null)
                              CustomButton(
                                onPressed: () {
                                  context.read<ProfileBloc>().add(
                                        ConnectButtonPressed(
                                          widget.uid!,
                                        ),
                                      );
                                },
                                title: "Connect",
                                buttonWidth: 0.4279069767,
                              ),
                          ],
                        ),
                        if (userData.isLinkEnabled &&
                            bloc.socialLinksList.isNotEmpty)
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
                        if (userData.isBasicDetailEnabled)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "About",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  text: context
                                      .read<UserDataNotifier>()
                                      .userData
                                      .description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: paragraphTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (userData.isProductEnabled &&
                            bloc.productList.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 24),
                              if (bloc.productList.isNotEmpty)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Products",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: primaryTextColor,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("/profile/products");
                                      },
                                      child: const Text(
                                        "View All",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: width,
                                height: 0.3805150215 * height,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: min(5, bloc.productList.length),
                                  itemBuilder: (context, i) {
                                    if (bloc.productList[i].isEnabled) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 25.0,
                                        ),
                                        child: ProductCardWithEnquiry(
                                          product: bloc.productList[i],
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        _getReview(width)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _getReview(width) {
    final bloc = context.read<ProfileBloc>();
    final userData = bloc.userData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.uid != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 35),
              const Text(
                "Review and Ratings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rate your experience working with ${userData.name}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Rating(
                          selected: selectedStars,
                          alignment: MainAxisAlignment.center,
                          size: 36,
                          width: 0.4255813953 * width,
                          onPressed: (i) {
                            setState(() {
                              selectedStars = i;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    // CustomTextField(
                    //   type: TextFieldType.RegularTextField,
                    //   controller: nameController,
                    //   hintText: "Your name",
                    //   onChanged: (s) {
                    //     setState(() {});
                    //   },
                    //   disabled: true,
                    // ),
                    const SizedBox(height: 13),
                    CustomTextField(
                      type: TextFieldType.RegularTextField,
                      controller: feedbackController,
                      isTextArea: true,
                      hintText: "Feedback",
                      onChanged: (s) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(
                              ReviewSubmitted(
                                selectedStars,
                                userData.name,
                                // nameController.text,
                                feedbackController.text,
                                userData,
                                widget.uid!,
                              ),
                            );
                      },
                      title: "Send",
                      disabled: (selectedStars == 0 ||
                          // nameController.text.isEmpty ||
                          feedbackController.text.isEmpty),
                    ),
                  ],
                ),
              )
            ],
          ),
        if (userData.isReviewEnabled)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.uid != null) const SizedBox(height: 25),
              const Text(
                "User Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: primaryTextColor,
                ),
              ),
              for (var i = 0; i < min(bloc.reviewsList.length, 5); i++)
                ListTile(
                  title: Text(
                    bloc.reviewsList[i].name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    bloc.reviewsList[i].feedback,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Rating(selected: bloc.reviewsList[i].review),
                )
            ],
          )
      ],
    );
    // if (widget.uid == null)   {
    //   return ;
    // }
    // return ;
  }

  _getBannerImage(UserData userData) {
    final url = userData.bannerImageURL;
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/images/image.jpeg",
          fit: BoxFit.cover,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      },
    );
    if (url.isNotEmpty) {
      return Image.network(
        url,
        fit: BoxFit.cover,
      );
    } else {
      //TODO: Set new default banner image
      return Image.asset(
        "assets/images/image.jpeg",
        fit: BoxFit.cover,
      );
    }
  }

  _getProfileImage(UserData userData) {
    final url = userData.profileImageURL;
    if (url.isNotEmpty) {
      return Image.network(
        url,
        fit: BoxFit.cover,
      );
    } else {
      //TODO: Set new default profile image
      return Image.asset(
        "assets/images/profile_logo.png",
      );
    }
  }
}
