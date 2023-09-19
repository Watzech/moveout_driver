// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:moveout1/widgets/confirm_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'sliding_panel_widgets/custom_address_text_form.dart';
import 'sliding_panel_widgets/custom_checkbox_list_tile.dart';
import 'sliding_panel_widgets/custom_confirm_button_widget.dart';
import 'sliding_panel_widgets/custom_date_picker.dart';
import 'sliding_panel_widgets/custom_divider.dart';
import 'sliding_panel_widgets/custom_title.dart';
import 'sliding_panel_widgets/transport_size_segmented_button.dart';

const String submitValidationFail = 'Erro de validação, verifique os campos';

class CustomSlidingPanel extends StatefulWidget {
  const CustomSlidingPanel({
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

  @override
  State<CustomSlidingPanel> createState() => _CustomSlidingPanelState();
}

class _CustomSlidingPanelState extends State<CustomSlidingPanel> {
  final _formkey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  String transportSizeValue = ' ';
  void _handleTransportSizeValue(String data) {
    setState(() {
      transportSizeValue = data;
    });
  }

  bool helperCheckValue = false;
  void _handleHelperCheckValue(bool data) {
    setState(() {
      helperCheckValue = data;
    });
  }

  bool packageCheckValue = false;
  void _handlePackageCheckValue(bool data) {
    setState(() {
      packageCheckValue = data;
    });
  }

  bool furnitureCheckValue = false;
  void _handleFurnitureCheckValue(bool data) {
    setState(() {
      furnitureCheckValue = data;
    });
  }

  bool boxCheckValue = false;
  void _handleBoxCheckValue(bool data) {
    setState(() {
      helperCheckValue = data;
    });
  }

  bool fragileCheckValue = false;
  void _handleFragileCheckValue(bool data) {
    setState(() {
      fragileCheckValue = data;
    });
  }

  bool otherCheckValue = false;
  void _handleOtherCheckValue(bool data) {
    setState(() {
      otherCheckValue = data;
    });
  }

  bool isEmpty() {
    setState(() {
      if ((widget.originAddressController.text.isNotEmpty) &&
          (widget.destinationAddressController.text.isNotEmpty) &&
          ((furnitureCheckValue ||
              boxCheckValue ||
              fragileCheckValue ||
              otherCheckValue)) &&
          (widget.firstDateController.text.isNotEmpty) &&
          (widget.secondDateController.text.isNotEmpty)) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
    return isButtonEnabled;
  }

  void submitData() {
    if (_formkey.currentState!.validate()) {
      // form correto, cria a entidade e envia pro BD
      print('opaa ' + widget.originAddressController.text);
      print("Uploading...");
      // Database.insert(clientData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Erro na validação, verifique os campos'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      boxShadow: [
        BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 2.0,
            color: Theme.of(context).colorScheme.shadow)
      ],
      controller: widget.panelController,
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
            key: _formkey,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 15.0),
                    child: CustomTitle(label: 'Endereços:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    child: CustomAddressTextForm(
                      fontSize: 14,
                      hintText: 'Endereço de origem...',
                      textFieldController: widget.originAddressController,
                      icon: Icons.add_location_alt,
                      onChangedFunction: (value) {
                        isEmpty();
                      },
                    ),
                  ),
                  Center(
                    child: SizedBox.fromSize(
                        size: const Size(2, 30),
                        child: ColoredBox(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 0.0, bottom: 0.0),
                    child: CustomAddressTextForm(
                      fontSize: 14,
                      hintText: 'Endereço de destino...',
                      textFieldController: widget.destinationAddressController,
                      icon: Icons.add_location_alt,
                      onChangedFunction: (value) {
                        isEmpty();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 15.0, bottom: 0.0),
                    child: CustomCheckboxListTile(
                        label: 'Preciso de Ajudantes',
                        callback: _handleHelperCheckValue,
                        onChangedFunction:(){}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 0.0, bottom: 15.0),
                    child: CustomCheckboxListTile(
                        label: 'Preciso de Embalagem',
                        callback: _handlePackageCheckValue,
                        onChangedFunction:(){}),
                  ),
                  const CustomDivider(),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 15.0),
                    child: CustomTitle(label: 'Tamanho do Transporte:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 30.0),
                    child: Center(
                        child: TransportSizeSegmentedButton(
                            callback: _handleTransportSizeValue)),
                  ),
                  const CustomDivider(),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 15.0),
                    child: CustomTitle(label: 'Lista de Itens:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 0.0, bottom: 0.0),
                    child: CustomCheckboxListTile(
                        label: 'Móveis / Eletrodomésticos de grande porte',
                        callback: _handleFurnitureCheckValue,
                        onChangedFunction: isEmpty),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 0.0, bottom: 0.0),
                    child: CustomCheckboxListTile(
                        label: 'Caixas / Itens diversos',
                        callback: _handleBoxCheckValue,
                        onChangedFunction: isEmpty),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 0.0, bottom: 0.0),
                    child: CustomCheckboxListTile(
                        label: 'Vidros / Objetos frágeis',
                        callback: _handleFragileCheckValue,
                        onChangedFunction: isEmpty),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 0.0, bottom: 0.0),
                    child: CustomCheckboxListTile(
                        label: 'Outros', 
                        callback: _handleOtherCheckValue,
                        onChangedFunction: isEmpty),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                        child: Text(
                          'Selecione ao menos um tipo de item',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 12,
                          ),
                        )),
                  ),
                  const SizedBox(height: 10),
                  const CustomDivider(),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 15.0),
                    child: CustomTitle(label: 'Agendamento:'),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                        child: CustomDatePicker(
                          dateController: widget.firstDateController,
                          onChangedFunction: (value) {
                            isEmpty();
                          },
                        )),
                  ),
                  Center(
                    child: SizedBox.fromSize(
                        size: const Size(2, 25),
                        child: ColoredBox(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 0.0, bottom: 0.0),
                        child: CustomDatePicker(
                          dateController: widget.secondDateController,
                          onChangedFunction: (value) {
                            isEmpty();
                          },
                        )),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 25.0, bottom: 15.0),
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
                      padding: const EdgeInsets.all(25.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        child: SlidingPanelConfirmButtonWidget(
                          text: 'Fazer Pedido',
                          submitFunction: submitData,
                          originAddressController:
                              widget.originAddressController,
                          destinationAddressController:
                              widget.destinationAddressController,
                          firstDateController: widget.firstDateController,
                          secondDateController: widget.secondDateController,
                          furnitureCheckValue: furnitureCheckValue,
                          boxCheckValue: boxCheckValue,
                          fragileCheckValue: fragileCheckValue,
                          otherCheckValue: otherCheckValue,
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
