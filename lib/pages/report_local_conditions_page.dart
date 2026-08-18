import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        const SnackBar(content: Text('Please sign in before posting.')),
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
        const SnackBar(content: Text('Weather update published.')),
      );
    } on PostgrestException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not publish: ${error.message}')),
      );
    } finally {
      if (mounted) setState(() => _isPublishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report local conditions')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Share current local conditions. For an immediate emergency, call 911.',
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Alert type',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category == 'diy'
                            ? 'DIY & Home'
                            : '${category[0].toUpperCase()}${category.substring(1)}',
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
                decoration: const InputDecoration(
                  labelText: 'Neighbourhood',
                  hintText: 'Example: Beltline',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a neighbourhood.'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                maxLength: 120,
                decoration: const InputDecoration(
                  labelText: 'What is happening?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().length < 3
                    ? 'Enter at least 3 characters.'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                minLines: 4,
                maxLines: 8,
                maxLength: 2000,
                decoration: const InputDecoration(
                  labelText: 'Local update',
                  hintText: 'Share factual, current conditions.',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().length < 3
                    ? 'Enter at least 3 characters.'
                    : null,
              ),
              const SizedBox(height: 8),
              const Text(
                'Do not include home addresses, faces, licence plates, phone numbers, or other private information.',
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isPublishing ? null : _publish,
                child: Text(
                  _isPublishing ? 'Publishing…' : 'Publish report',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}