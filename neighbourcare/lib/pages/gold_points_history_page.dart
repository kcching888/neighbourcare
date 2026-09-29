import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/gold_point_log.dart';
import '../services/auth_service.dart';

class GoldPointsHistoryPage extends StatefulWidget {
  const GoldPointsHistoryPage({super.key});

  @override
  State<GoldPointsHistoryPage> createState() => _GoldPointsHistoryPageState();
}

class _GoldPointsHistoryPageState extends State<GoldPointsHistoryPage> {
  late Future<List<GoldPointLog>> _logsFuture;

  @override
  void initState() {
    super.initState();
    _logsFuture = _fetchLogs();
  }

  Future<List<GoldPointLog>> _fetchLogs() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = authService.userId;

    if (userId == null) return [];

    final response = await supabase
        .from('gold_point_logs')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => GoldPointLog.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> _refreshData() async {
    setState(() {
      _logsFuture = _fetchLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final goldBalance = context.watch<AuthService>().goldPoint;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gold Points History'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            // Current Balance Header Card
            _buildBalanceCard(goldBalance),
            const Divider(height: 1),

            // History List
            Expanded(
              child: FutureBuilder<List<GoldPointLog>>(
                future: _logsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Failed to load history: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final logs = snapshot.data ?? [];

                  if (logs.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 100),
                        Center(
                          child: Text(
                            'No points history yet.',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: logs.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber.shade100,
                          child: Text(
                            log.displayIcon,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        title: Text(
                          log.displayReason,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          _formatDate(log.createdAt),
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        trailing: Text(
                          '+${log.amount} Gold',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(int balance) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.amber.shade700, Colors.amber.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Total Balance',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.stars, color: Colors.white, size: 32),
                const SizedBox(width: 8),
                Text(
                  '$balance',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Gold',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final year = dt.year;
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }
}