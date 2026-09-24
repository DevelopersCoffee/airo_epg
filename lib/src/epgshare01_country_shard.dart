class XmltvShardUnavailableException implements Exception {
  const XmltvShardUnavailableException(this.countryCode);

  final String countryCode;

  @override
  String toString() => 'No EPGShare01 guide file for $countryCode.';
}

class Epgshare01CountryShard {
  static const baseUrl = 'https://epgshare01.online/epgshare01/';

  /// Largest two-letter country gzip on the 2026-09-23 EPGShare01 index.
  /// `GB` is an alias of `UK` (applied before lookup).
  static const slugs = <String, String>{
    'AE': 'AE1',
    'AL': 'AL1',
    'AR': 'AR1',
    'AT': 'AT1',
    'AU': 'AU1',
    'BA': 'BA1',
    'BB': 'BB1',
    'BE': 'BE2',
    'BG': 'BG1',
    'BR': 'BR1',
    'CA': 'CA2',
    'CH': 'CH1',
    'CL': 'CL1',
    'CO': 'CO1',
    'CR': 'CR1',
    'CY': 'CY1',
    'CZ': 'CZ1',
    'DE': 'DE1',
    'DK': 'DK1',
    'DO': 'DO1',
    'EC': 'EC1',
    'EG': 'EG1',
    'ES': 'ES1',
    'FI': 'FI1',
    'FR': 'FR1',
    'GR': 'GR1',
    'HK': 'HK1',
    'HR': 'HR1',
    'HU': 'HU1',
    'ID': 'ID1',
    'IE': 'IE1',
    'IL': 'IL1',
    'IN': 'IN1',
    'IT': 'IT1',
    'JM': 'JM1',
    'JP': 'JP1',
    'KE': 'KE1',
    'KR': 'KR1',
    'KZ': 'KZ1',
    'LT': 'LT1',
    'LU': 'LU1',
    'LV': 'LV1',
    'MN': 'MN1',
    'MT': 'MT1',
    'MX': 'MX1',
    'MY': 'MY1',
    'NG': 'NG1',
    'NL': 'NL1',
    'NO': 'NO1',
    'NZ': 'NZ1',
    'PA': 'PA1',
    'PE': 'PE1',
    'PH': 'PH2',
    'PK': 'PK1',
    'PL': 'PL1',
    'PT': 'PT1',
    'RO': 'RO1',
    'RS': 'RS1',
    'SA': 'SA2',
    'SE': 'SE1',
    'SG': 'SG1',
    'SK': 'SK1',
    'SV': 'SV1',
    'TH': 'TH1',
    'TR': 'TR3',
    'UK': 'UK1',
    'US': 'US2',
    'UY': 'UY1',
    'VN': 'VN1',
    'ZA': 'ZA1',
  };

  static Uri resolve(String countryCode) {
    var code = countryCode.trim().toUpperCase();
    if (code == 'GB') code = 'UK';
    final slug = slugs[code];
    if (slug == null) {
      throw XmltvShardUnavailableException(countryCode);
    }
    return Uri.parse('${baseUrl}epg_ripper_$slug.xml.gz');
  }
}
