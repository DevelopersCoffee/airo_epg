import 'dart:io';

import 'package:airo_epg/platform_epg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('assertSafeUrl accepts IN1', () {
    expect(
      () => XmltvIngestGuard.assertSafeUrl(
        Uri.parse(
          'https://epgshare01.online/epgshare01/epg_ripper_IN1.xml.gz',
        ),
      ),
      returnsNormally,
    );
  });

  test('assertSafeUrl rejects ALL_SOURCES', () {
    expect(
      () => XmltvIngestGuard.assertSafeUrl(
        Uri.parse(
          'https://epgshare01.online/epgshare01/epg_ripper_ALL_SOURCES1.xml.gz',
        ),
      ),
      throwsA(isA<XmltvIngestBannedUrlException>()),
    );
  });

  test('assertSafeUrl rejects US_LOCALS', () {
    expect(
      () => XmltvIngestGuard.assertSafeUrl(
        Uri.parse(
          'https://epgshare01.online/epgshare01/epg_ripper_US_LOCALS1.xml.gz',
        ),
      ),
      throwsA(isA<XmltvIngestBannedUrlException>()),
    );
  });

  test('assertSafeLength rejects oversize compressed', () {
    expect(
      () => XmltvIngestGuard.assertSafeLength(
        compressedBytes: XmltvIngestGuard.maxCompressedBytes + 1,
      ),
      throwsA(isA<XmltvIngestTooLargeException>()),
    );
  });

  test('assertSafeLength rejects oversize uncompressed', () {
    expect(
      () => XmltvIngestGuard.assertSafeLength(
        compressedBytes: 100,
        uncompressedBytes: XmltvIngestGuard.maxUncompressedBytes + 1,
      ),
      throwsA(isA<XmltvIngestTooLargeException>()),
    );
  });

  test('gunzipFile aborts when uncompressed cap is exceeded', () async {
    final dir = await Directory.systemTemp.createTemp('xmltv_gunzip');
    addTearDown(() async => dir.delete(recursive: true));
    final input = File('${dir.path}/in.gz');
    final output = File('${dir.path}/out.xml');
    final payload = List<int>.filled(2048, 0x41);
    await input.writeAsBytes(gzip.encode(payload), flush: true);
    await expectLater(
      XmltvIngestGuard.gunzipFile(
        input: input,
        output: output,
        maxUncompressedBytes: 1024,
      ),
      throwsA(isA<XmltvIngestTooLargeException>()),
    );
  });
}
