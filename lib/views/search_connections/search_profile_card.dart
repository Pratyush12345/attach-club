import 'package:attach_club/core/components/rating.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/profile/profile.dart';
import 'package:flutter/material.dart';

class SearchProfileCard extends StatelessWidget {
  final UserData userData;

  const SearchProfileCard({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageRadius = 0.2162790698 * width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/profile");
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Profile(
        //       uid: userData.uid,
        //     ),
        //   ),
        // );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: const Color(0xFF373A4B),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 0.1856223176 * height,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 0.05581395349 * width),
                            Container(
                              width: imageRadius,
                              height: imageRadius,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  imageRadius / 2,
                                ),
                                child: _getImage(width),
                              ),
                            ),
                            SizedBox(width: 0.03488372093 * width),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      userData.description,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              right: 10,
                            ),
                            //TODO: Replace with SVG
                            child: Image.asset(
                              "assets/images/premium_icon.png",
                              width: 0.06279069767 * width,
                              height: 0.06279069767 * width,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 0.05422746781 * height,
                  color: const Color(0xFF26293B),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 0.04418604651 * width),
                          const Text(
                            "3 out of 5 stars",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Rating(selected: 3),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 0.02325581395 * width,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: const Color(0xFF4285F4)),
                          onPressed: () {},
                          child: const Text(
                            "Connect",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getImage(double width) {
    final person = Icon(
      Icons.person,
      color: Colors.black,
      size: 0.2162790698 * width,
    );
    return Image.network(
      userData.profileImageURL,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return person;
        }
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return person;
      },
    );
  }
}
