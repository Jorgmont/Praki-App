import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _pageController = PageController();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? _selectedMood;
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToPage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _submit() {
    if (_passwordFormKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            // If authentication fails, go back to password entry and show error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: theme.colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                        theme.scaffoldBackgroundColor,
                        const Color(0xFF152220),
                      ]
                    : [
                        theme.scaffoldBackgroundColor,
                        const Color(0xFFDCEBE7),
                      ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: isLoading
                    ? const _BreathingLoader()
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Typographic Logo Section
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'praki',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -3.5,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Tu espacio de paz y salud mental',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? const Color(0xFF90B5AC) : const Color(0xFF4C7B71),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 36),

                            // Conversational Page View Card
                            Card(
                              elevation: isDark ? 0 : 8,
                              shadowColor: Colors.black.withValues(alpha: 0.04),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Progress Indicators
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(3, (index) {
                                        final isCurrent = index == _currentPageIndex;
                                        return AnimatedContainer(
                                          duration: const Duration(milliseconds: 350),
                                          margin: const EdgeInsets.symmetric(horizontal: 4),
                                          height: 6,
                                          width: isCurrent ? 24 : 6,
                                          decoration: BoxDecoration(
                                            color: isCurrent
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.primary.withValues(alpha: 0.25),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 24),

                                    // Content Area (PageView)
                                    SizedBox(
                                      height: 230,
                                      child: PageView(
                                        controller: _pageController,
                                        physics: const NeverScrollableScrollPhysics(),
                                        onPageChanged: (index) {
                                          setState(() {
                                            _currentPageIndex = index;
                                          });
                                        },
                                        children: [
                                          _buildMoodStep(theme, isDark),
                                          _buildEmailStep(theme, isDark),
                                          _buildPasswordStep(theme, isDark),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Subtle credentials helper
                            Center(
                              child: Text(
                                'admin@example.com / password123',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isDark ? Colors.white24 : Colors.black26,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
            ),
          ),
        );
        },
      ),
    );
  }

  // --- WIDGET BUILDERS FOR STEPS ---

  // Step 0: Mood check-in
  Widget _buildMoodStep(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '¿Cómo está tu mente hoy?',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 18),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.1,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildMoodCard(theme, '😌 Calma', isDark),
              _buildMoodCard(theme, '🥱 Cansancio', isDark),
              _buildMoodCard(theme, '🌪️ Estrés', isDark),
              _buildMoodCard(theme, '☀️ Energía', isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoodCard(ThemeData theme, String label, bool isDark) {
    final isSelected = _selectedMood == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMood = label;
        });
        // Auto-navigate to next step after a tiny delay for high premium responsiveness
        Future.delayed(const Duration(milliseconds: 350), () {
          if (mounted) _navigateToPage(1);
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: isDark ? 0.25 : 0.12)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.15),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }

  // Step 1: Email entry
  Widget _buildEmailStep(ThemeData theme, bool isDark) {
    return Form(
      key: _emailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola. Comencemos tu sesión.',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '¿Cuál es tu correo electrónico?',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? const Color(0xFF90B5AC) : const Color(0xFF4C7B71),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'ejemplo@correo.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ingresa tu correo';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                return 'Correo electrónico no válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Back Button
              OutlinedButton(
                onPressed: () => _navigateToPage(0),
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                ),
                child: Icon(Icons.arrow_back_rounded, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              // Continue Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailFormKey.currentState!.validate()) {
                      _navigateToPage(2);
                    }
                  },
                  child: const Text('Continuar'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Step 2: Password entry
  Widget _buildPasswordStep(ThemeData theme, bool isDark) {
    return Form(
      key: _passwordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tu espacio está casi listo.',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Ingresa tu contraseña para entrar:',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? const Color(0xFF90B5AC) : const Color(0xFF4C7B71),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: '••••••••',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Back Button
              OutlinedButton(
                onPressed: () => _navigateToPage(1),
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                ),
                child: Icon(Icons.arrow_back_rounded, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              // Submit Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Comenzar'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Calming animated loader that simulates breathing to establish the mental health context
class _BreathingLoader extends StatefulWidget {
  const _BreathingLoader();

  @override
  State<_BreathingLoader> createState() => _BreathingLoaderState();
}

class _BreathingLoaderState extends State<_BreathingLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.88, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: _animation,
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary,
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  blurRadius: 25,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.spa_rounded,
                size: 52,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),
        Text(
          'Conectando con tu bienestar...',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Abriendo tu espacio de paz en Praki',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
