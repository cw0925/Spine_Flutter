import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/spine/spine_core/spine_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'spine/flutter_spine.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SkeletonAnimation _skeleton;
  SkeletonAnimation _raptorSkeleton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // downloadResoource();
    _loadSkeleton();
  }

  downloadResoource() async {
    bool isPermiss = await checkPermissFunction();
    if (isPermiss) {
      String savePath = await getPhoneLocalPath();
      String fileName = 'Girl_2.json';
      String path = savePath + '/' + fileName;
      print('文件存储路径:' + savePath);
      downloadFile('http://47.117.135.240:8080/files/avatar/Girl_2/Girl_2.json',
              path)
          .then((value) {
        print(value.toString());
      }).catchError((err) {
        print(err.toString());
      });
    } else {
      print('申请存储权限');
    }
  }

  Future<bool> checkPermissFunction() async {
    if (Platform.isAndroid) {
      ///安卓平台中 checkPermissionStatus方法校验是否有储存卡的读写权限
      if (await Permission.storage.request().isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  ///获取手机的存储目录路径
  ///getExternalStorageDirectory() 获取的是  android 的外部存储 （External Storage）
  ///  getApplicationDocumentsDirectory 获取的是 ios 的Documents` or `Downloads` 目录
  Future<String> getPhoneLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Stack(children: <Widget>[
        Positioned.fill(
          bottom: 100,
            child: SkeletonRenderObjectWidget(
          skeleton: _skeleton,
          alignment: Alignment.center,
          fit: BoxFit.contain,
          playState: PlayState.Playing,
        )),
        Positioned.fill(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(1.0),
                child: OutlinedButton(
                  child: const Text('下载资源',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    downloadResoource();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      //设置按下时的背景颜色
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blue[200];
                      }
                      //默认不使用背景颜色
                      return Colors.blue;
                    }),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.all(1.0),
                    child: OutlinedButton(
                        child: const Text('Jump',style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue[200];
                            }
                            //默认不使用背景颜色
                            return Colors.blue;
                          }),
                        ),
                        onPressed: () {
                          _skeleton.state
                            ..setAnimation(0, 'jump', false)
                            ..addAnimation(0, 'walk', true, 0.0);
                        })),
                Container(
                    margin: const EdgeInsets.all(1.0),
                    child: OutlinedButton(
                        child: const Text('Shoot',style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue[200];
                            }
                            //默认不使用背景颜色
                            return Colors.blue;
                          }),
                        ),
                        onPressed: () {
                          setState(() {
                            _skeleton.state
                              ..setAnimation(0, 'shoot', false)
                              ..addAnimation(0, 'walk', true, 0.0);
                          });
                        })),
                Container(
                    margin: const EdgeInsets.all(1.0),
                    child: OutlinedButton(
                        child: const Text('Death',style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue[200];
                            }
                            //默认不使用背景颜色
                            return Colors.blue;
                          }),
                        ),
                        onPressed: () {
                          setState(() {
                            _skeleton.state
                              ..setAnimation(0, 'death', false)
                              ..addAnimation(0, 'walk', true, 0.0);
                          });
                        })),
                Container(
                    margin: const EdgeInsets.all(1.0),
                    child: OutlinedButton(
                        child: const Text('换装',style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue[200];
                            }
                            //默认不使用背景颜色
                            return Colors.blue;
                          }),
                        ),
                        onPressed: () {
                          this.change();
                        })),
              ],
            )
          ],
        ))
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _loadSkeleton() async {
    String path = await getPhoneLocalPath() + '/';
    print('path==：' + path);
    // SkeletonAnimation.createWithFiles(
    //   'Girl_2.atlas',
    //   'Girl_2.json',
    //   'Girl_2.png',
    //   pathPrefix: 'assets/Girl_2/',
    // ).then((SkeletonAnimation skeleton) {
    //   // skeleton.setSkinByName('goblin');
    //   skeleton.state.setAnimation(0, 'animation', true);
    //   setState(() => _skeleton = skeleton);
    // });

    // SkeletonAnimation.createWithFiles(
    //   'spineboy.atlas',
    //   'spineboy.json',
    //   'spineboy.png',
    //   pathPrefix: 'assets/boy/',
    // ).then((SkeletonAnimation skeleton) {
    //   // skeleton.setSkinByName('goblin');
    //   skeleton.state.setAnimation(0, 'walk', true);
    //   setState(() => _skeleton = skeleton);
    // });

    SkeletonAnimation.createWithFiles(
      'Nv_01.atlas',
      'Nv_01.json',
      'Nv_01.png',
      pathPrefix: 'assets/girl_2_red/',
    ).then((SkeletonAnimation skeleton) {
      skeleton.state.setAnimation(0, 'animation', true);
      setState(() => _raptorSkeleton = skeleton);
    });
  }

  change() {
    // var parts = ["Hair"];
    // for (int i = 0; i < parts.length; i++) {
    //   Slot slot1 = _skeleton.findSlot(parts[i]);
    //   Slot slot2 = _raptorSkeleton.findSlot(parts[i]);
    //   Attachment attachment = slot2.getAttachment();
    //   slot1.setAttachment(attachment);
    // }
    Slot slot1 = _skeleton.findSlot('Hair2');
    Slot slot2 = _skeleton.findSlot('Hair');
    Attachment attachment = slot2.getAttachment();
    slot1.setAttachment(attachment);
  }
  changeSkin(){

    SkeletonAnimation.createWithFiles(
      'Girl_2.atlas',
      'Girl_2.json',
      'Girl_2.png',
      pathPrefix: 'assets/Girl_2/',
    ).then((SkeletonAnimation skeleton) {
      // skeleton.setSkinByName('goblin');
      skeleton.state.setAnimation(0, 'animation', true);
      setState(() => _raptorSkeleton = skeleton);

      Slot slot1 = _skeleton.findSlot('Hair2');
      Slot slot2 = _raptorSkeleton.findSlot('Hair');
      Attachment attachment = slot2.getAttachment();
      slot1.setAttachment(attachment);

    });
  }
  clear(){
    Slot slot = _skeleton.findSlot('Hair2');
    slot.setToSetupPose();
  }
}
