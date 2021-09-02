import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/screens/design/project/project_screen.dart';
import 'package:flutter_unity_widget_example/screens/unity_portion/constants.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class SimpleScreen extends StatefulWidget {
  SimpleScreen({Key key}) : super(key: key);
  static String routeName = "/simple";

  @override
  _SimpleScreenState createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  UnityWidgetController _unityWidgetController;
  bool canvas1 = true;
  bool canvas2 = false; //should be false once canvas1 is implemented
  bool canvas3 = false;
  bool canvas4 = false;
  bool canvas5 = false;
  bool canvas6 = false;
  bool canvas7 = false;
  bool canvas8 = false;
  bool canvas9 = true;

  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  bool _validateLength = false;
  bool _validateWidth = false;
  int val = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _unityWidgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Card(
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              UnityWidget(
                fullscreen: true,
                onUnityCreated: _onUnityCreated,
                onUnityMessage: onUnityMessage,
                onUnitySceneLoaded: onUnitySceneLoaded,
              ),
              RoomCanvas1(),
              RoomCanvas2(),
              RoomCanvas3(),
              RoomCanvas4(),
              RoomCanvas5(),
              RoomCanvas6(),
              RoomCanvas7(),
              RoomCanvas8(),
            ],
          )),
    );
  }

  Column RoomCanvas1() {
    return canvas1
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //shoudl have another button here that changes scene to the main editor
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressBack();
                        //setstate so that main editor buttons appear
                        setState(() {
                          canvas1 = false;
                          canvas4 = true;
                        });
                      },
                      child: Text("Back",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false, //user must tap button
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text("Dimensions"),
                                  content: SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Text("Length:\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionalScreenWidth(
                                                            18))),
                                          ),
                                          SizedBox(
                                              width: getProportionalScreenWidth(
                                                  20)),
                                          Container(
                                              height: SizeConfig.screenHeight *
                                                  0.075,
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
                                              child: TextFormField(
                                                controller: _lengthController,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    errorText: _validateLength
                                                        ? "Invalid length!"
                                                        : null,
                                                    helperText: " "),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.left,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionalScreenHeight(5)),
                                      Row(
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Text("Width:\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionalScreenWidth(
                                                            18))),
                                          ),
                                          SizedBox(
                                              width: getProportionalScreenWidth(
                                                  20)),
                                          Container(
                                              height: SizeConfig.screenHeight *
                                                  0.075,
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
                                              child: TextFormField(
                                                controller: _widthController,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    errorText: _validateWidth
                                                        ? "Invalid width!"
                                                        : null,
                                                    helperText: " "),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.left,
                                              ))
                                        ],
                                      ),
                                    ],
                                  )),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        _validateLength = false;
                                        _validateWidth = false;
                                        _lengthController.clear();
                                        _widthController.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Confirm"),
                                      onPressed: () {
                                        double _length = double.tryParse(
                                            _lengthController.text);
                                        double _width = double.tryParse(
                                            _widthController.text);
                                        _validateLength = false;
                                        _validateWidth = false;
                                        if (_length != null && _width != null) {
                                          _lengthController.clear();
                                          _widthController.clear();
                                          ConfirmCreatePlane(_length, _width);
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            if (_length == null) {
                                              _validateLength = true;
                                            }
                                            if (_width == null) {
                                              _validateWidth = true;
                                            }
                                          });
                                        }
                                      },
                                    )
                                  ],
                                );
                              });
                            });
                      },
                      child: Text("Add Room Section",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false, //user must tap button
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text("Dimensions"),
                                  content: SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Text("Length:\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionalScreenWidth(
                                                            18))),
                                          ),
                                          SizedBox(
                                              width: getProportionalScreenWidth(
                                                  20)),
                                          Container(
                                              height: SizeConfig.screenHeight *
                                                  0.075,
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
                                              child: TextFormField(
                                                controller: _lengthController,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    errorText: _validateLength
                                                        ? "Invalid length!"
                                                        : null,
                                                    helperText: " "),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.left,
                                              ))
                                        ],
                                      ),
                                      ListTile(
                                          title: const Text("Vertical"),
                                          leading: Radio(
                                            value: 1,
                                            groupValue: val,
                                            onChanged: (value) {
                                              setState(() {
                                                val = value;
                                              });
                                            },
                                            activeColor: Colors.black,
                                          )),
                                      ListTile(
                                          title: const Text("Horizontal"),
                                          leading: Radio(
                                            value: 2,
                                            groupValue: val,
                                            onChanged: (value) {
                                              setState(() {
                                                val = value;
                                              });
                                            },
                                            activeColor: Colors.black,
                                          )),
                                    ],
                                  )),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        _validateLength = false;
                                        _lengthController.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Confirm"),
                                      onPressed: () {
                                        double _length = double.tryParse(
                                            _lengthController.text);
                                        _validateLength = false;
                                        if (_length != null) {
                                          _lengthController.clear();
                                          ConfirmCreateWall(
                                              _length, val == 2 ? true : false);
                                          val = 1;
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            if (_length == null) {
                                              _validateLength = true;
                                            }
                                          });
                                        }
                                      },
                                    )
                                  ],
                                );
                              });
                            });
                      },
                      child: Text("Add Wall",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          )
        : Column();
  }

  Column RoomCanvas2() {
    return canvas2
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    height: getProportionalScreenHeight(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressMovePlane();
                        setState(() {
                          canvas2 = false;
                          canvas3 = true;
                        });
                      },
                      child: Text("Move",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    height: getProportionalScreenHeight(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressDeletePlane();
                        setState(() {
                          canvas2 = false;
                          canvas1 = true;
                        });
                      },
                      child: Text("Delete",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false, //user must tap button
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text("Edit Dimensions"),
                                  content: SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Text("Length:\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionalScreenWidth(
                                                            18))),
                                          ),
                                          SizedBox(
                                              width: getProportionalScreenWidth(
                                                  20)),
                                          Container(
                                              height: SizeConfig.screenHeight *
                                                  0.075,
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
                                              child: TextFormField(
                                                controller: _lengthController,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    errorText: _validateLength
                                                        ? "Invalid length!"
                                                        : null,
                                                    helperText: " "),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.left,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionalScreenHeight(5)),
                                      Row(
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Text("Width:\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionalScreenWidth(
                                                            18))),
                                          ),
                                          SizedBox(
                                              width: getProportionalScreenWidth(
                                                  20)),
                                          Container(
                                              height: SizeConfig.screenHeight *
                                                  0.075,
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
                                              child: TextFormField(
                                                controller: _widthController,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    errorText: _validateWidth
                                                        ? "Invalid width!"
                                                        : null,
                                                    helperText: " "),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.left,
                                              ))
                                        ],
                                      ),
                                    ],
                                  )),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        _validateLength = false;
                                        _validateWidth = false;
                                        _lengthController.clear();
                                        _widthController.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Confirm"),
                                      onPressed: () {
                                        double _length = double.tryParse(
                                            _lengthController.text);
                                        double _width = double.tryParse(
                                            _widthController.text);
                                        _validateLength = false;
                                        _validateWidth = false;
                                        if (_length != null && _width != null) {
                                          _lengthController.clear();
                                          _widthController.clear();
                                          ConfirmAdjustPlane(_length, _width);
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            if (_length == null) {
                                              _validateLength = true;
                                            }
                                            if (_width == null) {
                                              _validateWidth = true;
                                            }
                                          });
                                        }
                                      },
                                    )
                                  ],
                                );
                              });
                            });
                      },
                      child: Text("Edit",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column();
  }

  Column RoomCanvas3() {
    return canvas3
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressAcceptPlane();
                        setState(() {
                          canvas2 = true;
                          canvas3 = false;
                        });
                      },
                      child: Text("Accept",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressCancelPlane();
                        setState(() {
                          canvas2 = true;
                          canvas3 = false;
                        });
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          )
        : Column();
  }

  Column RoomCanvas4() {
    return canvas4
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        //reset variables such as canvas
                        //somehow dispose of unitywidgetcontroller
                        //use navigator to go back to design project list screen
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Exit Project?"),
                                content:
                                    Text("Any unsaved progress will be lost."),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      _unityWidgetController.unload();
                                      Navigator.pop(context);
                                      Navigator.popAndPushNamed(
                                          context, ProjectScreen.routeName);
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      child: Text("Exit",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        //save everything to database: plane meshes, furniture object data
                      },
                      child: Text("Save",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        //activate 3D view in Unity
                        setState(() {
                          canvas4 = false;
                          canvas7 = true;
                        });
                        press3D();
                      },
                      child: Text("3D view",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        //open dialog for furniture menu, which has a scrollable list of icons
                        //show loading screen while awaiting furniture data
                        //use a for loop to create list tiles
                        List<Widget> furnitureData = getFurnitureData(context);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.all(10),
                                content: Stack(children: [
                                  Container(
                                      height: SizeConfig.screenHeight * 0.7,
                                      width: SizeConfig.screenWidth * 0.8,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height:
                                                  SizeConfig.screenHeight * 0.1,
                                              child: Text("Furniture Menu",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionalScreenWidth(
                                                              20)))),
                                          Container(
                                            height:
                                                SizeConfig.screenHeight * 0.6,
                                            width: SizeConfig.screenWidth * 0.8,
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: [
                                                ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        furnitureData.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return furnitureData[
                                                          index];
                                                    })
                                              ], //later replace with list data
                                            )),
                                          ),
                                        ],
                                      )),
                                  Positioned(
                                      child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          child: Icon(Icons.close,
                                              color: Colors.black),
                                        )),
                                  ))
                                ]),
                              );
                            });
                      },
                      child: Text("Add Furniture",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        setState(() {
                          canvas1 = true;
                          canvas4 = false;
                        });
                        pressRoomShape();
                      },
                      child: Text("Edit Room Shape",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          )
        : Column();
  }

  Column RoomCanvas5() {
    return canvas5
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    height: getProportionalScreenHeight(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressMoveMain();
                        setState(() {
                          canvas5 = false;
                          canvas6 = true;
                        });
                      },
                      child: Text("Move",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    height: getProportionalScreenHeight(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressRotateMain();
                        setState(() {
                          canvas5 = false;
                          canvas6 = true;
                        });
                      },
                      child: Text("Rotate",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    height: getProportionalScreenHeight(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressDeleteMain();
                        setState(() {
                          canvas4 = true;
                          canvas5 = false;
                        });
                      },
                      child: Text("Delete",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column();
  }

  Column RoomCanvas6() {
    return canvas6
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressAcceptMain();
                        setState(() {
                          canvas5 = true;
                          canvas6 = false;
                        });
                      },
                      child: Text("Accept",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressCancelMain();
                        setState(() {
                          canvas5 = true;
                          canvas6 = false;
                        });
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          )
        : Column();
  }

  Column RoomCanvas7() {
    return canvas7
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressExit3D();
                        setState(() {
                          canvas4 = true;
                          canvas7 = false;
                        });
                      },
                      child: Text("Back",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          )
        : Column();
  }

  Column RoomCanvas8() {
    return canvas8
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    height: getProportionalScreenHeight(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressMovePlane();
                        setState(() {
                          canvas8 = false;
                          canvas9 = true;
                        });
                      },
                      child: Text("Move",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.3,
                    height: getProportionalScreenHeight(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressDeletePlane();
                        setState(() {
                          canvas8 = false;
                          canvas1 = true;
                        });
                      },
                      child: Text("Delete",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false, //user must tap button
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text("Edit Dimensions"),
                                  content: SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.screenWidth * 0.15,
                                            child: Text("Length:\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionalScreenWidth(
                                                            18))),
                                          ),
                                          SizedBox(
                                              width: getProportionalScreenWidth(
                                                  20)),
                                          Container(
                                              height: SizeConfig.screenHeight *
                                                  0.075,
                                              width:
                                                  SizeConfig.screenWidth * 0.3,
                                              child: TextFormField(
                                                controller: _lengthController,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    errorText: _validateLength
                                                        ? "Invalid length!"
                                                        : null,
                                                    helperText: " "),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.left,
                                              ))
                                        ],
                                      ),
                                    ],
                                  )),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        _validateLength = false;
                                        _lengthController.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Confirm"),
                                      onPressed: () {
                                        double _length = double.tryParse(
                                            _lengthController.text);
                                        _validateLength = false;
                                        if (_length != null) {
                                          _lengthController.clear();
                                          ConfirmAdjustPlane(_length, _length);
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            if (_length == null) {
                                              _validateLength = true;
                                            }
                                          });
                                        }
                                      },
                                    )
                                  ],
                                );
                              });
                            });
                      },
                      child: Text("Edit",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column();
  }

  Column RoomCanvas9() {
    return canvas9
        ? Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressAcceptPlane();
                        setState(() {
                          canvas8 = true;
                          canvas9 = false;
                        });
                      },
                      child: Text("Accept",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        pressCancelPlane();
                        setState(() {
                          canvas8 = true;
                          canvas9 = false;
                        });
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          )
        : Column();
  }

  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
    );
  }

  void pressMovePlane() {
    _unityWidgetController.postMessage(
      'OnLoad',
      'pressMovePlane',
      "true",
    );
  }

  void pressDeletePlane() {
    _unityWidgetController.postMessage(
      'OnLoad',
      'pressDeletePlane',
      "true",
    );
  }

  void pressAcceptPlane() {
    _unityWidgetController.postMessage(
      'OnLoad',
      'pressedAccept',
      "true",
    );
  }

  void pressCancelPlane() {
    _unityWidgetController.postMessage(
      'OnLoad',
      'pressedCancel',
      "true",
    );
  }

  void pressBack() {
    _unityWidgetController.postMessage(
      'OnLoad',
      'goToMainScene',
      "true",
    );
  }

  void pressMoveMain() {
    _unityWidgetController.postMessage(
      'MainManager',
      'pressedMove',
      "true",
    );
  }

  void pressRotateMain() {
    _unityWidgetController.postMessage(
      'MainManager',
      'pressedRotate',
      "true",
    );
  }

  void pressDeleteMain() {
    _unityWidgetController.postMessage(
      'MainManager',
      'pressedDelete',
      "true",
    );
  }

  void pressCancelMain() {
    _unityWidgetController.postMessage(
      'MainManager',
      'pressedCancel',
      "true",
    );
  }

  void pressAcceptMain() {
    _unityWidgetController.postMessage(
      'MainManager',
      'pressedAccept',
      "true",
    );
  }

  void pressRoomShape() {
    _unityWidgetController.postMessage(
      'MainManager',
      'goToRoomScene',
      "true",
    );
  }

  void ConfirmCreatePlane(double length, double width) {
    //pop up disappears
    setState(() {
      canvas1 = false;
      canvas3 = true;
    });
    _unityWidgetController.postJsonMessage(
      'OnLoad',
      'createPlaneFromFlutter',
      {
        "PlaneData": [
          {"length": length, "width": width, "wall": false, "horiz": false}
        ]
      },
    );
  }

  void ConfirmCreateWall(double length, bool horiz) {
    setState(() {
      canvas1 = false;
      canvas8 = true;
    });
    _unityWidgetController.postJsonMessage(
      'OnLoad',
      'createPlaneFromFlutter',
      {
        "PlaneData": [
          {"length": length, "width": length, "wall": true, "horiz": horiz}
        ]
      },
    );
  }

  void ConfirmAdjustPlane(double length, double width) {
    _unityWidgetController.postJsonMessage(
      'OnLoad',
      'adjustPlane',
      {
        "EditDimensions": [
          {"length": length, "width": width}
        ]
      },
    );
  }

  void press3D() {
    _unityWidgetController.postMessage(
      'MainManager',
      'pressed3D',
      "true",
    );
  }

  void pressExit3D() {
    _unityWidgetController.postMessage(
      'MainManager',
      'pressedExit3D',
      "true",
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
    String msg = message.toString();
    if (msg == "canvas1") {
      setState(() {
        canvas1 = true;
        canvas2 = false;
        canvas3 = false;
        canvas8 = false;
        canvas9 = false;
      });
    } else if (msg == "canvas2") {
      setState(() {
        canvas1 = false;
        canvas2 = true;
        canvas3 = false;
        canvas8 = false;
        canvas9 = false;
      });
    } else if (msg == "canvas3") {
      setState(() {
        canvas1 = false;
        canvas2 = false;
        canvas3 = true;
        canvas8 = false;
        canvas9 = false;
      });
    } else if (msg == "canvas4") {
      setState(() {
        canvas4 = true;
        canvas5 = false;
        canvas6 = false;
      });
    } else if (msg == "canvas5") {
      setState(() {
        canvas4 = false;
        canvas5 = true;
        canvas6 = false;
      });
    } else if (msg == "canvas6") {
      setState(() {
        canvas4 = false;
        canvas5 = false;
        canvas6 = true;
      });
    } else if (msg == "canvas8") {
      setState(() {
        canvas1 = false;
        canvas2 = false;
        canvas3 = false;
        canvas8 = true;
        canvas9 = false;
      });
    }
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  GestureDetector FurnitureCard(String title, int num) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        pressCreateFurniture(num.toString());
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(12)),
        width: SizeConfig.screenWidth * 0.2,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenWidth * 0.2,
              width: SizeConfig.screenWidth * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.2,
              padding: EdgeInsets.all(getProportionalScreenHeight(6)),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Furniture")
                ], //change to title later and make fontsize as big as possible to fit
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getFurnitureData(BuildContext context) {
    List<dynamic> furnitureList = FURNITURE_DATA;
    List<Widget> listItems = [];

    for (var i = 0; i < furnitureList.length; i++) {
      if (i >= furnitureList.length - 2) {
        if (i == furnitureList.length - 2) {
          //2 more to go
          listItems.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FurnitureCard(furnitureList[i]["title"], furnitureList[i]["msg"]),
              FurnitureCard(
                  furnitureList[i + 1]["title"], furnitureList[i + 1]["msg"]),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionalScreenWidth(12)),
                  width: SizeConfig.screenWidth * 0.2)
            ],
          ));
          i++;
        } else {
          //1 more to go
          listItems.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FurnitureCard(furnitureList[i]["title"], furnitureList[i]["msg"]),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionalScreenWidth(24)),
                  width: SizeConfig.screenWidth * 0.4)
            ],
          ));
        }
      } else {
        //normal, make a row of 3
        listItems.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FurnitureCard(furnitureList[i]["title"], furnitureList[i]["msg"]),
            FurnitureCard(
                furnitureList[i + 1]["title"], furnitureList[i + 1]["msg"]),
            FurnitureCard(
                furnitureList[i + 2]["title"], furnitureList[i + 2]["msg"]),
          ],
        ));
        i += 2;
      }
    }

    return listItems; //for now
  }

  void pressCreateFurniture(String idx) {
    _unityWidgetController.postMessage(
      'MainManager',
      'createFurniture',
      idx,
    );
  }
}
