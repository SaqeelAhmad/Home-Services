import 'package:flutter/material.dart';
import 'package:homeservices/res/color.dart';

class RowCard extends StatelessWidget {
  String title1, title2, tiltle3;
  String image1, image2, image3;
  VoidCallback onTab1, onTab2, onTab3;

  RowCard(
      {Key? key,
      required this.title1,
      required this.title2,
      required this.tiltle3,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.onTab1,
      required this.onTab2,
      required this.onTab3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: onTab1,
            child: Card(
              elevation: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      image1,
                      height: 100,
                      width: 100,
                    ),
                    Text(title1,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AppColors.kPrimaryColor))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onTab2,
            child: Card(
              elevation: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      image2,
                      height: 100,
                      width: 100,
                    ),
                    Text(title2,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AppColors.kPrimaryColor))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onTab3,
            child: Card(
              elevation: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      image3,
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      tiltle3,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AppColors.kPrimaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
