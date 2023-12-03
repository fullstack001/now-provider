import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

Echo initSocketIOClient() {
  IO.Socket socket = IO.io('https://api.farenow.com');
  Echo echo = Echo(client: socket);
  socket.on('connect', (_) {
    print('connected');
  });
  socket.on('disconnect', (_) {
    print("Socket disconnect");
  });
  return echo;
}
