import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'services/auth_service.dart';
import 'pages/auth_gate.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jvesmtshgajflaaxdxen.supabase.co',
    publishableKey: 'sb_publishable_1BOExDsqgxSmPv-RpJtNuw_5zvTl-A_',
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: const MyApp(),
    ),
  );
  //runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeighbourCare',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
       home: const AuthGate(),
       //home: const LoginPage(),
       //home: const ServicesBookingPage(),
       //home: const ProviderPortalPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


class SupabaseTestPage extends StatefulWidget {
  const SupabaseTestPage({super.key});

  @override
  State<SupabaseTestPage> createState() => _SupabaseTestPageState();
}

class _SupabaseTestPageState extends State<SupabaseTestPage> {
  bool loading = false;
  String message = 'Click the button to test Supabase.';

  Future<void> testSupabase() async {
    setState(() {
      loading = true;
      message = 'Connecting...';
    });

    try {
      final rows = await supabase
          .from('forum_posts')
          .select('id, title, category')
          .limit(5);

      setState(() {
        message = 'Connected successfully.\nRows returned: ${rows.length}';
      });
    } catch (error) {
      setState(() {
        message = 'Supabase error:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> loadMyBookings() async {
    // Implement your booking fetch logic here
  }

  Future<void> signOut() async {
    // Implement your Supabase sign out logic here
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeighbourCare Calgary'),
        actions: [
          IconButton(
            onPressed: loadMyBookings,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh bookings',
          ),
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.home_work_outlined,
                      size: 56,
                      color: Color(0xFF0C7A6C),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Supabase connection test',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: loading ? null : testSupabase,
                      child: loading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Test Supabase'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServicesBookingPage extends StatefulWidget {
  const ServicesBookingPage({super.key});

  @override
  State<ServicesBookingPage> createState() => _ServicesBookingPageState();
}

class _ServicesBookingPageState extends State<ServicesBookingPage> {
  final formKey = GlobalKey<FormState>();

  final categoryController = TextEditingController();
  final locationController = TextEditingController();
  final preferredTimeController = TextEditingController();
  final detailsController = TextEditingController();

  List<Map<String, dynamic>> bookings = [];

  bool loadingBookings = false;
  bool submitting = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    loadMyBookings();
  }

  @override
  void dispose() {
    categoryController.dispose();
    locationController.dispose();
    preferredTimeController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  Future<void> loadMyBookings() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        message = 'Please sign in before viewing your bookings.';
      });
      return;
    }

    setState(() {
      loadingBookings = true;
    });

    try {
      final result = await supabase
          .from('bookings')
          .select()
          .eq('client_id', user.id)
          .order('created_at', ascending: false);

      if (!mounted) return;

      setState(() {
        bookings = List<Map<String, dynamic>>.from(result);
        message = '';
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        message = 'Could not load bookings:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          loadingBookings = false;
        });
      }
    }
  }

  Future<void> submitBooking() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        message = 'Please sign in before submitting a booking.';
      });
      return;
    }

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      submitting = true;
      message = '';
    });

    try {
      final insertedBooking = await supabase
          .from('bookings')
          .insert({
            'client_id': user.id,
            'provider_id': null,
            'service_type': categoryController.text.trim(),
            'status': 'pending',
            'total_amount': 0,
            'location': locationController.text.trim(),
            'notes': detailsController.text.trim(),
            'preferred_time': preferredTimeController.text.trim(),
          })
          .select()
          .single();

      categoryController.clear();
      locationController.clear();
      preferredTimeController.clear();
      detailsController.clear();

      if (!mounted) return;

      setState(() {
        message =
            'Booking submitted successfully.\n'
            'Booking ID: ${insertedBooking['id']}';
      });

      await loadMyBookings();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        message = 'Could not submit booking:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          submitting = false;
        });
      }
    }
  }

  Future<void> signOut() async {
  try {
    await supabase.auth.signOut();
  } catch (error) {
    if (!mounted) return;

    setState(() {
      message = 'Could not sign out:\n$error';
    });
  }
}

  void openProviderPortal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ProviderPortalPage(),
      ),
    );
  }

  Widget buildBookingForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Book a home service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Describe the service you need in Calgary.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Service category',
                  hintText: 'Plumbing, furnace, snow removal...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a service category';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Neighbourhood or postal code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your location';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: preferredTimeController,
                decoration: const InputDecoration(
                  labelText: 'Preferred time',
                  hintText: 'Today 5–7 PM or Saturday morning',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: detailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Describe the issue',
                  hintText: 'Tell us what needs to be repaired or completed.',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Describe the issue';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: submitting ? null : submitBooking,
                  icon: submitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.send),
                  label: Text(
                    submitting ? 'Submitting...' : 'Submit booking',
                  ),
                ),
              ),

              if (message.isNotEmpty) ...[
                const SizedBox(height: 16),
                SelectableText(
                  message,
                  style: TextStyle(
                    color: message.startsWith('Could not')
                        ? Colors.red
                        : Colors.green.shade700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookingList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'My bookings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: loadingBookings ? null : loadMyBookings,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh bookings',
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (loadingBookings)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (bookings.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'No bookings yet. Submit your first service request.',
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final booking = bookings[index];

                  final serviceType =
                      booking['service_type']?.toString() ?? 'Service';

                  final location =
                      booking['location']?.toString() ?? 'Not provided';

                  final preferredTime =
                      booking['preferred_time']?.toString() ?? 'Not provided';

                  final notes =
                      booking['notes']?.toString() ?? '';

                  final status =
                      booking['status']?.toString() ?? 'pending';

                  final amount =
                      booking['total_amount']?.toString() ?? '0';

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      child: Icon(Icons.home_repair_service),
                    ),
                    title: Text(serviceType),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Location: $location\n'
                        'Preferred time: $preferredTime\n'
                        'Amount: \$${amount.isEmpty ? '0' : amount}'
                        '${notes.isEmpty ? '' : '\nNotes: $notes'}',
                      ),
                    ),
                    isThreeLine: true,
                    trailing: Chip(
                      label: Text(status),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeighbourCare Services'),
        actions: [
          IconButton(
            onPressed: loadMyBookings,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh bookings',
          ),
        //  IconButton(
        //    onPressed: openProviderPortal,
        //    icon: const Icon(Icons.engineering),
        //    tooltip: 'Provider portal',
        //  ),
          IconButton(
            onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ProviderPortalPage(),
              ),
            );
          },
          icon: const Icon(Icons.engineering),
          tooltip: 'Provider portal',
          ),
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;

          final content = isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: buildBookingForm()),
                    const SizedBox(width: 24),
                    Expanded(child: buildBookingList()),
                  ],
                )
              : ListView(
                  children: [
                    buildBookingForm(),
                    const SizedBox(height: 24),
                    buildBookingList(),
                  ],
                );

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: content,
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool hidePassword = true;
  String message = '';

  Future<void> signIn() async {
  final email = emailController.text.trim();
  final password = passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    setState(() {
      message = 'Enter both email and password.';
    });
    return;
  }

  setState(() {
    loading = true;
    message = '';
  });

  try {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    debugPrint(
      'Sign-in completed. '
      'User ID: ${response.user?.id}, '
      'Session exists: ${response.session != null}',
    );

    if (response.session == null && mounted) {
      setState(() {
        message = 'Sign-in did not create an active session.';
      });
    }

    // Do not navigate manually here.
    // AuthGate receives the signedIn event and replaces LoginPage.
  } on AuthException catch (error) {
    debugPrint(
      'Sign-in error: ${error.message}, '
      'status: ${error.statusCode}, '
      'code: ${error.code}',
    );

    if (!mounted) return;

    setState(() {
      message = error.message;
    });
  } catch (error) {
    if (!mounted) return;

    setState(() {
      message = 'Sign-in failed:\n$error';
    });
  } finally {
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }
}
  

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Enter an email and password to create an account.';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        message = 'Password must contain at least 6 characters.';
      });
      return;
    }

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (response.session == null) {
        setState(() {
          message =
              'Account created. Check your email to confirm your account, '
              'then sign in.';
        });
      } else {
        setState(() {
          message = 'Account created and signed in.';
        });
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      setState(() {
        message = error.message;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        message = 'Could not create account:\n$error';
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeighbourCare Calgary'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.home_work_outlined,
                      size: 58,
                      color: Color(0xFF0C7A6C),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome to NeighbourCare',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to book and manage home services.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'you@example.com',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      onSubmitted: (_) => signIn(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: loading ? null : signIn,
                        child: loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Sign in'),
                      ),
                    ),

                    const SizedBox(height: 10),

                    OutlinedButton(
                      onPressed: loading ? null : signUp,
                      child: const Text('Create test account'),
                    ),

                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      SelectableText(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: message.toLowerCase().contains('failed') ||
                                  message.toLowerCase().contains('error') ||
                                  message.toLowerCase().contains('invalid')
                              ? Colors.red
                              : Colors.green.shade700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Session? session;
  bool loading = true;
  String? errorMessage;

  StreamSubscription<AuthState>? authSubscription;

  @override
  void initState() {
    super.initState();

    // Subscribe immediately so the sign-in event cannot be missed.
    authSubscription = supabase.auth.onAuthStateChange.listen(
      (authState) {
        debugPrint(
          'Auth event: ${authState.event}, '
          'session exists: ${authState.session != null}',
        );

        if (!mounted) return;

        setState(() {
          session = authState.session;
          loading = false;
        });
      },
      onError: (error, stackTrace) {
        debugPrint('Auth stream error: $error');

        if (!mounted) return;

        setState(() {
          errorMessage = error.toString();
          loading = false;
        });
      },
    );

    // Load the session already stored in the browser.
    final currentSession = supabase.auth.currentSession;

    setState(() {
      session = currentSession;
      loading = false;
    });
  }

  @override
  void dispose() {
    authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Authentication error:\n$errorMessage',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (session == null) {
      return const LoginPage();
    }

    return const ServicesBookingPage();
  }
}


class ProviderPortalPage extends StatefulWidget {
  const ProviderPortalPage({super.key});

  @override
  State<ProviderPortalPage> createState() => _ProviderPortalPageState();
}

class _ProviderPortalPageState extends State<ProviderPortalPage> {
  String? providerId;
  List<Map<String, dynamic>> assignedBookings = [];

  bool loading = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    loadProviderPortal();
  }

  Future<void> loadProviderPortal() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        loading = false;
        message = 'Please sign in as a provider.';
      });
      return;
    }

    debugPrint('Signed-in user ID: ${user.id}');
    debugPrint('Signed-in email: ${user.email}');

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final provider = await supabase
          .from('providers')
          .select('id, user_id, pvsc_verified, rating_avg')
          .eq('user_id', user.id)
          .maybeSingle();

      if (provider == null) {
        setState(() {
          loading = false;
          message = 'No provider profile is linked to this account.';
        });
        return;
      }

      providerId = provider['id'].toString();

      final bookings = await supabase
          .from('bookings')
          .select()
          .eq('provider_id', providerId!)
          .order('created_at', ascending: false);

      setState(() {
        assignedBookings =
            List<Map<String, dynamic>>.from(bookings);
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
        message = 'Could not load provider portal:\n$error';
      });
    }
  }

  Future<void> updateBookingStatus(
    String bookingId,
    String newStatus,
  ) async {
    try {
      await supabase
          .from('bookings')
          .update({'status': newStatus})
          .eq('id', bookingId);

      setState(() {
        message = 'Booking updated to $newStatus.';
      });

      await loadProviderPortal();
    } catch (error) {
      setState(() {
        message = 'Could not update booking:\n$error';
      });
    }
  }

  Widget bookingCard(Map<String, dynamic> booking) {
    final bookingId = booking['id'].toString();
    final status = booking['status']?.toString() ?? 'pending';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking['service_type']?.toString() ?? 'Service request',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Location: ${booking['location'] ?? 'Not provided'}'),
            Text(
              'Preferred time: '
              '${booking['preferred_time'] ?? 'Not provided'}',
            ),
            Text('Status: $status'),
            Text('Booking ID: $bookingId'),

            if (booking['notes'] != null &&
                booking['notes'].toString().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Notes: ${booking['notes']}'),
            ],

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (status == 'assigned')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(
                        bookingId,
                        'in_transit',
                      );
                    },
                    icon: const Icon(Icons.directions_car),
                    label: const Text('Start travel'),
                  ),

                if (status == 'in_transit')
                  FilledButton.icon(
                    onPressed: () {
                      updateBookingStatus(
                        bookingId,
                        'completed',
                      );
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Mark completed'),
                  ),

                if (status == 'completed')
                  const Chip(
                    avatar: Icon(Icons.check),
                    label: Text('Completed'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Portal'),
        actions: [
          IconButton(
            onPressed: loadProviderPortal,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
          IconButton(
            onPressed: () async {
              try {
                await supabase.auth.signOut();

                if (!mounted) return;

                Navigator.of(context).popUntil((route) => route.isFirst);
              } catch (error) {
              if (!mounted) return;

              setState(() {
                message = 'Could not sign out:\n$error';
              });
            }
          },
          icon: const Icon(Icons.logout),
          tooltip: 'Sign out',
        ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;

          final content = loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Text(
                      'Assigned bookings',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (message.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(message),
                      ),

                    if (assignedBookings.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'No bookings are currently assigned to you.',
                          ),
                        ),
                      ),

                    ...assignedBookings.map(bookingCard),
                  ],
                );

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWide ? 1000 : double.infinity,
              ),
              child: content,
            ),
          );
        },
      ),
    );
  }
}