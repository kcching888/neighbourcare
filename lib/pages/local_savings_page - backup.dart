import 'package:flutter/material.dart';

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

Future<void> _refreshDeals() async {
  setState(() {
    _dealsFuture = _localSavingsService.fetchDeals();
  });

  await _dealsFuture;
}

  final List<_SampleDeal> _deals = [
    _SampleDeal(
      store: 'Giant Tiger',
      item: 'Gold Label Smoke House Bacon',
      imagePath: 'assets/images/deals/bacon.png',
      salePrice: 3.97,
      regularPrice: 7.97,
      details: 'Direct price discount',
      expires: 'Expires Sep 2',
      category: 'Breakfast',
      accentColor: const Color(0xFFB54708),
    ),
    _SampleDeal(
      store: 'Walmart',
      item: 'Natrel Lactose-Free Milk',
      imagePath: 'assets/images/deals/milk.png',
      salePrice: 4.98,
      regularPrice: 6.38,
      details: 'Rollback',
      expires: 'Expires Sep 17',
      category: 'Dairy',
      accentColor: const Color(0xFF265AA6),
    ),
    _SampleDeal(
      store: 'M&M Food Market',
      item: 'Boneless Skinless Chicken Breasts',
      imagePath: 'assets/images/deals/chicken_breast.png',
      salePrice: 29.99,
      regularPrice: 39.99,
      details: 'Direct price discount',
      expires: 'Expires Sep 3',
      category: 'Chicken',
      accentColor: const Color(0xFF0C7A6C),
    ),
    _SampleDeal(
      store: 'FreshCo',
      item: 'Dairyland Butter, 454 g',
      imagePath: 'assets/images/deals/butter.png',
      salePrice: 4.99,
      regularPrice: 0,
      details: 'Scene+ member pricing',
      expires: 'Expires Sep 3',
      category: 'Dairy',
      accentColor: const Color(0xFF6A3EA1),
    ),
    _SampleDeal(
      store: 'No Frills',
      item: 'Pork Combo Chops',
      imagePath: 'assets/images/deals/pork_chops.png',
      salePrice: 2.99,
      regularPrice: 0,
      details: 'Save 45%',
      expires: 'Expires Sep 3',
      category: 'Pork',
      accentColor: const Color(0xFF8A5A00),
    ),
    _SampleDeal(
      store: 'IGA',
      item: 'Fresh Atlantic Salmon Fillets',
      imagePath: 'assets/images/deals/salmon.png',
      salePrice: 2.99,
      regularPrice: 0,
      details: 'Price per 100 g',
      expires: 'Expires Sep 3',
      category: 'Fish',
      accentColor: const Color(0xFF176B87),
    ),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF092C4C),
        foregroundColor: Colors.white,
        title: const Text(
          'Local Savings',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
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
        'Local Savings could not be updated:\n\n${snapshot.error}',
        textAlign: TextAlign.center,
      ),
    ),
  );
}

    final allDeals = snapshot.data ?? [];

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
            'Save on groceries in Calgary',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF092C4C),
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Live deals from participating local stores. '
            'Pull down to refresh.',
            style: TextStyle(
              color: Colors.grey.shade700,
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
            decoration: InputDecoration(
              hintText: 'Search by product or store',
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
            title: 'Best deals this week',
            subtitle: 'Ranked by verified percentage saved',
          ),
          const SizedBox(height: 12),
          if (featuredDeals.isEmpty)
            const _EmptyDealsCard(
              message: 'No verified price reductions are active right now.',
            )
          else
            ...featuredDeals.take(5).map(
              (deal) => _FeaturedDealCard(deal: deal),
            ),
          const SizedBox(height: 28),
          _SectionTitle(
            title: 'Browse grocery deals',
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
                    label: Text(category),
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
            const _EmptyDealsCard(
              message: 'No active deals match this search or category.',
            )
          else
            ...filteredDeals.map(
              (deal) => _DealCard(deal: deal),
            ),
          const SizedBox(height: 16),
          Text(
            'Prices, stock, membership requirements, and promotion terms may '
            'change. Confirm directly with the store before visiting.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.grey.shade600,
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

class _SampleDeal {
  final String store;
  final String item;
  final double salePrice;
  final double regularPrice;
  final String details;
  final String expires;
  final String category;
  final Color accentColor;
  final String imagePath;

  const _SampleDeal({
    required this.store,
    required this.item,
    required this.salePrice,
    required this.regularPrice,
    required this.details,
    required this.expires,
    required this.category,
    required this.accentColor,
    required this.imagePath,
  });

  bool get hasVerifiedSavings => regularPrice > salePrice;

  double get dollarSaved => regularPrice - salePrice;

  int get percentSaved {
    if (!hasVerifiedSavings) {
      return 0;
    }

    return ((dollarSaved / regularPrice) * 100).round();
  }

  String get priceLabel => '\$${salePrice.toStringAsFixed(2)}';

  String get savingsLabel {
    if (!hasVerifiedSavings) {
      return details;
    }

    return 'Save \$${dollarSaved.toStringAsFixed(2)} · $percentSaved% off';
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
              ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 13,
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
                    width: 72,
                    height: 72,
                    color: deal.accentColor.withValues(alpha: 0.12),
                    child: Icon(
                      Icons.local_offer_outlined,
                      color: deal.accentColor,
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
                  Text(
                    deal.store,
                    style: TextStyle(
                      color: deal.accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    deal.item,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deal.priceLabel,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (deal.regularPrice != null) ...[
  const SizedBox(height: 2),
  Text(
    'Regular price \$${deal.regularPrice!.toStringAsFixed(2)}',
    style: TextStyle(
      decoration: TextDecoration.lineThrough,
      color: Colors.grey.shade600,
      fontSize: 12,
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
                      color: Colors.grey.shade600,
                      fontSize: 12,
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
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 180,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                deal.imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: deal.accentColor.withValues(alpha: 0.16),
                  );
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.0, 0.48, 0.74, 1.0],
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFDFDFD),
                      Color(0x80FFFFFF),
                      Color(0x12FFFFFF),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal.store,
                            style: TextStyle(
                              color: deal.accentColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            deal.item,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF172033),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            deal.priceLabel,
                            style: const TextStyle(
                              color: Color(0xFF172033),
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 7),
                          _SavingsBadge(
                            text: deal.savingsLabel,
                            color: deal.accentColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            deal.expiryLabel,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.82),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color: deal.accentColor,
                        ),
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
          fontSize: 12,
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
            ),
          ],
        ),
      ),
    );
  }
}

class _DealsLoadError extends StatelessWidget {
  final Future<void> Function() onRetry;

  const _DealsLoadError({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 46,
              color: Color(0xFF0C7A6C),
            ),
            const SizedBox(height: 12),
            const Text(
              'Local Savings could not be updated.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}