import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../utils/print_utils.dart';

/// WebSocket地址
const String _SOCKET_URL = '';

/// WebSocket状态
enum SocketStatus {
  socketStatusConnected, // 已连接
  socketStatusFailed, // 失败
  socketStatusClosed, // 连接关闭
}

class WebSocketManager {
  static WebSocketManager? _instance;

  WebSocketManager._();

  factory WebSocketManager() {
    _instance ??= WebSocketManager._();
    return _instance!;
  }

  IOWebSocketChannel? _webSocket;
  SocketStatus? _socketStatus; //socket状态
  Timer? _heartBeat; // 心跳定时器
  final num _heartTimes = 3000; // 心跳间隔时间
  num _reconnectCount = 60; // 重连次数
  num _reconnectTimes = 0; // 重连计数器
  Timer? _reconnectTimer; //重连定时器
  late Function onError; // 错误回调
  late Function onOpen; // 连接回调
  late Function onMessage; // 接收消息回调

  void initWebSocket({required Function onOpen, required Function onMessage, required Function onError}) async {
    this.onOpen = onOpen;
    this.onMessage = onMessage;
    this.onError = onError;
    openSocket();
  }

  void openSocket() {
    if (_SOCKET_URL == "") {
      throw 'socket 地址不允许为空';
    }

    closeSocket();
    _webSocket = IOWebSocketChannel.connect(_SOCKET_URL);
    printBlue("websocket 连接成功");
    _socketStatus = SocketStatus.socketStatusConnected;
    // 连接成功后，重置重连计数器
    _reconnectCount = 0;
    if (_reconnectTimer != null) {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
    }

    onOpen();

    _webSocket?.stream.listen((event) => webSocketOnMessage(event), onError: (error) {
      webSocketOnError(error);
    }, onDone: () {
      webSocketOnDone();
    });
  }

  webSocketOnMessage(data) {
    onMessage(data);
  }

  // websocket 关闭了连接回调
  webSocketOnDone() {
    printBlue("关闭");
    _socketStatus = SocketStatus.socketStatusClosed;
    reconnect();
  }

  webSocketOnError(error) {
    WebSocketChannelException ex = error;
    _socketStatus = SocketStatus.socketStatusFailed;
    onError(ex.message);
    closeSocket();
  }

  // 初始化心跳
  initHeartBeat() {
    destroyHeartBeat();
    _heartBeat = Timer.periodic(Duration(milliseconds: _heartTimes.toInt()), (timer) {
      sentHeart();
    });
  }

  sentHeart() {
    sendMessage('{"module": "HEART_CHECK", "message": "请求心跳"}');
  }

  destroyHeartBeat() {
    if (_heartBeat != null) {
      _heartBeat?.cancel();
      _heartBeat = null;
    }
  }

  closeSocket() {
    _webSocket?.sink.close();
    destroyHeartBeat();
    _socketStatus = SocketStatus.socketStatusClosed;
  }

  sendMessage(message) {
    if (_webSocket != null) {
      switch (_socketStatus!) {
        case SocketStatus.socketStatusConnected:
          printBlue("发送中 $message");
          _webSocket?.sink.add(message);
          break;
        case SocketStatus.socketStatusClosed:
          printBlue("关闭 $message");
          break;
        case SocketStatus.socketStatusFailed:
          printBlue("发送失败 $message");
          break;
      }
    }
  }

  reconnect() {
    if (_reconnectTimes < _reconnectCount) {
      _reconnectTimes++;
      _reconnectTimer = Timer(Duration(milliseconds: _heartTimes.toInt()), () {
        printBlue("重连中");
        openSocket();
      });
    } else {
      if (_reconnectTimer != null) {
        printBlue("重连失败");
        _reconnectTimes = 0;
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
      } else {
        return;
      }
    }
  }

  get socketStatus => _socketStatus;

  get websocketCloseCode => _webSocket?.closeCode;
}
