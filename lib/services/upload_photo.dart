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

  return cmpressedImage;
}