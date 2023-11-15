import 'dart:convert';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_flutter/ably_flutter.dart';
import 'package:flutter/material.dart';

class AblyService {
  final ably.Realtime realtime;

  AblyService(this.realtime);

  Stream<Message> subscribeToChannel(String channelName) {
    debugPrint('channelName: $channelName');
    return realtime.channels.get(channelName.toLowerCase()).subscribe();
  }

  publishToChannel(String channelName, Map<String, dynamic> message) async {
    debugPrint('channelName: $channelName');
    await realtime.channels
        .get(channelName.toLowerCase())
        .publish(data: jsonEncode(message));
  }

  Future<PaginatedResult<Message>> getChannelhistory(String channelName) async {
    debugPrint('channelName: $channelName');
    return await realtime.channels.get(channelName.toLowerCase()).history();
  }
}
