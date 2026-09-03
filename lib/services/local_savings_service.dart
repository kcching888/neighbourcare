import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

class LocalDeal {
  final String keyword;
  final String store;
  final String item;
  final double? salePrice;
  final double? regularPrice;
  final String offerDetails;
  final String productDescription;
  final DateTime? validFrom;
  final DateTime? validUntil;

  const LocalDeal({
    required this.keyword,
    required this.store,
    required this.item,
    required this.salePrice,
    required this.regularPrice,
    required this.offerDetails,
    required this.productDescription,
    required this.validFrom,
    required this.validUntil,
  });

  bool get hasPrice => salePrice != null;

  bool get hasVerifiedSavings {
    return salePrice != null &&
        regularPrice != null &&
        regularPrice! > salePrice!;
  }

  double get dollarSaved {
    if (!hasVerifiedSavings) {
      return 0;
    }

    return regularPrice! - salePrice!;
  }

  int get percentSaved {
    if (!hasVerifiedSavings) {
      return 0;
    }

    return ((dollarSaved / regularPrice!) * 100).round();
  }

  bool get isActive {
    final now = DateTime.now().toUtc();

    if (item.trim().isEmpty || store.trim().isEmpty) {
      return false;
    }

    if (validFrom != null && now.isBefore(validFrom!)) {
      return false;
    }

    if (validUntil != null && now.isAfter(validUntil!)) {
      return false;
    }

    return true;
  }

  String get category {
    final value = keyword.toLowerCase();

    if (value.contains('chicken')) return 'Chicken';
    if (value.contains('beef')) return 'Beef';
    if (value.contains('pork')) return 'Pork';
    if (value.contains('salmon') || value.contains('fish')) return 'Fish';
    if (value.contains('bacon')) return 'Breakfast';
    if (value.contains('milk') || value.contains('butter')) return 'Dairy';

    return 'Other';
  }

  Color get accentColor {
  switch (category) {
    case 'Chicken':
      return const Color(0xFF0C7A6C);

    case 'Beef':
      return const Color(0xFF8A3B12);

    case 'Pork':
      return const Color(0xFF8A5A00);

    case 'Fish':
      return const Color(0xFF176B87);

    case 'Breakfast':
      return const Color(0xFFB54708);

    case 'Dairy':
      return const Color(0xFF265AA6);

    default:
      return const Color(0xFF5B667A);
  }
}

  String get imagePath {
  final value = keyword.toLowerCase();

  if (value.contains('chicken')) {
    return 'assets/images/deals/chicken.png';
  }

  if (value.contains('ground beef') || value.contains('beef')) {
    return 'assets/images/deals/ground_beef.png';
  }

  if (value.contains('pork')) {
    return 'assets/images/deals/pork_chops.png';
  }

  if (value.contains('salmon')) {
    return 'assets/images/deals/salmon.png';
  }

  if (value.contains('bacon')) {
    return 'assets/images/deals/bacon.png';
  }

  if (value.contains('butter')) {
    return 'assets/images/deals/butter.png';
  }

  if (value.contains('milk')) {
    return 'assets/images/deals/milk.png';
  }

  if (value.contains('peanut butter')) {
    return 'assets/images/deals/peanut_butter.png';
  }

  if (value.contains('olive oil')) {
    return 'assets/images/deals/olive_oil.png';
  }

  if (value.contains('pasta')) {
    return 'assets/images/deals/pasta.png';
  }

  if (value.contains('cracker')) {
    return 'assets/images/deals/crackers.png';
  }

  return 'assets/images/deals/grocery_default.png';
}

  String get priceLabel {
    if (salePrice == null) {
      return 'See store for price';
    }

    return '\$${salePrice!.toStringAsFixed(2)}';
  }

  String get savingsLabel {
    if (hasVerifiedSavings) {
      return 'Save \$${dollarSaved.toStringAsFixed(2)} · $percentSaved% off';
    }

    return offerDetails.isEmpty ? 'Store offer' : offerDetails;
  }

  String get expiryLabel {
    if (validUntil == null) {
      return 'Expiry date unavailable';
    }

    final local = validUntil!.toLocal();

    return 'Expires ${_monthName(local.month)} ${local.day}';
  }

  static String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }
}

class LocalSavingsService {
  static const _csvUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRGXos68kDArKCTMnBsppvgDh1Q0A4CMAL4vI7OYrebXw44Oq2DcyiHnVbTEXe7USa6lzGTLdyTPYCw/pub?gid=0&single=true&output=csv';

  Future<List<LocalDeal>> fetchDeals() async {
    final response = await http.get(Uri.parse(_csvUrl));

    if (response.statusCode != 200) {
      throw Exception('Could not load Local Savings deals.');
    }

    final decodedBody = utf8.decode(response.bodyBytes);

    final rows = const CsvToListConverter(
      shouldParseNumbers: false,
    ).convert(decodedBody);

    if (rows.length < 2) {
      return [];
    }

    final headers = rows.first
        .map((value) => value.toString().trim())
        .toList();

    final deals = rows
        .skip(1)
        .map(
          (row) => _dealFromRow(
            headers: headers,
            row: row.map((value) => value.toString()).toList(),
          ),
        )
        .whereType<LocalDeal>()
        .where((deal) => deal.isActive)
        .toList();

    deals.sort((a, b) {
      if (a.hasVerifiedSavings && !b.hasVerifiedSavings) {
        return -1;
      }

      if (!a.hasVerifiedSavings && b.hasVerifiedSavings) {
        return 1;
      }

      return b.percentSaved.compareTo(a.percentSaved);
    });

    return deals;
  }

  LocalDeal? _dealFromRow({
    required List<String> headers,
    required List<String> row,
  }) {
    String valueFor(String header) {
      final index = headers.indexOf(header);

      if (index == -1 || index >= row.length) {
        return '';
      }

      return _decodeHtml(row[index]).trim();
    }

    final keyword = valueFor('Keyword Searched');
    final store = valueFor('Store');
    final item = valueFor('Item Name');

    if (store.isEmpty || item.isEmpty) {
      return null;
    }

    return LocalDeal(
      keyword: keyword,
      store: store,
      item: item,
      salePrice: _parsePrice(valueFor('Sale Price')),
      regularPrice: _parsePrice(valueFor('Regular Price')),
      offerDetails: valueFor('Points / Offer Details'),
      productDescription: valueFor('Product Description'),
      validFrom: DateTime.tryParse(valueFor('Valid From'))?.toUtc(),
      validUntil: DateTime.tryParse(valueFor('Valid Until'))?.toUtc(),
    );
  }

  double? _parsePrice(String value) {
    final normalized = value
        .replaceAll('\$', '')
        .replaceAll(',', '')
        .trim();

    if (normalized.isEmpty ||
        normalized.toLowerCase() == 'not listed') {
      return null;
    }

    return double.tryParse(normalized);
  }

  String _decodeHtml(String value) {
    return value
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");
  }
}