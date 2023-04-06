import 'package:flutter/material.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPrass;

  final color, textColor;
  final bool loading;


  RoundButton({
    Key? key,
    required this.title,
    required this.onPrass,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.loading = false,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: loading ? null : onPrass,
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,),
          child: Card(
            elevation: 10,
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 45,
              child: Center(
                  child: loading
                      ? CircularProgressIndicator(
                          color: textColor,
                        )
                      : Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 20, color: textColor),
                        )),
            ),
          ),
        ),
      ),
    );
  }
}
