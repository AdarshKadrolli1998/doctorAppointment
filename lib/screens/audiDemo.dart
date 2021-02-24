import 'dart:async';

import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:doctor/common/MyColors.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

import 'package:audio_wave/audio_wave.dart';

class PlayIcon extends StatefulWidget {
// int initialvalue;
// PlayIcon(this.initialvalue);

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<PlayIcon> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: SafeArea(
          child: new RecorderExample(),
        ),
      ),
    );
  }
}

class RecorderExample extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  RecorderExample({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StatefulWidget> createState() => new RecorderExampleState();
}

class RecorderExampleState extends State<RecorderExample>
// with SingleTickerProviderStateMixin
{
// AnimationController _animationController;
// bool isPlaying = false;

  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool viewVisible = false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
// _animationController =
// AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new Center(
          child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Audio recording : ${_current?.duration.toString()}"),
                      FlatButton(
                          onPressed: _currentStatus != RecordingStatus.Unset ? _stop : null,
                          child: Text(
                            "Save for Later",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.themeColor,
                                fontSize: 20),
                          ))
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.lightBlue[50],
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: viewVisible,
                          child: AudioWave(
                            height: 150,
                            width: 387,
                            spacing: 2.5,
                            bars: [
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 70, color: MyColors.themeColor),
                              AudioWaveBar(height: 50, color: MyColors.themeColor),
                              AudioWaveBar(height: 40, color: MyColors.themeColor),
                              AudioWaveBar(height: 20, color: MyColors.themeColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {
                            switch (_currentStatus) {
                              case RecordingStatus.Initialized:
                                {
                                  _start();
                                  break;
                                }
                              case RecordingStatus.Recording:
                                {
                                  _pause();
                                  break;
                                }
                              case RecordingStatus.Paused:
                                {
                                  _resume();
                                  break;
                                }
                              case RecordingStatus.Stopped:
                                {
                                  _init();
                                  break;
                                }
                              default:
                                break;
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: MyColors.themeColor,
                            child: _buildText(_currentStatus),
                            radius: 30,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed:(){},
                        child: Icon(Icons.cloud_upload,size: 75,color: MyColors.themeColor,)
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white54,
                        child: Icon(Icons.delete,color: Colors.red,size: 50,),
                        radius: 35,
                      ),
                      // FlatButton(
                      //   onPressed:
                      //       _currentStatus != RecordingStatus.Unset ? _stop : null,
                      //   child: CircleAvatar(
                      //     child: Icon(
                      //       Icons.play_circle_fill,
                      //       size: 40,
                      //     ),
                      //     radius: 40,
                      //   ),
                      // ),
                    ],
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  _init() async {
    try {
      viewVisible = false;
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
        // io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }
        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

          // .wav <---> AudioFormat.WAV
          // .mp4 .m4a .aac <---> AudioFormat.AAC
          // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        viewVisible = true;
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder.resume();
    setState(() {
      viewVisible = true;
    });
  }

  _pause() async {
    await _recorder.pause();
    setState(() {
      viewVisible = false;
    });
  }

  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = widget.localFileSystem.file(result.path);
    print("File length: ${await file.length()}");
    setState(() {
      viewVisible = false;
      _current = result;
      _currentStatus = _current.status;
    });
  }

  Widget _buildText(RecordingStatus status) {
    var icon;
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          icon = Icons.not_started;
          break;
        }
      case RecordingStatus.Recording:
        {
          icon = Icons.pause;
          break;
        }
      case RecordingStatus.Paused:
        {
          icon = Icons.play_arrow;
          break;
        }
      case RecordingStatus.Stopped:
        {
          icon = Icons.stop_outlined;
          break;
        }
      default:
        break;
    }
    return Icon(icon, color: Colors.white,size: 40,);
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current.path, isLocal: true);
  }
}
