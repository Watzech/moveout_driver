// ignore_for_file: prefer_const_constructors, unnecessary_this, no_logic_in_create_state, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum ImageSourceType { gallery, camera }

const cLabelStyle = TextStyle(color: Colors.white, fontSize: 15);
const cBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0));

class NavigatorTextButton extends StatelessWidget {
  final String txt;
  final Color color;
  final Widget destinationWidget;
  const NavigatorTextButton(
      {super.key,
      required this.txt,
      this.color = Colors.white,
      required this.destinationWidget});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationWidget),
          );
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            txt,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 11,
              color: color,
              decoration: TextDecoration.underline,
              decorationColor: color,
              decorationThickness: 2,
            ),
          ),
        ));
  }
}

class LoginTextFormField extends StatelessWidget {
  final String lbl;
  final TextEditingController controller;
  final String? Function(String?) validatorFunction;
  const LoginTextFormField({super.key, required this.lbl, required this.controller, required this.validatorFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorFunction,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: cBorder,
        focusedBorder: cBorder,
        labelText: lbl,
        labelStyle: cLabelStyle,
      ),
    );
  }
}

class LoginPasswordTextFormField extends StatefulWidget {
  final String lbl;
  final TextEditingController controller;
  bool obscure = true;
  final String? Function(String?) validatorFunction;
  LoginPasswordTextFormField(
      {super.key, required this.lbl, required this.controller, required this.validatorFunction});

  @override
  State<LoginPasswordTextFormField> createState() =>
      _LoginPasswordTextFormField();
}

class _LoginPasswordTextFormField extends State<LoginPasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: cBorder,
        focusedBorder: cBorder,
        labelText: widget.lbl,
        labelStyle: cLabelStyle,
        suffixIcon: IconButton(
          icon: Icon(
            widget.obscure ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () {
            setState(() {
              widget.obscure = !widget.obscure;
            });
          },
        ),
      ),
      validator: widget.validatorFunction,
    );
  }
}

class MaskedLoginTextFormField extends StatelessWidget {
  final String lbl;
  final TextEditingController controller;
  final bool obscure;
  final MaskTextInputFormatter maskFormatter;
  final String? Function(String?) validatorFunction;
  const MaskedLoginTextFormField(
      {super.key,
      required this.lbl,
      required this.controller,
      this.obscure = false,
      required this.maskFormatter,
      required this.validatorFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: cBorder,
        focusedBorder: cBorder,
        labelText: lbl,
        labelStyle: cLabelStyle,
      ),
      validator: validatorFunction,
      inputFormatters: [maskFormatter],
    );
  }
}

class LoginPhotoField extends StatefulWidget {
  final type;
  const LoginPhotoField(this.type, {super.key});

  @override
  LoginPhotoFieldState createState() => LoginPhotoFieldState(this.type);
}

class LoginPhotoFieldState extends State<LoginPhotoField> {
  var _image;
  var imagePicker;
  var type;

  LoginPhotoFieldState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     'Foto:',
        //     style: cLabelStyle,
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: GestureDetector(
            onTap: () async {
              XFile? image;
              image = await imagePicker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 50,
              );
              setState(() {
                if (image != null) {
                  _image = File(image.path);
                }
              });
            },
            child: _image != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      border: Border.all(
                        width: 3,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      borderRadius: BorderRadius.circular(200),
                      image: DecorationImage(
                          image: FileImage(_image), fit: BoxFit.cover),
                    ),
                    // width: MediaQuery.sizeOf(context).width * 0.50,
                    // height: MediaQuery.sizeOf(context).height * 0.23,
                    width: 225,
                    height: 225,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      border: Border.all(
                        width: 3,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    // width: MediaQuery.sizeOf(context).width * 0.50,
                    // height: MediaQuery.sizeOf(context).height * 0.23,
                    width: 225,
                    height: 225,
                    child: Icon(
                      Icons.camera_alt,
                      size: MediaQuery.sizeOf(context).width * 0.075,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
