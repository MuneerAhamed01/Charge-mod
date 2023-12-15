class ApiService {
  static String api(String endpoint, {String appVersion = '1.0.0',bool ignoreAppVersion = false}) {
    if(ignoreAppVersion ){
      return '64941897fdb322dbf94ad2b8/6494141957d29409895704d2/$endpoint';
    }else{
      return '64941897fdb322dbf94ad2b8/6494141957d29409895704d2/$appVersion/$endpoint';
    }
  }
      
}
