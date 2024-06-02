import 'package:attach_club/models/metaData.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalVariable {
  static AppMetaData metaData = AppMetaData(appBannerLink: "");
  static UserData userData = UserData(
    firstLoginDate: Timestamp.now(),
    lastLoginDate: Timestamp.now(),
    lastPaymentDate: Timestamp.now(),
    username: "",
    isPlanExpiredRecently: false,
    planExitDate: Timestamp.now(),
    planPurchaseDate: Timestamp.now(),
  );
  static bool isDashboardBuildOnce = false;
  static bool isConnectionsBuildOnce = false;
}
