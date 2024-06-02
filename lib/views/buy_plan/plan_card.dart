import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final String planCode;
  final int price;
  final int discount;
  final bool gradient;
  final void Function() updateSelectedPlan;

  const PlanCard({
    super.key,
    required this.planCode,
    required this.price,
    required this.discount,
    required this.gradient,
    required this.updateSelectedPlan,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: updateSelectedPlan,
      child: Container(
        width: 0.4534883721 * width,
        height: 0.1201716738 * height,
        // margin: const EdgeInsets.symmetric(
        //   horizontal: 4,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: (gradient)
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFE976),
                    Color(0xFFFFD16A),
                  ],
                )
              : null,
          color: (gradient) ? null : const Color(0xFF373A4B),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 12,
            bottom: 10.0,
            right: 0.05581395349 * width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    planCode,
                    style: TextStyle(
                      fontSize: 14,
                      color: (gradient) ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: (gradient) ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        "-$discount%",
                        style: TextStyle(
                          color: (gradient) ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Rs. ${((1 + (discount / 100)) * price).toInt()} / Month",
                      style: TextStyle(
                        color:
                            (gradient) ? const Color(0xFF937B00) : Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  Text(
                    "Rs. $price / Month",
                    style: TextStyle(
                      color: (gradient)?Colors.black:Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
