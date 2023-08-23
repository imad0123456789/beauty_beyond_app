
import 'package:intl/intl.dart';

class DataConverted{
  static String getDate(DateTime date){
    return DateFormat.yMd().format(date);
  }

  static String getDay(int day){
    switch(day){
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Monday';
    }
  }

  static String getTime(int time ){
    switch(time){
      case 0:
        return '9:00 AM';
      case 1:
        return '10:00 AM';
      case 2:
        return '11:00 AM';
      case 3:
        return '12:00 PM';
      case 4:
        return '01:00 PM';
      case 5:
        return '02:00 PM';
      case 6:
        return '03:00 PM';
      case 7:
        return '04:00 PM';
      default:
        return '9:00 AM';
    }
  }
}