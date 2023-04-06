import 'package:flutter/material.dart';

import '../color.dart';

class InputTextField extends StatefulWidget {
  InputTextField({
    Key? key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.onValidator,
    required this.KeyBoardType,
    required this.hint,
    required this.obscureText,
    this.autoFocus = false,
    this.enable = true,
    this.PrefixIcon,
    this.Suffix,
    this.value,
    this.Color=AppColors.secondaryColor,

  }) : super(key: key);

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;
  final TextInputType KeyBoardType;
  final String hint;
  final bool obscureText;

  final bool enable, autoFocus;

  final PrefixIcon;
  final Suffix;
  final value;
  final Color ;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(

        controller: widget.myController,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText,
        cursorColor:widget.Color ,
        onFieldSubmitted: widget.onFiledSubmittedValue,
        validator: widget.onValidator,
        keyboardType: widget.KeyBoardType,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            height: 1,
            fontSize: 19,
            color: AppColors.primaryTextTextColor.withOpacity(0.8)),
        decoration: InputDecoration(
          hintText: widget.hint,
          enabled: widget.enable,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(height: 1, fontSize: 19),
          prefixIcon: Icon(
            IconData(widget.PrefixIcon, fontFamily: 'MaterialIcons'),
            color: widget.Color,
          ),
          suffix: widget.Suffix,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.textFieldDefaultBorderColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.Color,

            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.alertColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.textFieldDefaultBorderColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onChanged: widget.value,

      ),
    );
  }
}
