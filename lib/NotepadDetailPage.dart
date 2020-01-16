import 'package:flutter/material.dart';
import 'package:notepad_core/notepad_core.dart';

import 'notepad_isolate.dart';

class NotepadDetailPage extends StatefulWidget {
  final scanResult;

  NotepadDetailPage(this.scanResult);

  @override
  State<StatefulWidget> createState() => _NotepadDetailPageState();
}

class _NotepadDetailPageState extends State<NotepadDetailPage> implements NotepadClientCallback {
  @override
  void initState() {
    super.initState();
    notepadConnector.connectionChangeHandler = _handleConnectionChange;
    notepadConnector.connect(widget.scanResult);
  }

  @override
  void dispose() {
    super.dispose();
    notepadConnector.disconnect();
    notepadConnector.connectionChangeHandler = null;
  }

  NotepadClient _notepadClient;

  void _handleConnectionChange(NotepadClient client, NotepadConnectionState state) {
    print('_handleConnectionChange $client $state');
    if (state == NotepadConnectionState.connected) {
      client.setMode(NotepadMode.Sync).then((onValue) {
        _notepadClient = client;
        _notepadClient.callback = this;
      });
    } else {
      _notepadClient?.callback = null;
      _notepadClient = null;
    }
  }

  final List<NotePenPointer> _syncPointers = <NotePenPointer>[];

  @override
  void handlePointer(List<NotePenPointer> list) {
    print('handlePointer ${list.length}');
    setState(() => _syncPointers.addAll(list));
  }

  @override
  void handleEvent(NotepadEvent notepadEvent) {
    print('handleEvent $notepadEvent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotepadDetailPage'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('promoteToForeground'),
            onPressed: () {
              NotepadIsolatePlugin.promoteToForeground();
            },
          ),
          RaisedButton(
            child: Text('demoteToBackground'),
            onPressed: () {
              NotepadIsolatePlugin.demoteToBackground();
            },
          ),
          Center(
            child: Text('syncPointers ${_syncPointers.length}'),
          ),
        ],
      ),
    );
  }
}
