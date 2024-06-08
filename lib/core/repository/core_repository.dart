import 'dart:developer';
import 'dart:io';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/bloc/add_link/add_link_bloc.dart';
import 'package:attach_club/bloc/add_service/add_service_bloc.dart';
import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/bloc/dashboard/dashboard_bloc.dart';
import 'package:attach_club/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:attach_club/bloc/profile/profile_bloc.dart';
import 'package:attach_club/bloc/profile_image/profile_image_bloc.dart';
import 'package:attach_club/bloc/signup/signup_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/models/product.dart';
import 'package:attach_club/models/review.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreRepository {
  Future<void> uploadFcmToken() async {
    final user = getCurrentUser();
    final db = FirebaseFirestore.instance;
    final token = await FirebaseMessaging.instance.getToken();
    await db.collection("users").doc(user.uid).update({"fcm_token": token});
  }

  Future<bool> checkOnboardingStatus() async {
    final db = FirebaseFirestore.instance;
    final currentUser = getCurrentUser();
    final data = await db.collection("users").doc(currentUser.uid).get();
    if (data.exists &&
        data.data() != null &&
        (data.data()!["name"] as String).isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> checkActiveStatus() async {
    final db = FirebaseFirestore.instance;
    final currentUser = getCurrentUser();
    final data = await db.collection("users").doc(currentUser.uid).get();
    if (data.exists &&
        data.data() != null &&
        (data.data()!["isActive"] as bool)==true) {
      return true;
    }
    return false;
  }

  Future<UserData> getUserData() async {
    final currentUser = getCurrentUser();
    final db = FirebaseFirestore.instance;
    final data = await db.collection("users").doc(currentUser.uid).get();
    if (data.exists) {
      GlobalVariable.userData =
          UserData.fromMap(map: data.data()!, uid: currentUser.uid);
      return UserData.fromMap(map: data.data()!, uid: currentUser.uid);
    }
    throw Exception("User data not found");
  }

  Future<UserData> getUserDataFromUid(String uid) async {
    final db = FirebaseFirestore.instance;
    final data = await db.collection("users").doc(uid).get();
    if (data.exists) {
      return UserData.fromMap(map: data.data()!);
    }
    throw Exception("User data not found");
  }

  User getCurrentUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("User not logged in");
    }
    return currentUser;
  }

  Future<List<SocialLink>> getSocialLinks() async {
    final currentUser = getCurrentUser();
    final db = FirebaseFirestore.instance;
    final list = <SocialLink>[];
    final data = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("links")
        .get();

    for (var i in data.docs) {
      list.add(SocialLink.fromMap(i.data()));
    }

    return list;
  }

  Future<List<SocialLink>> getSocialLinksFromUid(String uid) async {
    final db = FirebaseFirestore.instance;
    final list = <SocialLink>[];
    final data =
        await db.collection("users").doc(uid).collection("links").get();

    for (var i in data.docs) {
      list.add(SocialLink.fromMap(i.data()));
    }

    return list;
  }

  Future<List<Product>> getAllProducts() async {
    final currentUser = getCurrentUser();
    final db = FirebaseFirestore.instance;
    final data = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("products")
        .get();
    final list = <Product>[];
    for (var i in data.docs) {
      if (i.exists) {
        final map = i.data();
        list.add(Product.fromMap(
          map: map,
          // image: file,
          image: null,
          docId: i.id,
        ));
      }
    }
    return list;
  }

  Future<List<Product>> getAllProductsFromUid(String uid) async {
    final db = FirebaseFirestore.instance;
    final data =
        await db.collection("users").doc(uid).collection("products").get();
    final list = <Product>[];
    for (var i in data.docs) {
      if (i.exists) {
        final map = i.data();
        list.add(Product.fromMap(
          map: map,
          image: null,
          docId: i.id,
        ));
      }
    }
    return list;
  }

  void logout(BuildContext context) {
    //TODO: Verify all blocs are reset
    final addServiceBloc = context.read<AddServiceBloc>();
    addServiceBloc.list = [];

    final connectionsBloc = context.read<ConnectionsBloc>();
    connectionsBloc.connectedList = [];
    connectionsBloc.sentList = [];
    connectionsBloc.receivedList = [];

    final dashboardBloc = context.read<DashboardBloc>();
    dashboardBloc.reviewCount = 0;
    dashboardBloc.connectionsCount = 0;

    final profileBloc = context.read<ProfileBloc>();
    profileBloc.reviewCount = 0;
    profileBloc.rating = 0;
    profileBloc.productList = [];
    profileBloc.socialLinksList = [];
    profileBloc.userData = UserData(
      username: "",
      firstLoginDate: Timestamp.now(),
      lastLoginDate: Timestamp.now(),
      lastPaymentDate: Timestamp.now(),
      isPlanExpiredRecently: false,
      planExitDate: Timestamp.now(),
      planPurchaseDate: Timestamp.now(),
    );
    profileBloc.uid = null;
    profileBloc.lastUpdated = null;
    profileBloc.reviewsList = [];

    final signUpBloc = context.read<SignupBloc>();
    signUpBloc.resendToken = null;
    signUpBloc.verificationId = "";

    final editProfileBloc = context.read<EditProfileBloc>();
    editProfileBloc.name = "";
    editProfileBloc.profession = "";
    editProfileBloc.description = "";

    final addLinkBloc = context.read<AddLinkBloc>();
    addLinkBloc.list = [];
    addLinkBloc.lastUpdated = null;

    final profileImageBloc = context.read<ProfileImageBloc>();
    profileImageBloc.lastUpdated = null;
    profileImageBloc.profileImage = "";
    profileImageBloc.bannerImage = "";

    FirebaseAuth.instance.signOut();
  }

  Future<void> downloadImageOfProducts({
    required List<Product> list,
    required void Function(List<Product>) onListUpdated,
    String? uid,
  }) async {
    uid ??= getCurrentUser().uid;
    final storageRef = FirebaseStorage.instance.ref();
    for (var i = 0; i < list.length; i++) {
      final product = list[i];
      //TODO: check if image already exists
      //TODO: handle null imageRef condition
      final imageRef =
          storageRef.child("users/$uid/products/${product.id}/image.jpg");
      final appDocDir = await getApplicationDocumentsDirectory();
      final directory =
          Directory("${appDocDir.path}/images/products/${product.id}/");
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      final filePath =
          "${appDocDir.path}/images/products/${product.id}/image.jpg";
      final file = File(filePath);
      await imageRef.writeToFile(file);
      product.image = file;
      onListUpdated(list);
    }
  }

  Future<void> sendConnectionRequest(String userUid) async {
    final user = getCurrentUser();
    final currentUserData = await getUserData();
    final time = Timestamp.now();
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(user.uid)
        .collection("requests")
        .doc(userUid)
        .set(ConnectionRequest(
          phoneNo: currentUserData.phoneNo,
          status: CONNECTION_SENT_STATUS,
          updateTime: time,
          uid: userUid,
        ).toMap());

    await db
        .collection("users")
        .doc(userUid)
        .collection("requests")
        .doc(user.uid)
        .set(ConnectionRequest(
          phoneNo: currentUserData.phoneNo,
          status: CONNECTION_RECEIVED_STATUS,
          updateTime: time,
          uid: userUid,
        ).toMap());
  }

  Future<void> sendWhatsappMessage(String phoneNumber) async {
    String text =
        "${GlobalVariable.metaData.message!.replaceAll(" newline ", "\n").replaceAll("#name", GlobalVariable.userData.name)} \n ${GlobalVariable.metaData.webURL! + GlobalVariable.userData.username}";

    var androidUrl = "whatsapp://send?phone=$phoneNumber&text=$text";
    var iosUrl = "https://wa.me/$phoneNumber?text=$text}";
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  }

  Future<void> sendQueryWhatsappMessage(String phoneNumber) async {
    String text =
        "${GlobalVariable.metaData.message!.replaceAll(" newline ", "\n").replaceAll("#name", GlobalVariable.userData.name)} \n ${GlobalVariable.metaData.webURL! + GlobalVariable.userData.username}";

    var androidUrl = "whatsapp://send?phone=$phoneNumber&text=$text";
    var iosUrl = "https://wa.me/$phoneNumber?text=$text}";
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  }

  Future<String> getDomain() async {
    final db = FirebaseDatabase.instance;
    final data = await db.ref("MetaData/apiURL").get();
    if (data.exists) {
      return data.value.toString();
    }
    throw Exception("Domain not found");
  }

  Future<List<Review>> getReviewsList(String? uid) async {
    final list = <Review>[];
    final user = getCurrentUser();
    final db = FirebaseFirestore.instance;
    final data = await db
        .collection("users")
        .doc(uid ?? user.uid)
        .collection("review")
        .get();
    for (var i in data.docs) {
      if (i.exists) {
        list.add(Review.fromJson(i.data(), i.id));
      }
    }
    return list;
  }

  Future<void> sendOtp({
    required String phoneNumber,
    required int? resendToken,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) autoRetrieve,
    required void Function(PhoneAuthCredential) verificationCompleted,
  }) async {
    final auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
        forceResendingToken: resendToken,
    );
  }

  Future<UserCredential> verifyOtp(
    String verificationId,
    String otp,
  ) async {
    final auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    return await auth.signInWithCredential(credential);
  }

  Future<void> updatePhoneNo(String phoneNo) async {
    final user = getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(user.uid).update({"phoneNo": phoneNo});
  }

}
