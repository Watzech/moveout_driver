import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.dateController,
    required this.unavailableDates,
  });

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
  final DateTime _dateDayAfter = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  DateTime formatDate(String dateString) {
    List<String> dateParts =
        dateString.split('/').map((part) => part.trim()).toList();

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }

  DateTime addDaystoDate(DateTime date, int days) {
    return DateTime(date.year, date.month, date.day + 1);
  }

  bool isDateAvailable(DateTime date) {
    if (widget.unavailableDates.isNotEmpty) {
      return !widget.unavailableDates.contains(date);
    } else {
      return true;
    }
  }

  DateTime initialDateValidator(DateTime date) {
    if (widget.dateController.text.isNotEmpty) {
      return formatDate(widget.dateController.text);
    } else {
      if (isDateAvailable(_dateDayAfter)) {
        return _dateDayAfter;
      } else {
        return addDaystoDate(_dateDayAfter, 1);
      }
    }
  }

  void _showDatePicker(BuildContext context, TextEditingController controller) {
    showDatePicker(
        context: context,
        initialDate: widget.dateController.text.isNotEmpty 
            ? initialDateValidator(formatDate(controller.text))
            : _dateDayAfter,
        firstDate: isDateAvailable(_dateDayAfter)
            ? _dateDayAfter
            : addDaystoDate(_dateDayAfter, 1),
        lastDate: DateTime(DateTime.now().year + 3),
        selectableDayPredicate: (DateTime val) {
          return isDateAvailable(val);
        }).then((value) {
      setState(() {
        if (value != null) {
          // String month =
          //     _date.month <= 9 ? '0${_date.month}' : _date.month.toString();
          // controller.text = '${_date.day} / $month / ${_date.year}';
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
