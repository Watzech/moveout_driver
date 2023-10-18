import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<dynamic> uploadPhoto(var photo) async {

  dynamic cmpressedImage;

  if(photo!=null){ 
    try { 
      cmpressedImage = await FlutterImageCompress.compressWithFile( 
        photo.path, 
        format: CompressFormat.jpeg, 
        quality: 70 
      ); 

    } catch (e) { 
      cmpressedImage = await FlutterImageCompress.compressWithFile( 
        photo.path, 
        format: CompressFormat.heic, 
        quality: 70 
      );
    }

  }

  return cmpressedImage;
}