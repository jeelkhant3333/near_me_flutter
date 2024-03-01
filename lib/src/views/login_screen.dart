import 'dart:convert';import 'package:flutter/material.dart';import 'package:http/http.dart' as http;import 'package:shared_preferences/shared_preferences.dart';class LoginScreen extends StatefulWidget {  const LoginScreen({super.key});  @override  State<LoginScreen> createState() => _LoginScreenState();}class _LoginScreenState extends State<LoginScreen> {  final GlobalKey<FormState> formKey = GlobalKey<FormState>();  TextEditingController emailController = TextEditingController();  TextEditingController passwordController = TextEditingController();  Icon passwordIcon = const Icon(Icons.visibility_off_outlined);  bool _isPasswordVisible = false;  late SharedPreferences preferences;  @override  void initState() {    super.initState();    intiPref();  }  void intiPref() async {    preferences = await SharedPreferences.getInstance();  }  String? validateEmail(String? value) {    if (value == null || value.isEmpty) {      return 'Please enter your email';    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')        .hasMatch(value)) {      return 'Please enter a valid email';    }    return null;  }  String? validatePassword(String? value) {    if (value == null || value.isEmpty) {      return 'Please enter a password';    } else if (value.length < 8) {      return 'Password must be at least 8 characters long';    }    return null;  }  void submitForm() {    if (formKey.currentState?.validate() ?? false) {      signIn();    }  }  Future<void> signIn() async {    try {      if (mounted) {        http.Response response = await http.post(          Uri.parse('https://neartravel.teleferti.com/api/login'),          body: jsonEncode({            "email": emailController.text,            "password": passwordController.text,          }),        );        // print('request posted');        if (mounted) {          if (response.statusCode == 201) {            // print('response = ${response.body}');            var resData = jsonDecode(response.body);              var myToken = resData['token'];              // print('token = $myToken');              preferences.setString('token', myToken);            Navigator.pushNamed(context, 'home');          } else {            // print(response.statusCode);            ScaffoldMessenger.of(context).showSnackBar(              const SnackBar(                content: Text("Something went wrong!"),                duration: Duration(seconds: 3),              ),            );          }        }      }    } catch (e) {      // print("catch $e");      if (mounted) {        ScaffoldMessenger.of(context).showSnackBar(          const SnackBar(            content: Text("Something went wrong!"),            duration: Duration(seconds: 3),          ),        );      }    }  }  @override  Widget build(BuildContext context) {    double h = MediaQuery.of(context).size.height;    double w = MediaQuery.of(context).size.width;    return Scaffold(      body: SafeArea(child: SingleChildScrollView(        physics: const BouncingScrollPhysics(),        child: Padding(          padding: const EdgeInsets.symmetric(            horizontal: 20,            vertical: 10,          ),          child: Column(            crossAxisAlignment: CrossAxisAlignment.start,            children: [              Container(                // margin: const EdgeInsets.only(top: 30),                height: h * 0.3734,                width: double.infinity,                decoration: const BoxDecoration(                  image: DecorationImage(                    image: AssetImage("Assets/signin_image_tour.png"),                  ),                ),              ),              const Text(                "Sign in",                style: TextStyle(                  fontWeight: FontWeight.w900,                  fontSize: 35,                ),              ),              const Text(                "Please login to continue to your account.",                style: TextStyle(                  color: Color.fromRGBO(150, 150, 150, 1),                  fontWeight: FontWeight.w400,                  fontSize: 14,                ),              ),              const SizedBox(                height: 20,              ),              Form(                key: formKey,                child: Column(                  children: [                    TextFormField(                      textInputAction: TextInputAction.next,                      controller: emailController,                      keyboardType: TextInputType.emailAddress,                      decoration: const InputDecoration(                        labelText: "Email",                        helperStyle: TextStyle(fontWeight: FontWeight.w100),                        border: OutlineInputBorder(                          borderRadius: BorderRadius.all(                            Radius.circular(10),                          ),                        ),                      ),                      validator: validateEmail,                    ),                    const SizedBox(                      height: 10,                    ),                    TextFormField(                      controller: passwordController,                      obscureText: !_isPasswordVisible,                      decoration: InputDecoration(                        suffixIcon: IconButton(                          onPressed: () {                            setState(() {                              _isPasswordVisible = !_isPasswordVisible;                            });                          },                          icon: _isPasswordVisible                              ? const Icon(Icons.visibility_outlined)                              : const Icon(Icons.visibility_off_outlined),                        ),                        labelText: "Password",                        helperStyle:                        const TextStyle(fontWeight: FontWeight.w100),                        border: const OutlineInputBorder(                          borderRadius: BorderRadius.all(                            Radius.circular(10),                          ),                        ),                      ),                      validator: validatePassword,                    ),                  ],                ),              ),              const SizedBox(                height: 5,              ),              Row(                mainAxisAlignment: MainAxisAlignment.end,                children: [                  InkWell(                    onTap: () {                      Navigator.pushNamed(context, 'forgotpassword');                    },                    child: const Text(                      "Forgot Password?",                      style: TextStyle(                        color: Colors.black87,                        fontSize: 12,                        fontWeight: FontWeight.w600,                      ),                    ),                  ),                ],              ),              const SizedBox(                height: 20,              ),              ElevatedButton(                style: ButtonStyle(                  shape: MaterialStateProperty.all(                    const RoundedRectangleBorder(                      borderRadius: BorderRadius.all(                        Radius.circular(10),                      ),                    ),                  ),                  backgroundColor: MaterialStateProperty.all(                    const Color.fromRGBO(54, 122, 255, 1),                  ),                ),                onPressed: () {                  submitForm();                },                child: Container(                  height: h * 0.0585,                  width: w * 0.872,                  alignment: Alignment.center,                  child: const Text(                    "Sign in",                    style: TextStyle(                      color: Colors.white,                      fontSize: 18,                      fontWeight: FontWeight.w800,                    ),                  ),                ),              ),              const SizedBox(                height: 10,              ),              Row(                mainAxisAlignment: MainAxisAlignment.center,                children: [                  SizedBox(                    width: w * 0.38,                    child: const Divider(),                  ),                  const Padding(                    padding: EdgeInsets.symmetric(horizontal: 10),                    child: Text(                      "or",                      style: TextStyle(                        fontWeight: FontWeight.w600,                        fontSize: 16,                        color: Color.fromRGBO(110, 110, 110, 1),                      ),                    ),                  ),                  SizedBox(                    width: w * 0.38,                    child: const Divider(),                  ),                ],              ),              const SizedBox(                height: 10,              ),              OutlinedButton(                onPressed: () {},                style: OutlinedButton.styleFrom(                  elevation: 100,                  side: const BorderSide(color: Colors.grey),                  shape: const RoundedRectangleBorder(                    borderRadius: BorderRadius.all(                      Radius.circular(10),                    ),                  ),                ),                child: SizedBox(                  height: h * 0.0585,                  width: w * 0.872,                  child: Row(                    mainAxisAlignment: MainAxisAlignment.center,                    children: [                      Container(                        height: 34,                        width: 34,                        decoration: const BoxDecoration(                          image: DecorationImage(                            image: AssetImage("Assets/logo/Icon/googleLogo.png"),                          ),                        ),                      ),                      const SizedBox(                        width: 10,                      ),                      const Text(                        "Sign in with Google",                        style: TextStyle(                          fontSize: 18,                          fontWeight: FontWeight.w800,                          color: Colors.black,                        ),                      ),                    ],                  ),                ),              ),              Padding(                padding: const EdgeInsets.all(10),                child: Row(                  mainAxisAlignment: MainAxisAlignment.center,                  children: [                    const Text(                      "Need an Account? ",                      style: TextStyle(                        color: Colors.grey,                      ),                    ),                    InkWell(                      onTap: () {                        Navigator.pushNamed(context, "signup");                      },                      child: Text(                        "Register",                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(                          decoration: TextDecoration.underline,                          decorationColor:                          const Color.fromRGBO(54, 122, 255, 1),                          color: const Color.fromRGBO(54, 122, 255, 1),                          fontWeight: FontWeight.w500,                        ),                      ),                    ),                  ],                ),              ),            ],          ),        ),      )),    );  }  @override  void dispose() {    if (mounted) {      emailController.clear();      passwordController.clear();    }    super.dispose();  }}