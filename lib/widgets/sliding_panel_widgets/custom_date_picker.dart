import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController dateController;

  const CustomDatePicker({
    super.key,
    required this.dateController,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
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
          String month =
              _date.month <= 9 ? '0${_date.month}' : _date.month.toString();
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
    super.build(context);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.45,
      child: TextFormField(
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
