import 'dart:async';
import 'dart:io' as io;

import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class RecorderExample extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  RecorderExample({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StatefulWidget> createState() => new RecorderExampleState();
}

class RecorderExampleState extends State<RecorderExample> {
  bool viewVisible = false;
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(
          children: [
            Text(
              "${_current?.duration.toString()}",
              style: TextStyle(fontSize: 17),
            ),
            FlatButton(
                padding: const EdgeInsets.only(left: 175),
                onPressed: () {},
                child: Text(
                  "Save for later",
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ))
          ],
        ),
        Row(
          children: [
            Container(
                height: 250,
                width: 400,
                child: Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,
                  child: AudioWave(
                    height: 200,
                    spacing: 1.5,
                    width: 400,
                    bars: [
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 30, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 60, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 40, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 20, color: Colors.lightBlueAccent),
                      AudioWaveBar(height: 10, color: Colors.lightBlueAccent),
                    ],
                  ),
                )
            )
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton(
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
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lightBlue,
                ),
                child: _buildText(_currentStatus),
              ),
            ),
            FlatButton(
              onPressed: _currentStatus != RecordingStatus.Unset ? _stop : null,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.stop, color: Colors.white),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
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
        _current = recording;
        viewVisible = true;
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
          _currentStatus = _current.status;
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
      _current = result;
      _currentStatus = _current.status;
      viewVisible = false;
    });
  }

  Widget _buildText(RecordingStatus status) {
    var icon;
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          icon = Icons.play_arrow;
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
          icon = Icons.not_started;
          break;
        }
      default:
        break;
    }
    return Icon(
      icon,
      color: Colors.white,
    );
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current.path, isLocal: true);
  }
}
