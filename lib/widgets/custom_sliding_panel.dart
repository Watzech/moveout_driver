import 'package:flutter/material.dart';
import 'package:moveout1/widgets/confirm_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const IconData truck =
      IconData(0xf0d1, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckMoving =
      IconData(0xf4df, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckPickup =
      IconData(0xf63c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class CustomSlidingPanel extends StatelessWidget {
  CustomSlidingPanel({
    super.key,
    required this.panelController,
    required this.scrollController,
    required this.originAddressController,
    required this.destinationAddressController,
    required this.firstDateController,
    required this.secondDateController,
  });

  final PanelController panelController;
  final ScrollController scrollController;
  final TextEditingController originAddressController;
  final TextEditingController destinationAddressController;
  final TextEditingController firstDateController;
  final TextEditingController secondDateController;
  final _formkey = GlobalKey<FormState>();

  void submitData() {
    if (_formkey.currentState!.validate()) {
      //form correto, cria a entidade e envia pro BD
      print("Uploading...");
      // Client clientData = Client(
      //   name: _nameFormFieldController.text,
      //   cpf: _cpfFormFieldController.text,
      //   phone: _phoneFormFieldController.text,
      //   email: _emailFormFieldController.text,
      //   password: _passwordFormFieldController.text,
      //   photo: 'Work in Progress',
      //   address: _addressFormFieldController.text,
      //   createdAt: DateTime.now(),
      //   updatedAt: DateTime.now(),
      // );

      // Database.insert(clientData);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text(submitValidationFail),
      //   backgroundColor: Theme.of(context).colorScheme.error,
      // ));
    }
  }

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      boxShadow: [
        BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 2.0,
            color: Theme.of(context).colorScheme.shadow)
      ],
      controller: panelController,
      minHeight: MediaQuery.of(context).size.height * 0.058,
      maxHeight: MediaQuery.of(context).size.height * 0.75,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
      panel: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: togglePanel,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.drag_handle,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 35,
                ),
              ),
            ),
          ),
          const CustomDivider(),
          Form(
            child: Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    child: CustomTitle(label: 'Endereços:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    child: CustomAddressTextForm(
                      hintText: 'Endereço de origem...',
                      textFieldController: originAddressController,
                      icon: Icons.add_location_alt,
                    ),
                  ),
                  Center(
                    child: SizedBox.fromSize(
                        size: const Size(2, 20),
                        child: ColoredBox(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 0.0, bottom: 10.0),
                    child: CustomAddressTextForm(
                      hintText: 'Endereço de destino...',
                      textFieldController: destinationAddressController,
                      icon: Icons.add_location_alt,
                    ),
                  ),
                  const CustomCheckboxListTile(label: 'Preciso de Ajudantes'),
                  const CustomCheckboxListTile(label: 'Preciso de Embalagem'),
                  const SizedBox(height: 12),
                  const CustomDivider(),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    child: CustomTitle(label: 'Tamanho do Transporte:'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 20.0),
                    child: Center(child: TransportSizeChoice()),
                  ),
                  const CustomDivider(),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    child: CustomTitle(label: 'Agendamento:'),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                        child: CustomDatePicker(
                            dateController: firstDateController)),
                  ),
                  Center(
                    child: SizedBox.fromSize(
                        size: const Size(2, 12),
                        child: ColoredBox(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 0.0, bottom: 0.0),
                        child: CustomDatePicker(
                            dateController: secondDateController)),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 15.0),
                        child: Text(
                          'Selecione ao menos duas datas disponíveis',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 12,
                          ),
                        )),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        child: ConfirmButtonWidget(
                          lbl: 'Continuar',
                          submitFunction: submitData,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  final TextEditingController dateController;

  const CustomDatePicker({
    super.key,
    required this.dateController,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _date = DateTime.now();

  void _showDatePicker(BuildContext context, TextEditingController controller) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 3),
    ).then((value) {
      setState(() {
        if (value != null) {
          _date = value;
          String month = _date.month <= 9
              ? '0${_date.month}'
              : _date.month.toString();
          controller.text = '${_date.day} / $month / ${_date.year}';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
    );
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.45,
      child: TextField(
        controller: widget.dateController,
        readOnly: true,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
            hintText: '.. / .. / ....',
            contentPadding: const EdgeInsets.all(1),
            suffixIcon: Icon(
              Icons.calendar_month,
              size: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            border: outlineBorder,
            enabledBorder: outlineBorder),
        onTap: () => _showDatePicker(context, widget.dateController),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.25,
      color: Colors.grey[200],
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 20),
    );
  }
}

class CustomCheckboxListTile extends StatefulWidget {
  final String label;
  const CustomCheckboxListTile({super.key, required this.label});

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
      side: BorderSide(color: Theme.of(context).colorScheme.primary),
      dense: true,
      checkColor: Theme.of(context).colorScheme.secondary,
      value: checkboxValue,
      onChanged: (bool? value) {
        setState(() {
          checkboxValue = value!;
        });
      },
    );
  }
}

class CustomAddressTextForm extends StatelessWidget {
  const CustomAddressTextForm({
    super.key,
    required this.icon,
    this.fontSize = 12,
    this.iconSize = 25,
    this.hintText = ' ',
    required this.textFieldController,
  });

  final IconData icon;
  final double fontSize;
  final double iconSize;
  final String hintText;
  final TextEditingController textFieldController;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
    );

    return TextFormField(
      controller: textFieldController,
      style: TextStyle(
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(1),
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          size: iconSize,
          color: Theme.of(context).colorScheme.secondary,
        ),
        enabledBorder: outlineBorder,
        border: outlineBorder,
      ),
      onChanged: (value) {
        // Implementar lógica para buscar sugestões de lugares aqui
      },
    );
  }
}

class TransportSizeChoice extends StatefulWidget {
  const TransportSizeChoice({super.key});

  @override
  State<TransportSizeChoice> createState() => _TransportSizeChoiceState();
}

class _TransportSizeChoiceState extends State<TransportSizeChoice> {
  String transportView = ' ';
  Color sColor = Colors.white;
  Color mColor = Colors.white;
  Color lColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: <ButtonSegment<String>>[
        ButtonSegment<String>(
            value: 'S',
            label: Text(' Pequeno', style: TextStyle(color: sColor)),
            icon: Icon(
              CustomIcons.truckPickup,
              color: sColor,
            )),
        ButtonSegment<String>(
            value: 'M',
            label: Text(' Médio', style: TextStyle(color: mColor)),
            icon: Icon(
              CustomIcons.truck,
              color: mColor,
            )),
        ButtonSegment<String>(
            value: 'L',
            label: Text(' Grande', style: TextStyle(color: lColor)),
            icon: Icon(
              CustomIcons.truckMoving,
              color: lColor,
            )),
      ],
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        side: MaterialStateProperty.all(const BorderSide(color: Colors.white)),
      ),
      selected: <String>{transportView},
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          transportView = newSelection.first;
          switch (transportView) {
            case 'S':
              sColor = Theme.of(context).colorScheme.secondary;
              mColor = Colors.white;
              lColor = Colors.white;
              break;
            case 'M':
              sColor = Colors.white;
              mColor = Theme.of(context).colorScheme.secondary;
              lColor = Colors.white;
              break;
            case 'L':
              sColor = Colors.white;
              mColor = Colors.white;
              lColor = Theme.of(context).colorScheme.secondary;
              break;
          }
        });
      },
    );
  }
}
