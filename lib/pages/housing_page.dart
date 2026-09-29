import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';


import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import '../l10n/app_localizations.dart';
import '../widgets/top_banner_widget.dart';
import 'login_page.dart';


class HousingPage extends StatefulWidget {
  const HousingPage({super.key});

  @override
  State<HousingPage> createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  // Uri declarations and _openExternalLink helper move inside _HousingPageState

  final Uri _myTaxUri = Uri.parse(
    'https://mytax.calgary.ca/',
  );

  final Uri _housingTrendsUri = Uri.parse(
    'https://www.calgary.ca/communities/housing-in-calgary/'
    'housing-research/housing-trends.html',
  );

  final Uri _developmentMapUri = Uri.parse(
    'https://developmentmap.calgary.ca/',
  );

  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 600));
    

if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.housingDataRefreshed),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

Future<void> _openExternalLink(BuildContext context, Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.couldNotLaunchUrl(uri.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),

    appBar: TopBannerWidget(
      title: t.housingAndDevelopment,
      fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) {
          localeProvider.setLocale(locale);
        },
        onFontScaleChanged: (scale) {
          fontSizeProvider.setScaleFactor(scale);
        },
      onRefresh: () => _refresh(context), // Triggers _refresh() on TrafficPage
      onSignInPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
    ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          //const _HousingBanner(),
          const SizedBox(height: 18),

          _PageIntro(
            title: AppLocalizations.of(context)!.calgaryHousingInfoTitle,
            description:
                AppLocalizations.of(context)!.housingInfoDescription,
          ),
          const SizedBox(height: 18),

          const _HousingSnapshotCard(),
          const SizedBox(height: 16),

          _HousingChartsCard(
            onOpenSource: () {
              _openExternalLink(
                context,
                _housingTrendsUri,
              );
            },
          ),
          const SizedBox(height: 16),

          _AssessmentLookupCard(
            onOpenMyTax: () {
              _openExternalLink(
                context,
                _myTaxUri,
              );
            },
          ),
          const SizedBox(height: 16),

          _DevelopmentNearYouCard(
            onOpenOfficialMap: () {
              _openExternalLink(
                context,
                _developmentMapUri,
              );
            },
          ),
          const SizedBox(height: 22),

          Text(
            AppLocalizations.of(context)!.dataSourcesLabel,
            style: TextStyle(
              color: Color(0xFF092C4C),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            AppLocalizations.of(context)!.housingDataSourcesText,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _HousingBanner extends StatelessWidget {
  const _HousingBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF092C4C),
            Color(0xFF1E4C7A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF092C4C).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.home_work_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.calgaryHousingPortalTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  AppLocalizations.of(context)!.marketMetricsSubtitle,
                  style: TextStyle(
                    color: Color(0xFFD0E2FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIntro extends StatelessWidget {
  final String title;
  final String description;

  const _PageIntro({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF092C4C),
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 7),
        Text(
          description,
          style: TextStyle(
            color: Colors.grey.shade700,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _HousingSnapshotCard extends StatelessWidget {
  const _HousingSnapshotCard();

  @override
  Widget build(BuildContext context) {
    return _HousingSectionCard(
      icon: Icons.apartment_outlined,
      accentColor: const Color(0xFF6A3EA1),
      backgroundColor: const Color(0xFFF4EEFF),
      title: AppLocalizations.of(context)!.calgaryHousingSnapshotTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.rentalVacancyRateLabel,
            style: const TextStyle(
              color: Color(0xFF475467),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '5.1%',
            style: TextStyle(
              color: Color(0xFF6A3EA1),
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.vacancyRate2025Note,
            style: const TextStyle(
              color: Color(0xFF344054),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          _InfoNote(
            icon: Icons.info_outline,
            text:
                AppLocalizations.of(context)!.vacancyRateExplainer,
          ),
        ],
      ),
    );
  }
}

class _HousingChartsCard extends StatelessWidget {
  final VoidCallback onOpenSource;

  const _HousingChartsCard({
    required this.onOpenSource,
  });

  static const _vacancyRates = [
    _VacancyDataPoint(year: '2023', rate: 1.4),
    _VacancyDataPoint(year: '2024', rate: 4.6),
    _VacancyDataPoint(year: '2025', rate: 5.1),
  ];

  static const _priceChanges = [
    _PriceChange(
      label: 'Detached',
      percent: -1.0,
      color: Color(0xFF265AA6),
    ),
    _PriceChange(
      label: 'Semi-detached',
      percent: -4.9,
      color: Color(0xFF6A3EA1),
    ),
    _PriceChange(
      label: 'Row / townhouse',
      percent: -2.7,
      color: Color(0xFF0C7A6C),
    ),
    _PriceChange(
      label: 'Apartment',
      percent: -5.4,
      color: Color(0xFFB54708),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _HousingSectionCard(
      icon: Icons.show_chart,
      accentColor: const Color(0xFF265AA6),
      backgroundColor: const Color(0xFFEFF4FF),
      title: AppLocalizations.of(context)!.marketPriceTrendsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.rentalAvailabilityChangesNote,
            style: TextStyle(
              color: Color(0xFF344054),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          Text(
            AppLocalizations.of(context)!.rentalMarketVacancyRateTitle,
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.calgaryMarketVacancyRateLabel,
            style: TextStyle(
              color: Color(0xFF667085),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 210,
            child: RepaintBoundary(
              child: _VacancyLineChart(
                data: _vacancyRates,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.vacancyRateIncreaseNote,
            style: TextStyle(
              color: Color(0xFF667085),
              fontSize: 12,
              height: 1.4,
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 22),
            child: Divider(
              color: Color(0xFFD0D5DD),
              height: 1,
            ),
          ),

          Text(
            AppLocalizations.of(context)!.medianHomePricesTitle,
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.yoyChangeQ22026,
            style: TextStyle(
              color: Color(0xFF667085),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 220,
            child: RepaintBoundary(
              child: _HomePriceBarChart(
                data: _priceChanges,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _InfoNote(
            icon: Icons.info_outline,
            text: AppLocalizations.of(context)!.citywideMedianPriceNote,
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onOpenSource,
            icon: const Icon(Icons.open_in_new, size: 17),
            label: Text(AppLocalizations.of(context)!.viewCityHousingTrends),
          ),
        ],
      ),
    );
  }
}

class _VacancyLineChart extends StatelessWidget {
  final List<_VacancyDataPoint> data;

  const _VacancyLineChart({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        minY: 0,
        maxY: 6,
        clipData: const FlClipData.all(),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color(0xFFDDE5EE),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 34,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value > 6 || value != value.roundToDouble()) {
                  return const SizedBox.shrink();
                }

                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    '${value.toInt()}%',
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();

                if (index < 0 || index >= data.length || value != index) {
                  return const SizedBox.shrink();
                }

                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    data[index].year,
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var index = 0; index < data.length; index++)
                FlSpot(index.toDouble(), data[index].rate),
            ],
            isCurved: true,
            curveSmoothness: 0.28,
            color: const Color(0xFF265AA6),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 5,
                  color: Colors.white,
                  strokeWidth: 3,
                  strokeColor: const Color(0xFF265AA6),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF265AA6).withValues(alpha: 0.12),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) {
              return spots.map((spot) {
                final point = data[spot.x.toInt()];

                return LineTooltipItem(
                  '${point.year}\n${point.rate.toStringAsFixed(1)}%',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

class _HomePriceBarChart extends StatelessWidget {
  final List<_PriceChange> data;

  const _HomePriceBarChart({
    required this.data,
  });

  String _priceLabel(BuildContext context, String label) {
    final l = AppLocalizations.of(context)!;
    switch (label) {
      case 'Detached':
        return l.housingTypeDetached;
      case 'Semi-detached':
        return l.housingTypeSemiDetached;
      case 'Row / townhouse':
        return l.housingTypeRowTownhouse;
      case 'Apartment':
        return l.housingTypeApartment;
      default:
        return label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        minY: -6,
        maxY: 1,
        baselineY: 0,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: value == 0
                  ? const Color(0xFF667085)
                  : const Color(0xFFDDE5EE),
              strokeWidth: value == 0 ? 1.4 : 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value < -6 ||
                    value > 1 ||
                    value != value.roundToDouble()) {
                  return const SizedBox.shrink();
                }

                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    '${value.toInt()}%',
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();

                if (index < 0 || index >= data.length || value != index) {
                  return const SizedBox.shrink();
                }

                return SideTitleWidget(
                  meta: meta,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      _priceLabel(context, data[index].label),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var index = 0; index < data.length; index++)
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data[index].percent,
                  width: 25,
                  color: data[index].color,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(4),
                  ),
                ),
              ],
            ),
        ],
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final item = data[group.x];

              return BarTooltipItem(
                '${_priceLabel(context, item.label)}\n${item.percent.toStringAsFixed(1)}%',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VacancyDataPoint {
  final String year;
  final double rate;

  const _VacancyDataPoint({
    required this.year,
    required this.rate,
  });
}

class _PriceChange {
  final String label;
  final double percent;
  final Color color;

  const _PriceChange({
    required this.label,
    required this.percent,
    required this.color,
  });
}

class _AssessmentLookupCard extends StatelessWidget {
  final VoidCallback onOpenMyTax;

  const _AssessmentLookupCard({
    required this.onOpenMyTax,
  });

  @override
  Widget build(BuildContext context) {
    return _HousingSectionCard(
      icon: Icons.manage_search_outlined,
      accentColor: const Color(0xFF0C7A6C),
      backgroundColor: const Color(0xFFE7F4F1),
      title: AppLocalizations.of(context)!.assessedValueLookupTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.findAssessedValueNote,
            style: TextStyle(
              color: Color(0xFF344054),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 9),
          _InfoNote(
            icon: Icons.info_outline,
            text: AppLocalizations.of(context)!.assessedValueExplainer,
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: onOpenMyTax,
            icon: const Icon(Icons.open_in_new),
            label: Text(AppLocalizations.of(context)!.openCalgaryMyTax),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0C7A6C),
              side: const BorderSide(
                color: Color(0xFF0C7A6C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DevelopmentNearYouCard extends StatelessWidget {
  final VoidCallback onOpenOfficialMap;

  const _DevelopmentNearYouCard({
    required this.onOpenOfficialMap,
  });

  @override
  Widget build(BuildContext context) {
    return _HousingSectionCard(
      icon: Icons.location_city_outlined,
      accentColor: const Color(0xFFB54708),
      backgroundColor: const Color(0xFFFFF1E8),
      title: AppLocalizations.of(context)!.developmentNearYouTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.newestApplicationsNote,
            style: TextStyle(
              color: Color(0xFF344054),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          _InfoNote(
            icon: Icons.location_on_outlined,
            text: AppLocalizations.of(context)!.locationRadiusNote,
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFF0D2BF),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.schedule_outlined,
                  color: Color(0xFFB54708),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.permitFeedComingNext,
                    style: TextStyle(
                      color: Color(0xFF344054),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          TextButton.icon(
            onPressed: onOpenOfficialMap,
            icon: const Icon(Icons.map_outlined, size: 17),
            label: Text(AppLocalizations.of(context)!.openCalgaryDevelopmentMap),
          ),
        ],
      ),
    );
  }
}

class _HousingSectionCard extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final Color backgroundColor;
  final String title;
  final Widget child;

  const _HousingSectionCard({
    required this.icon,
    required this.accentColor,
    required this.backgroundColor,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 11),
          child,
        ],
      ),
    );
  }
}

class _InfoNote extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoNote({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF667085),
          size: 17,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF667085),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}