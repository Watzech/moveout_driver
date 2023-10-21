import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    required this.dateController,
    required this.unavailableDates,
  }) : super(key: key);

  final TextEditingController dateController;
  final Set<DateTime> unavailableDates;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  DateTime formatDate(String dateString) {
    List<String> dateParts =
        dateString.split('/').map((part) => part.trim()).toList();

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }

  bool isDateAvailable(DateTime date) {
    if (widget.unavailableDates.isNotEmpty) {
      for (DateTime unavailableDate in widget.unavailableDates) {
        if (DateUtils.isSameDay(unavailableDate, date)) {
          return false;
        }
      }
      return true;
    } else {
      return true;
    }
  }

  DateTime findNextAvailableDate() {
    DateTime selectedDate = DateTime.now()
        .add(const Duration(days: 1)); // Começa com o dia seguinte a hoje
    while (!isDateAvailable(selectedDate)) {
      selectedDate =
          selectedDate.add(const Duration(days: 1)); // Tenta o próximo dia
    }
    return selectedDate;
  }

  DateTime initialDateValidator() {
    if (widget.dateController.text.isNotEmpty) {
      return formatDate(widget.dateController.text);
    }
    return findNextAvailableDate();
  }

  void _showDatePicker(BuildContext context, TextEditingController controller) {
    showDatePicker(
      context: context,
      initialDate: initialDateValidator(),
      firstDate: findNextAvailableDate(),
      lastDate: DateTime(DateTime.now().year + 3),
      selectableDayPredicate: (DateTime val) {
        return isDateAvailable(val);
      },
    ).then((value) {
      setState(() {
        if (value != null) {
          controller.text = formatter.format(value);
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
      width: MediaQuery.of(context).size.width * 0.45,
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
          enabledBorder: outlineBorder,
        ),
        onTap: () => _showDatePicker(context, widget.dateController),
      ),
    );
  }
}
