import 'package:airo_epg/platform_epg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('IN resolves to IN1 gzip', () {
    expect(
      Epgshare01CountryShard.resolve('IN').toString(),
      'https://epgshare01.online/epgshare01/epg_ripper_IN1.xml.gz',
    );
  });

  test('in is case-insensitive', () {
    expect(
      Epgshare01CountryShard.resolve('in'),
      Epgshare01CountryShard.resolve('IN'),
    );
  });

  test('GB and UK both resolve to UK1', () {
    expect(
      Epgshare01CountryShard.resolve('GB').toString(),
      'https://epgshare01.online/epgshare01/epg_ripper_UK1.xml.gz',
    );
    expect(
      Epgshare01CountryShard.resolve('UK'),
      Epgshare01CountryShard.resolve('GB'),
    );
  });

  test('US resolves to US2 not US_LOCALS', () {
    expect(
      Epgshare01CountryShard.resolve('US').path,
      endsWith('epg_ripper_US2.xml.gz'),
    );
  });

  test('CA resolves to CA2', () {
    expect(
      Epgshare01CountryShard.resolve('CA').path,
      endsWith('epg_ripper_CA2.xml.gz'),
    );
  });

  test('unknown country throws XmltvShardUnavailableException', () {
    expect(
      () => Epgshare01CountryShard.resolve('ZZ'),
      throwsA(isA<XmltvShardUnavailableException>()),
    );
    expect(
      () => Epgshare01CountryShard.resolve(''),
      throwsA(isA<XmltvShardUnavailableException>()),
    );
  });
}
