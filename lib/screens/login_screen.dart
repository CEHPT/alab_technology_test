import 'package:alab_technology_test/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isMobileValid = false;
  bool _isOtpSent = false;
  bool _isLoading = false;
  bool _obscureOtp = true;
  String _currentMobile = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  // Static color scheme for login page
  static const Color _primaryColor = Color(0xFF6C63FF);
  static const Color _primaryVariant = Color(0xFF9D4EDD);
  static const Color _secondaryColor = Color(0xFF4CAF50);
  static const Color _backgroundColor = Color(0xFFF8FAFC);
  static const Color _surfaceColor = Color(0xFFFFFFFF);
  static const Color _onPrimaryColor = Colors.white;
  static const Color _onSurfaceColor = Color(0xFF1A1A1A);

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.bounceOut),
      ),
    );

    _rotateAnimation = Tween<double>(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  void _validateMobile(String value) {
    setState(() {
      _isMobileValid = _isValidMobile(value);

      // If OTP was already sent but user is editing mobile number,
      // hide OTP fields and show Send OTP button again
      if (_isOtpSent && value != _currentMobile) {
        _isOtpSent = false;
        _otpController.clear();
      }
    });
  }

  bool _isValidMobile(String mobile) {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(mobile);
  }

  void _sendOtp() {
    if (_isMobileValid) {
      setState(() {
        _isOtpSent = true;
        _isLoading = true;
        _currentMobile =
            _mobileController.text; // Store the current mobile number
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        _showSuccessSnackBar();
      });
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'OTP sent to ${_mobileController.text}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login API call
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DashboardScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    }
  }

  void _showLoginSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.verified, color: Colors.white),
            const SizedBox(width: 8),
            const Text('Login Successful!',
                style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Method to edit mobile number (show Send OTP button again)
  void _editMobileNumber() {
    setState(() {
      _isOtpSent = false;
      _otpController.clear();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Column(
                children: [
                  // 🌟 Animated Header Section
                  _buildAnimatedHeader(),

                  const SizedBox(height: 40),

                  // 📝 Animated Form Section
                  _buildAnimatedForm(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return Stack(
      children: [
        // Background Animated Circles
        Positioned(
          top: -50,
          right: -30,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _primaryColor.withOpacity(0.1),
                    _primaryColor.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: 100,
          left: -20,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _secondaryColor.withOpacity(0.1),
                    _secondaryColor.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        Column(
          children: [
            // 🎯 Main Logo with Multiple Animations
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: RotationTransition(
                  turns: _rotateAnimation,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _primaryColor,
                          _primaryVariant,
                          _secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryColor.withOpacity(0.4),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: _backgroundColor.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Shine Effect
                        Positioned(
                          top: -10,
                          left: -10,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Center(
                          child: Icon(
                            Icons.fingerprint_rounded,
                            color: _onPrimaryColor,
                            size: 60,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 📝 Text Content with Staggered Animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [
                            _primaryColor,
                            _secondaryColor,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      child: const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: _surfaceColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Sign in to continue your journey ✨',
                        style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedForm() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _surfaceColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 20),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: _surfaceColor.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
              border: Border.all(
                color: _primaryColor.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // 📱 Mobile Number Field with Edit Option
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(
                              0, _isMobileValid ? -5 : 0, 0),
                          child: TextFormField(
                            controller: _mobileController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            onChanged: _validateMobile,
                            enabled: !_isOtpSent, // Disable when OTP is sent
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1A1A),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              labelStyle: const TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 14,
                              ),
                              prefixIcon: Container(
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: _primaryColor.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Icon(Icons.phone_android_rounded,
                                    color: _primaryColor),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: _backgroundColor.withOpacity(0.5),
                              counterText: "",
                              suffixIcon: _isMobileValid && !_isOtpSent
                                  ? ScaleTransition(
                                      scale: _scaleAnimation,
                                      child: const Icon(Icons.verified_rounded,
                                          color: Colors.green),
                                    )
                                  : null,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: _primaryColor.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: _primaryColor,
                                  width: 2,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: _primaryColor.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile number';
                              }
                              if (!_isValidMobile(value)) {
                                return 'Please enter valid 10-digit mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      if (_isOtpSent) ...[
                        const SizedBox(width: 10),
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: _editMobileNumber,
                              icon: Icon(
                                Icons.edit_rounded,
                                color: _primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 📨 Send OTP Button (Only show when OTP is not sent)
                  if (!_isOtpSent) ...[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: _isMobileValid && !_isLoading
                            ? LinearGradient(
                                colors: [
                                  _primaryColor,
                                  _primaryVariant,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey.withOpacity(0.5),
                                  Colors.grey.withOpacity(0.3),
                                ],
                              ),
                        boxShadow: _isMobileValid && !_isLoading
                            ? [
                                BoxShadow(
                                  color: _primaryColor.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      child: ElevatedButton(
                        onPressed:
                            _isMobileValid && !_isLoading ? _sendOtp : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                    _onPrimaryColor,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.send_rounded, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Send OTP',
                                    style: TextStyle(
                                      color: _onPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],

                  // 🔑 OTP Field (Only show when OTP is sent)
                  if (_isOtpSent) ...[
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // OTP Label outside the container
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Text(
                            'Enter OTP',
                            style: TextStyle(
                              fontSize: 14,
                              color: _onSurfaceColor.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizeTransition(
                          sizeFactor: CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.elasticOut,
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: _primaryColor.withOpacity(0.1),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                obscureText: _obscureOtp,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 8,
                                  color: Color(0xFF1A1A1A),
                                ),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  // Remove labelText since we're showing it above
                                  hintText: 'Enter 6-digit OTP',
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    letterSpacing: 0,
                                  ),
                                  prefixIcon: Icon(Icons.lock_rounded,
                                      color: _primaryColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: _backgroundColor.withOpacity(0.5),
                                  counterText: "",
                                  suffixIcon: IconButton(
                                    icon: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: _obscureOtp
                                          ? Icon(Icons.visibility_rounded,
                                              key: const ValueKey('visible'),
                                              color: _primaryColor)
                                          : Icon(Icons.visibility_off_rounded,
                                              key: const ValueKey('invisible'),
                                              color: _primaryColor),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureOtp = !_obscureOtp;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter OTP';
                                  }
                                  if (value.length != 6) {
                                    return 'OTP must be 6 digits';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 🚀 Login Button
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              _secondaryColor,
                              _secondaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _secondaryColor.withOpacity(0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: !_isLoading ? _login : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      _onPrimaryColor,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        color: _onPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_rounded,
                                        size: 20, color: _onPrimaryColor),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
