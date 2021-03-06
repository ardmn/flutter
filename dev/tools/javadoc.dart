// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

const String kDocRoot = 'dev/docs/doc';

/// This script downloads an archive of Javadoc for the engine from the
/// artifact store and extracts it to the location used for Dartdoc.
Future<Null> main(List<String> args) async {
  String engineVersion = new File('bin/internal/engine.version').readAsStringSync().trim();

  String url = 'https://storage.googleapis.com/flutter_infra/flutter/$engineVersion/android-javadoc.zip';
  http.Response response = await http.get(url);

  Archive archive = new ZipDecoder().decodeBytes(response.bodyBytes);

  Directory output = new Directory('$kDocRoot/javadoc');
  print('Extracing javadoc to ${output.path}');
  output.createSync(recursive: true);

  for (ArchiveFile af in archive) {
    if (af.isFile) {
      File file = new File('${output.path}/${af.name}');
      file.createSync(recursive: true);
      file.writeAsBytesSync(af.content);
    }
  }

  File testFile = new File('${output.path}/io/flutter/view/FlutterView.html');
  if (!testFile.existsSync()) {
    print('Expected file ${testFile.path} not found');
    exit(1);
  }
}
