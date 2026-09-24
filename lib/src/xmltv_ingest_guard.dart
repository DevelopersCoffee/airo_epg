import 'dart:io';

class XmltvIngestBannedUrlException implements Exception {
  const XmltvIngestBannedUrlException();

  @override
  String toString() =>
      'Pick a country in Settings. Do not use the world ALL_SOURCES file.';
}

class XmltvIngestTooLargeException implements Exception {
  const XmltvIngestTooLargeException();

  @override
  String toString() =>
      'This guide file is too large to load on this device. Pick a country '
      'guide instead of a world file.';
}

class XmltvIngestGuard {
  static const maxCompressedBytes = 16 * 1024 * 1024;
  static const maxUncompressedBytes = 80 * 1024 * 1024;

  static const _banned = [
    'all_sources',
    'guide_all',
    'us_locals',
    'dummy_channels',
  ];

  static void assertSafeUrl(Uri url) {
    if (url.host.isEmpty ||
        (url.scheme != 'https' && url.scheme != 'http')) {
      throw ArgumentError.value(url, 'url', 'Enter a valid HTTP(S) XMLTV URL.');
    }
    final haystack = '${url.path} ${url.query}'.toLowerCase();
    for (final token in _banned) {
      if (haystack.contains(token)) {
        throw const XmltvIngestBannedUrlException();
      }
    }
  }

  static void assertSafeLength({
    required int compressedBytes,
    int? uncompressedBytes,
  }) {
    if (compressedBytes > maxCompressedBytes) {
      throw const XmltvIngestTooLargeException();
    }
    if (uncompressedBytes != null &&
        uncompressedBytes > maxUncompressedBytes) {
      throw const XmltvIngestTooLargeException();
    }
  }

  static Future<void> gunzipFile({
    required File input,
    required File output,
    int maxUncompressedBytes = XmltvIngestGuard.maxUncompressedBytes,
  }) async {
    final sink = output.openWrite();
    var written = 0;
    try {
      await for (final chunk in gzip.decoder.bind(input.openRead())) {
        written += chunk.length;
        if (written > maxUncompressedBytes) {
          throw const XmltvIngestTooLargeException();
        }
        sink.add(chunk);
      }
      await sink.close();
    } catch (_) {
      await sink.close();
      if (await output.exists()) await output.delete();
      rethrow;
    }
  }
}
