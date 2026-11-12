import 'dart:convert';

import 'package:xml/xml.dart';

class PromoMaterialModel {
  const PromoMaterialModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.buttonText,
    required this.buttonColor,
  });

  final String title;
  final String description;
  final String imageUrl;
  final String link;
  final String buttonText;
  final String buttonColor;

  static List<PromoMaterialModel> fromSoapResponse(String response) {
    final document = XmlDocument.parse(response);
    final faults = document.findAllElements('Fault');
    if (faults.isNotEmpty) {
      throw FormatException('Promo service error: ${faults.first.innerText}');
    }

    final results = document.findAllElements('GetCCPromoResult');
    if (results.isEmpty || results.first.innerText.trim().isEmpty) {
      return const [];
    }

    final decoded = jsonDecode(_normalizeJsonLiterals(results.first.innerText));
    final List<MapEntry<String, dynamic>> entries;
    if (decoded is Map) {
      entries = decoded.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value))
          .toList(growable: false);
    } else if (decoded is List) {
      entries = decoded
          .asMap()
          .entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value))
          .toList(growable: false);
    } else {
      throw const FormatException(
        'Promo service returned an unexpected response.',
      );
    }

    return entries
        .map((entry) => _fromJson(entry.key, entry.value))
        .toList(growable: false);
  }

  static PromoMaterialModel _fromJson(String key, dynamic value) {
    if (value is! Map) {
      throw const FormatException(
        'Promo service returned an invalid promo item.',
      );
    }
    final item = {
      for (final entry in value.entries)
        entry.key.toString().toLowerCase(): entry.value,
    };

    final rawImage = _stringValue(item['image'] ?? item['image_link']);
    final imageUri = Uri.tryParse(rawImage);
    final imageUrl = imageUri?.host == 'forex-images.instaforex.com'
        ? imageUri!.replace(host: 'forex-images.ifxdb.com').toString()
        : rawImage;
    final title = _stringValue(item['title']);
    final description = _stringValue(item['text'] ?? item['description']);

    return PromoMaterialModel(
      title: title.isEmpty ? _displayTitle(key) : title,
      description: description,
      imageUrl: imageUrl,
      link: _stringValue(item['link']),
      buttonText: _stringValue(item['button_text']).isEmpty
          ? 'View Promo'
          : _stringValue(item['button_text']),
      buttonColor: _stringValue(item['button_color']),
    );
  }

  static String _stringValue(dynamic value) => value?.toString().trim() ?? '';

  static String _normalizeJsonLiterals(String value) {
    const replacements = {'True': 'true', 'False': 'false', 'None': 'null'};
    final normalized = StringBuffer();
    var inString = false;
    var escaped = false;

    for (var index = 0; index < value.length; index++) {
      final character = value[index];
      if (inString) {
        normalized.write(character);
        if (escaped) {
          escaped = false;
        } else if (character == r'\') {
          escaped = true;
        } else if (character == '"') {
          inString = false;
        }
        continue;
      }

      if (character == '"') {
        inString = true;
        normalized.write(character);
        continue;
      }

      final previous = index == 0 ? '' : value[index - 1];
      var replaced = false;
      for (final entry in replacements.entries) {
        final end = index + entry.key.length;
        if (value.startsWith(entry.key, index) &&
            !_isWordCharacter(previous) &&
            (end == value.length || !_isWordCharacter(value[end]))) {
          normalized.write(entry.value);
          index = end - 1;
          replaced = true;
          break;
        }
      }
      if (!replaced) normalized.write(character);
    }

    return normalized.toString();
  }

  static bool _isWordCharacter(String character) =>
      character.isNotEmpty && RegExp(r'[A-Za-z0-9_]').hasMatch(character);

  static String _displayTitle(String key) => key
      .split(RegExp(r'[_\s]+'))
      .where((word) => word.isNotEmpty)
      .map(
        (word) => '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
      )
      .join(' ');
}
