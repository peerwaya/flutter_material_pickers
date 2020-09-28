// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Allows selection of a file.
Future<void> showMaterialFilePicker({
  BuildContext context,
  FileType fileType = FileType.image,
  String fileExtension,
  ValueChanged<Uint8List> onChanged,
}) async {
  try {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: fileType);

    if (result != null) {
      var data = result.files.single.bytes;
      if (onChanged != null && data != null) onChanged(data);
    }
  } catch (error) {
    if (error.runtimeType is PlatformException) return; // user clicked twice
    if (error.runtimeType is NoSuchMethodError) return; // user canceled dialog
    throw error;
  }
}
