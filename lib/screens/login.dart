import 'package:doctors_booking/screens/bottomnavbar/bottomnavbar.dart';
import 'package:doctors_booking/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetEmailController = TextEditingController();

  bool pressed = true;

  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: 150,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://mms.businesswire.com/media/20160202006046/en/507319/5/dod-logo-icon-large_%281%29.jpg"),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              field("Email Adress", Icons.email, TextInputType.emailAddress,
                  false, emailController,
                  key: emailKey),
              field("Password", Icons.lock, TextInputType.text, pressed,
                  passwordController,
                  key: passwordKey),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  child: Text("Forgot Password?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          height: 1.5)),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: Text("Enter Email Adress",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            content: field(
                                "Email Address",
                                Icons.email,
                                TextInputType.emailAddress,
                                false,
                                resetEmailController),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Colors.grey, width: 0.5)),
                                  backgroundColor: Colors.transparent,
                                ),
                                child: Text("Send Code",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {},
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Colors.grey, width: 0.5)),
                                  backgroundColor: Colors.transparent,
                                ),
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  return Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
              SizedBox(height: 5.0),
              Builder(builder: (BuildContext context) {
                return TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff00BBDC),
                  ),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(missingData("All Fields are Required"));
                    } else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return BottomNavBar();
                      }));
                    }
                  },
                );
              }),
              SizedBox(height: 5.0),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      minRadius: 20.0,
                      maxRadius: 20.0,
                      backgroundImage: NetworkImage(
                          "https://www.pngitem.com/pimgs/m/118-1181708_google-icon-google-logo-design-flaws-hd-png.png"),
                    ),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: Text(
                    "Not an existing user? Sign Up",
                    style: TextStyle(
                        color: Color(0xff00BBDC),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        height: 2.5),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SignUp();
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  field(String label, IconData icon, TextInputType type, bool obsecure,
      TextEditingController controller,
      {Key? key}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        key: key,
        validator: (value) {
          if (value!.isEmpty) {
            return "This Field's Required";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon: label == "Password"
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                  iconSize: 20,
                  onPressed: () {
                    setState(() {
                      pressed = !pressed;
                    });
                  })
              : null,
        ),
        textInputAction: TextInputAction.done,
        keyboardType: type,
        obscureText: obsecure,
        controller: controller,
      ),
    );
  }

  missingData(String content) {
    return SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Text(content),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15.0))),
    );
  }

  Future<bool> saveData() async {
    try {
      SharedPreferences _user = await SharedPreferences.getInstance();
      _user.setString("email", emailController.text);
      return true;
    } catch (e) {
      return false;
    }
  }
}
