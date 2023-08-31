import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:moveout1/widgets/login_fields.dart';

class PersonalDataFormListView extends StatelessWidget {
  const PersonalDataFormListView({super.key,});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: LoginTextFormField(lbl: 'Nome completo:'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: MaskedLoginTextFormField(lbl: 'CPF:', maskFormatter: MaskTextInputFormatter(
            mask: '###.###.##-##', 
            filter: { "#": RegExp(r'[0-9]') },
            type: MaskAutoCompletionType.lazy 
          ),),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: LoginTextFormField(lbl: 'E-mail:'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: LoginPasswordTextFormField(lbl: 'Senha:'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: LoginPasswordTextFormField(lbl: 'Confirme a Senha:'),
        ),
      ],
    );
  }
}

class AdditionalDataFormListView extends StatelessWidget {
  const AdditionalDataFormListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: LoginPhotoField(ImageSourceType.gallery),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: MaskedLoginTextFormField(lbl: 'Telefone:', maskFormatter: MaskTextInputFormatter(
            mask: '(##) #####-####', 
            filter: { "#": RegExp(r'[0-9]') },
            type: MaskAutoCompletionType.lazy 
          ),),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 25.0),
          child: LoginTextFormField(lbl: 'Endereço (Arrumar):'),
        ),
      ],
    );
  }
}