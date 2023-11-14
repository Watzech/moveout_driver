import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<dynamic> uploadPhoto(var photo) async {

  dynamic cmpressedImage;

  if(photo!=null){ 
    try { 
      cmpressedImage = await FlutterImageCompress.compressWithFile( 
        photo.path, 
        format: CompressFormat.jpeg, 
        quality: 50 
      ); 

    } catch (e) { 
      cmpressedImage = await FlutterImageCompress.compressWithFile( 
        photo.path, 
        format: CompressFormat.heic, 
        quality: 50 
      );
    }

  }

  return base64Encode(cmpressedImage);
}

Future<dynamic> uploadPdf(var pdf) async {
  var file;

  if(pdf!=null){ 
    try {
      final bytes = File(pdf.path).readAsBytesSync();
      file = base64Encode(bytes); 

    } catch (e) { 
      print(e);
      print(false);
    }

  }

  return base64Encode(file);
}