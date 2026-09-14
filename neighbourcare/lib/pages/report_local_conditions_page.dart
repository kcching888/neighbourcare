import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

import '../widgets/top_banner_widget.dart';

class ReportLocalConditionsPage extends StatefulWidget {
  final String initialCategory;

  const ReportLocalConditionsPage({
    super.key,
    this.initialCategory = 'weather',
  });

  @override
  State<ReportLocalConditionsPage> createState() =>
      _ReportLocalConditionsPageState();
}

class _ReportLocalConditionsPageState
    extends State<ReportLocalConditionsPage> {
  final _formKey = GlobalKey<FormState>();
  final _neighbourhoodController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

final _categories = const [
  'weather',
  'dining',
  'diy',
];

  late String _selectedCategory;
  bool _isPublishing = false;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    _neighbourhoodController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    if (!_formKey.currentState!.validate()) return;

    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.signInBeforePosting)),
      );
      return;
    }

    setState(() => _isPublishing = true);

    try {
      await Supabase.instance.client.from('forumposts').insert({
        'author_id': user.id,
        'category': _selectedCategory,
        'alert_type': _selectedCategory,
        'neighbourhood': _neighbourhoodController.text.trim(),
        'title': _titleController.text.trim(),
        'content': _contentController.text.trim(),
      });

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.weatherUpdatePublished)),
      );
    } on PostgrestException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.couldNotPublish(error.message))),
      );
    } finally {
      if (mounted) setState(() => _isPublishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBannerWidget(title: AppLocalizations.of(context)!.reportLocalConditionsTitle),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                AppLocalizations.of(context)!.shareLocalConditionsWarning,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.alertTypeLabel,
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category == 'diy'
                            ? AppLocalizations.of(context)!.diyHome
                            : (category == 'weather' ? AppLocalizations.of(context)!.weather : AppLocalizations.of(context)!.dining),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCategory = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _neighbourhoodController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.neighbourhoodLabel,
                  hintText: AppLocalizations.of(context)!.neighbourhoodExampleHint,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? AppLocalizations.of(context)!.enterNeighbourhood
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                maxLength: 120,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.whatIsHappeningLabel,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().length < 3
                    ? AppLocalizations.of(context)!.enterAtLeast3Characters
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                minLines: 4,
                maxLines: 8,
                maxLength: 2000,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.localUpdateLabel,
                  hintText: AppLocalizations.of(context)!.shareFactualConditionsHint,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().length < 3
                    ? AppLocalizations.of(context)!.enterAtLeast3Characters
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.privacyReminderText,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isPublishing ? null : _publish,
                child: Text(
                  _isPublishing ? AppLocalizations.of(context)!.publishingEllipsis : AppLocalizations.of(context)!.publishReportButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}