import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getPhoto() async {
  var prefs = await SharedPreferences.getInstance();
  final user = prefs.getString("userData") ?? "";
  var photo = jsonDecode(user);

  return photo["photo"];
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    ImageProvider provider;

    return FutureBuilder<String>(
      future: getPhoto(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          provider = MemoryImage(base64Decode(snapshot.data!));
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(
                width: 3,
                color: Theme.of(context).colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(200),
            ),
            width: 75,
            height: 75,
            child: provider == null ? const Text('No image selected.') : ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(50),
                child: Image(image: provider, fit: BoxFit.cover),
              ),
            )
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
