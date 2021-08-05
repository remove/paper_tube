import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseCore {
  static final ParseCore _parseCore = ParseCore._internal();

  factory ParseCore() {
    return _parseCore;
  }

  ParseCore._internal() {
    Parse().initialize(
      "aero",
      "https://service-91hbtix2-1251276529.hk.apigw.tencentcs.com/release/parse",
    );
  }

  Future<Map<String, dynamic>> uploadAvatar(XFile sourceImage) async {
    Map<String, dynamic> result = {"success": false, "url": null};
    File? croppedImgFile = await ImageCropper.cropImage(
        sourcePath: sourceImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square]);
    if (croppedImgFile != null) {
      String path = croppedImgFile.path;
      int lastSeparator = path.lastIndexOf(Platform.pathSeparator);
      String newPath = path.substring(0, lastSeparator + 1) + "avatar.jpg";
      croppedImgFile.renameSync(newPath);
      File renamedCroppedImg = File(newPath);
      await ParseFile(renamedCroppedImg).upload().then((value) {
        if (value.success) {
          String url = (value.results![0] as ParseFile).url.toString();
          renamedCroppedImg.delete();
          result = {"success": true, "url": url};
        } else {
          renamedCroppedImg.delete();
        }
      });
      return result;
    } else {
      return result;
    }
  }
}
