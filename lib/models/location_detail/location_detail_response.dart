import 'result.dart';

/// html_attributions : []
/// result : {"address_components":[{"long_name":"12345","short_name":"12345","types":["street_number"]},{"long_name":"Ventura Boulevard","short_name":"Ventura Blvd","types":["route"]},{"long_name":"North Hollywood","short_name":"NoHo","types":["neighborhood","political"]},{"long_name":"Los Angeles","short_name":"Los Angeles","types":["locality","political"]},{"long_name":"Los Angeles County","short_name":"Los Angeles County","types":["administrative_area_level_2","political"]},{"long_name":"California","short_name":"CA","types":["administrative_area_level_1","political"]},{"long_name":"United States","short_name":"US","types":["country","political"]},{"long_name":"91604","short_name":"91604","types":["postal_code"]}],"adr_address":"<span class=\"street-address\">12345 Ventura Blvd</span>, <span class=\"locality\">North Hollywood</span>, <span class=\"region\">CA</span> <span class=\"postal-code\">91604</span>, <span class=\"country-name\">USA</span>","formatted_address":"12345 Ventura Blvd, North Hollywood, CA 91604, USA","geometry":{"location":{"lat":34.1431542,"lng":-118.402161},"viewport":{"northeast":{"lat":34.1444095302915,"lng":-118.4007997697085},"southwest":{"lat":34.1417115697085,"lng":-118.4034977302915}}},"icon":"https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png","name":"12345 Ventura Blvd","place_id":"ChIJMfcU-fq9woARwhFTK-5eYA8","plus_code":{"compound_code":"4HVX+74 North Hollywood, Los Angeles, CA, USA","global_code":"85634HVX+74"},"reference":"ChIJMfcU-fq9woARwhFTK-5eYA8","types":["street_address"],"url":"https://maps.google.com/?q=12345+Ventura+Blvd,+North+Hollywood,+CA+91604,+USA&ftid=0x80c2bdfaf914f731:0xf605eee2b5311c2","utc_offset":-420,"vicinity":"Los Angeles"}
/// status : "OK"

class LocationDetailResponse {
  var htmlAttributions;
  var result;
  var status;

  LocationDetailResponse({
      this.htmlAttributions, 
      this.result, 
      this.status});

  LocationDetailResponse.fromJson(dynamic json) {

    result = json["result"] != null ? Result.fromJson(json["result"]) : null;
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (result != null) {
      map["result"] = result.toJson();
    }
    map["status"] = status;
    return map;
  }

}