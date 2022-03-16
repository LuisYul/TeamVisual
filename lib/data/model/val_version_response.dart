class ValVersionResponse {

  String? valVersion;
  
  ValVersionResponse({
    required this.valVersion,
  }); 
  
  factory ValVersionResponse.fromMap(Map<String, dynamic> json) {
    return ValVersionResponse(
        valVersion: json['valVersion'],
    );
  }

}