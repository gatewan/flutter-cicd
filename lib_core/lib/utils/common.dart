import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String formattedDate(DateTime dateTime) => DateFormat.yMMMMd('en_US').format(dateTime);
