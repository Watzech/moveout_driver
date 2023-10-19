import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moveout1/services/get_addresses.dart';
import 'package:moveout1/widgets/sliding_panel_widgets/custom_divider.dart';

const String nullAddress = 'Nenhum endereço encontrado';

class SearchAddressTextField extends StatelessWidget {
  const SearchAddressTextField({
    super.key,
    required this.addressSearchFocusNode,
    required TextEditingController searchController,
    required this.onChangedFunction,
  }) : _searchController = searchController;

  final FocusNode addressSearchFocusNode;
  final TextEditingController _searchController;
  final void Function(LatLng) onChangedFunction;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _searchController,
        focusNode: addressSearchFocusNode,
        enableSuggestions: true,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Pesquisar Endereço',
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.background,
        ),
      ),
      minCharsForSuggestions: 3,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      suggestionsCallback: (value) {
        return getAddresses(value);
      },
      itemBuilder: (context, place) {
        //Map place[3]
        // [0] name
        // [1] lat
        // [2] long
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: place != null
              ? Text(
                  place['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    // color:
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : Center(
                  child: Text(
                    nullAddress,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
        );
      },
      itemSeparatorBuilder: (context, index) {
        return const CustomDivider();
      },
      onSuggestionSelected: (suggestion) {
        _searchController.text = suggestion['name'];
        LatLng placeLatLng = LatLng(suggestion['latitude'], suggestion['longitude']);
        onChangedFunction(placeLatLng);
      },
    );
  }
}
