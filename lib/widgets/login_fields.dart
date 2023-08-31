// ignore_for_file: prefer_const_constructors, unnecessary_this, no_logic_in_create_state, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum ImageSourceType { gallery, camera }

const cLabelStyle = TextStyle(color: Colors.white, fontSize: 15);
const cBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0));

class LoginTextField extends StatelessWidget {
  final String lbl;
  const LoginTextField({super.key, required this.lbl});

  @override
  Widget build(BuildContext context) {
    return TextField(
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

class LoginPasswordTextField extends StatefulWidget {
  final String lbl;
  bool obscure = true;
  LoginPasswordTextField({super.key, required this.lbl});

  @override
  State<LoginPasswordTextField> createState() => _LoginPasswordTextField();
}

class _LoginPasswordTextField extends State<LoginPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}

class LoginTextFormField extends StatefulWidget {
  final String lbl;
  const LoginTextFormField({super.key, required this.lbl});

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: cBorder,
        focusedBorder: cBorder,
        labelText: widget.lbl,
        labelStyle: cLabelStyle,
      ),
      validator: (String? value) {
        return (value == null) ? 'Esse campo é obrigatório.' : null;
      },
    );
  }
}

class LoginPasswordTextFormField extends StatefulWidget {
  final String lbl;
  bool obscure = true;
  LoginPasswordTextFormField({super.key, required this.lbl});

  @override
  State<LoginPasswordTextFormField> createState() =>
      _LoginPasswordTextFormField();
}

class _LoginPasswordTextFormField extends State<LoginPasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: (String? value) {
        return (value == null) ? 'Esse campo é obrigatório.' : null;
      },
    );
  }
}

class MaskedLoginTextFormField extends StatelessWidget {
  final String lbl;
  final bool obscure;
  final MaskTextInputFormatter maskFormatter;
  const MaskedLoginTextFormField(
      {super.key,
      required this.lbl,
      this.obscure = false,
      required this.maskFormatter});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: cBorder,
        focusedBorder: cBorder,
        labelText: lbl,
        labelStyle: cLabelStyle,
      ),
      validator: (String? value) {
        return (value == null) ? 'Esse campo é obrigatório.' : null;
      },
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
                if(image != null){
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
                  image: DecorationImage(image: FileImage(_image), fit: BoxFit.cover),
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