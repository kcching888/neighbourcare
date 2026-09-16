
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';

import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import '../widgets/top_banner_widget.dart';
import 'login_page.dart';

import '../services/local_savings_service.dart';

class LocalSavingsPage extends StatefulWidget {
  const LocalSavingsPage({super.key});

  @override
  State<LocalSavingsPage> createState() => _LocalSavingsPageState();
}

class _LocalSavingsPageState extends State<LocalSavingsPage> {
  String _selectedCategory = 'All';
  String _searchText = '';

  final LocalSavingsService _localSavingsService = LocalSavingsService();

  late Future<List<LocalDeal>> _dealsFuture;

  @override
  void initState() {
    super.initState();
    _dealsFuture = _localSavingsService.fetchDeals();
  }

  String _categoryLabel(BuildContext context, String category) {
    final l = AppLocalizations.of(context)!;
    switch (category) {
      case 'All':
        return l.filterAll;
      case 'Chicken':
        return l.categoryChicken;
      case 'Beef':
        return l.categoryBeef;
      case 'Pork':
        return l.categoryPork;
      case 'Fish':
        return l.categoryFish;
      case 'Breakfast':
        return l.categoryBreakfast;
      case 'Dairy':
        return l.categoryDairy;
      case 'Other':
        return l.categoryOther;
      default:
        return category;
    }
  }

  Future<void> _refreshDeals() async {
    setState(() {
      _dealsFuture = _localSavingsService.fetchDeals();
    });

    await _dealsFuture;
  }

  @override
  Widget build(BuildContext context) {

    final t = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      
      appBar: TopBannerWidget(
      title: t.localSavings,
      fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) {
          localeProvider.setLocale(locale);
        },
        onFontScaleChanged: (scale) {
          fontSizeProvider.setScaleFactor(scale);
        },
      onRefresh: _refreshDeals, // Triggers _refresh() on TrafficPage
      onSignInPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
     ),
      body: FutureBuilder<List<LocalDeal>>(
        future: _dealsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SelectableText(
                  AppLocalizations.of(context)!.localSavingsCouldNotUpdate(snapshot.error.toString()),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 19),
                ),
              ),
            );
          }

          final allDeals = (snapshot.data ?? []).where((deal) {
            return deal.priceLabel.trim().isNotEmpty;
          }).toList();

          final filteredDeals = allDeals.where((deal) {
            final matchesCategory =
                _selectedCategory == 'All' || deal.category == _selectedCategory;

            final search = _searchText.trim().toLowerCase();

            final matchesSearch = search.isEmpty ||
                deal.store.toLowerCase().contains(search) ||
                deal.item.toLowerCase().contains(search) ||
                deal.category.toLowerCase().contains(search);

            return matchesCategory && matchesSearch;
          }).toList();

          final featuredDeals = allDeals
              .where((deal) => deal.hasVerifiedSavings)
              .toList()
            ..sort(
              (a, b) => b.percentSaved.compareTo(a.percentSaved),
            );

          return RefreshIndicator(
            onRefresh: _refreshDeals,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  AppLocalizations.of(context)!.saveOnGroceriesTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF092C4C),
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  AppLocalizations.of(context)!.liveDealsSubtitle,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  style: const TextStyle(fontSize: 19),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchByProductOrStore,
                    hintStyle: TextStyle(fontSize: 19, color: Colors.grey.shade600),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _SectionTitle(
                  title: AppLocalizations.of(context)!.bestDealsThisWeek,
                  subtitle: AppLocalizations.of(context)!.rankedByVerifiedSavings,
                ),
                const SizedBox(height: 12),
                if (featuredDeals.isEmpty)
                  _EmptyDealsCard(
                    message: AppLocalizations.of(context)!.noVerifiedPriceReductions,
                  )
                else
                  ...featuredDeals.take(5).map(
                        (deal) => _FeaturedDealCard(deal: deal),
                      ),
                const SizedBox(height: 28),
                _SectionTitle(
                  title: AppLocalizations.of(context)!.browseGroceryDeals,
                  subtitle: '${filteredDeals.length} live deal'
                      '${filteredDeals.length == 1 ? '' : 's'} shown',
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      'All',
                      'Chicken',
                      'Beef',
                      'Pork',
                      'Fish',
                      'Breakfast',
                      'Dairy',
                      'Other',
                    ].map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(
                            _categoryLabel(context, category),
                            style: const TextStyle(fontSize: 18),
                          ),
                          selected: _selectedCategory == category,
                          selectedColor: const Color(0xFFA8D9D2),
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                if (filteredDeals.isEmpty)
                  _EmptyDealsCard(
                    message: AppLocalizations.of(context)!.noActiveDealsMatch,
                  )
                else
                  ...filteredDeals.map(
                    (deal) => _DealCard(deal: deal),
                  ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.pricesTermsMayChange,
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.4,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF092C4C),
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _FeaturedDealCard extends StatelessWidget {
  final LocalDeal deal;

  const _FeaturedDealCard({
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                deal.imagePath,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110,
                    height: 110,
                    color: deal.accentColor.withValues(alpha: 0.12),
                    child: Icon(
                      Icons.local_offer_outlined,
                      color: deal.accentColor,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/stores/${deal.store.toLowerCase().replaceAll(' ', '_')}.png',
                        height: 28,
                        width: 48,
                        fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: 48,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.storefront,
                                size: 26,
                                color: deal.accentColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          deal.store,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: deal.accentColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deal.item,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF172033),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        deal.priceLabel,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF172033),
                        ),
                      ),
                      if (deal.units != null && deal.units!.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Text(
                          deal.units!,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (deal.regularPrice != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      AppLocalizations.of(context)!.regularPriceValue(deal.regularPrice!.toStringAsFixed(2)),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey.shade700,
                        fontSize: 17,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  _SavingsBadge(
                    text: deal.savingsLabel,
                    color: deal.accentColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deal.expiryLabel,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DealCard extends StatelessWidget {
  final LocalDeal deal;

  const _DealCard({
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: const Color(0xFFFFFFFF),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  deal.imagePath,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 110,
                      height: 110,
                      color: deal.accentColor.withValues(alpha: 0.12),
                      child: Icon(
                        Icons.local_offer_outlined,
                        color: deal.accentColor,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/stores/${deal.store.toLowerCase().replaceAll(' ', '_')}.png',
                          height: 28,
                          width: 48,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              width: 48,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.storefront,
                                  size: 26,
                                  color: deal.accentColor,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            deal.store,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: deal.accentColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deal.item,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFF172033),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          deal.priceLabel,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF172033),
                          ),
                        ),
                        if (deal.units != null && deal.units!.isNotEmpty) ...[
                          const SizedBox(width: 6),
                          Text(
                            deal.units!,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (deal.regularPrice != null && deal.regularPrice! > 0) ...[
                      const SizedBox(height: 3),
                      Text(
                        AppLocalizations.of(context)!.regularPriceValue(deal.regularPrice!.toStringAsFixed(2)),
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade700,
                          fontSize: 17,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    _SavingsBadge(
                      text: deal.savingsLabel,
                      color: deal.accentColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      deal.expiryLabel,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavingsBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _SavingsBadge({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _EmptyDealsCard extends StatelessWidget {
  final String message;

  const _EmptyDealsCard({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.search_off_outlined,
              size: 38,
              color: Color(0xFF0C7A6C),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 19),
            ),
          ],
        ),
      ),
    );
  }
}