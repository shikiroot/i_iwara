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

  // 登录表单控制器
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  // 注册表单控制器
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  // 表单键
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  // 加载状态
  bool _isLoading = false;
  bool _isRegistering = false;
  bool _isCaptchaLoading = false;

  late TabController _tabController;

  final Rxn<Captcha?> _captcha = Rxn<Captcha>();

  // 焦点节点
  final FocusNode _loginPasswordFocus = FocusNode();
  final FocusNode _registerCaptchaFocus = FocusNode();

  // 密码可见性切换
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        _fetchCaptcha();
      }
    });

    // 如果初始标签是注册，则可选地获取验证码
    if (_tabController.index == 1) {
      _fetchCaptcha();
    }
  }

  void _fetchCaptcha() async {
    setState(() {
      _isCaptchaLoading = true;
    });
    try {
      ApiResult<Captcha> res = await _authService.fetchCaptcha();
      if (res.isSuccess) {
        _captcha.value = res.data;
      } else {
        Get.snackbar('错误', res.message);
      }
    } finally {
      setState(() {
        _isCaptchaLoading = false;
      });
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
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: !_isPasswordVisible,
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
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_loginFormKey.currentState!.validate()) {
                                  _login();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text('登录', style: const TextStyle(fontSize: 16)),
                      ),
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
                      if (_isCaptchaLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (_captcha.value != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.memory(
                              base64Decode(_captcha.value!.data.split(',')[1]),
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
                                if (_registerFormKey.currentState!.validate()) {
                                  _register();
                                }
                              },
                            ),
                            TextButton(
                              onPressed: _isCaptchaLoading ? null : _fetchCaptcha,
                              child: Text('刷新验证码'),
                            ),
                          ],
                        )
                      else
                        const Text('无法加载验证码'),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isRegistering
                            ? null
                            : () {
                                if (_registerFormKey.currentState!.validate()) {
                                  _register();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isRegistering
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text('注册', style: const TextStyle(fontSize: 16)),
                      ),
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

    setState(() {
      _isLoading = true;
    });

    try {
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
      setState(() {
        _isLoading = false;
      });
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

    setState(() {
      _isRegistering = true;
    });

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
      setState(() {
        _isRegistering = false;
      });
    }
  }
}
