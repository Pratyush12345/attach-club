class Review {
  final String feedback;
  final int review;
  final String name;
  final String mobileNo;
  final String id;

  Review({
    required this.feedback,
    required this.review,
    required this.name,
    required this.mobileNo,
    this.id = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "feedback": feedback,
      "review": review,
      "name": name,
      "mobileNo": mobileNo,
    };
  }

  factory Review.fromJson(Map<String, dynamic> m, String id) {
    return Review(
      feedback: m["feedback"],
      review: m["review"],
      name: m["name"],
      mobileNo: m["mobileNo"],
      id: id,
    );
  }
}
