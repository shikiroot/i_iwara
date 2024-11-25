// pages/login_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';

import '../../../models/captcha.model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

  // Controllers for Login
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  // Controllers for Register
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  // Form Keys
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  // Loading States
  final RxBool _isLoading = false.obs;
  final RxBool _isRegistering = false.obs;
  final RxBool _isCaptchaLoading = false.obs;

  late TabController _tabController;

  final Rxn<Captcha?> _captcha = Rxn<Captcha>();

  // Focus Nodes
  final FocusNode _loginPasswordFocus = FocusNode();
  final FocusNode _registerCaptchaFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        _fetchCaptcha();
      }
    });

    // Optionally fetch captcha if initial tab is registration
    if (_tabController.index == 1) {
      _fetchCaptcha();
    }
  }

  void _fetchCaptcha() async {
    _isCaptchaLoading.value = true;
    try {
      ApiResult<Captcha> res = await _authService.fetchCaptcha();
      if (res.isSuccess) {
        _captcha.value = res.data;
      } else {
        Get.snackbar('错误', res.message);
      }
    } finally {
      _isCaptchaLoading.value = false;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _captchaController.dispose();
    _loginPasswordFocus.dispose();
    _registerCaptchaFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录 / 注册'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '登录'),
            Tab(text: '注册'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLoginForm(),
          _buildRegisterForm(),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth > 600 ? 400 : double.infinity,
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 64,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _loginEmailController,
                        decoration: InputDecoration(
                          labelText: '邮箱',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '请输入邮箱';
                          }
                          if (!GetUtils.isEmail(value.trim())) {
                            return '请输入有效的邮箱地址';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_loginPasswordFocus);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _loginPasswordController,
                        decoration: InputDecoration(
                          labelText: '密码',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        focusNode: _loginPasswordFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入密码';
                          }
                          if (value.length < 6) {
                            return '密码至少需要6位';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _login(),
                      ),
                      const SizedBox(height: 24),
                      Obx(() => ElevatedButton(
                            onPressed: _isLoading.value
                                ? null
                                : () {
                                    if (_loginFormKey.currentState!
                                        .validate()) {
                                      _login();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading.value
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text('登录',
                                    style: const TextStyle(fontSize: 16)),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth > 600 ? 400 : double.infinity,
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 64,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _registerEmailController,
                        decoration: InputDecoration(
                          labelText: '邮箱',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '请输入邮箱';
                          }
                          if (!GetUtils.isEmail(value.trim())) {
                            return '请输入有效的邮箱地址';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          if (_captcha.value != null) {
                            FocusScope.of(context)
                                .requestFocus(_registerCaptchaFocus);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () {
                          if (_isCaptchaLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (_captcha.value != null) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.memory(
                                  base64Decode(
                                      _captcha.value!.data.split(',')[1]),
                                  height: 80,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _captchaController,
                                  decoration: InputDecoration(
                                    labelText: '验证码',
                                    prefixIcon: const Icon(Icons.security),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  focusNode: _registerCaptchaFocus,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return '请输入验证码';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) {
                                    if (_registerFormKey.currentState!
                                        .validate()) {
                                      _register();
                                    }
                                  },
                                ),
                                TextButton(
                                  onPressed: _isCaptchaLoading.value
                                      ? null
                                      : _fetchCaptcha,
                                  child: Text('刷新验证码'),
                                ),
                              ],
                            );
                          } else {
                            return const Text('无法加载验证码');
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      Obx(() => ElevatedButton(
                            onPressed: _isRegistering.value
                                ? null
                                : () {
                                    if (_registerFormKey.currentState!
                                        .validate()) {
                                      _register();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isRegistering.value
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text('注册',
                                    style: const TextStyle(fontSize: 16)),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _login() async {
    final email = _loginEmailController.text.trim();
    final password = _loginPasswordController.text;

    try {
      _isLoading.value = true;
      ApiResult result = await _authService.login(email, password);

      if (result.isSuccess) {
        await _userService.fetchUserProfile();
        Get.snackbar('成功', '登录成功');
        if (Get.previousRoute == Routes.LOGIN) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.back();
        }
      } else {
        Get.snackbar('错误', result.message);
      }
    } finally {
      _isLoading.value = false;
    }
  }

  void _register() async {
    final email = _registerEmailController.text.trim();
    final captchaAnswer = _captchaController.text.trim();

    if (_captcha.value == null) {
      Get.snackbar(
        '错误',
        '验证码未加载',
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    _isRegistering.value = true;

    try {
      ApiResult result =
          await _authService.register(email, _captcha.value!.id, captchaAnswer);
      if (result.isSuccess) {
        Get.snackbar(
          '成功',
          '邮箱指令已发送',
          snackPosition: SnackPosition.bottom,
        );
        // 切换回登录标签
        _tabController.index = 0;
      } else {
        Get.snackbar('错误', result.message);
        // 发生错误时刷新验证码
        _fetchCaptcha();
      }
    } finally {
      _isRegistering.value = false;
    }
  }
}
