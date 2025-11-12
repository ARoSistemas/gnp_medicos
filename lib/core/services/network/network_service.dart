import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/services/network/auth_refresh_service.dart';

part 'api_base_provider.dart';

part 'api_exception.dart';

part 'http_exception.dart';

class NetworkService extends GetxService {}
