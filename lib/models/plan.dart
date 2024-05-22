import 'package:firebase_database/firebase_database.dart';

class Plan {
  final String currency;
  final String description;
  final int discountInPer;
  final bool isVisible;
  final String planCode;
  final int planDurationinMonth;
  final int planPrice;
  final String termsAndCondition;
  final String title;
  final String updationDate;

  Plan({
    required this.currency,
    required this.description,
    required this.discountInPer,
    required this.isVisible,
    required this.planCode,
    required this.planDurationinMonth,
    required this.planPrice,
    required this.termsAndCondition,
    required this.title,
    required this.updationDate,
  });

  factory Plan.fromSnapshot(DataSnapshot json) {
    return Plan(
      currency: json.child("currency").value.toString(),
      description: json.child("description").value.toString(),
      discountInPer: json.child("discountInPer").value as int,
      isVisible: json.child("isVisible").value as bool,
      planCode: json.child("planCode").value.toString(),
      planDurationinMonth: json.child("planDurationinMonth").value as int,
      planPrice: json.child("planPrice").value as int,
      termsAndCondition: json.child("termsAndCondition").value.toString(),
      title: json.child("title").value.toString(),
      updationDate: json.child("updationDate").value.toString(),
    );
  }
}
