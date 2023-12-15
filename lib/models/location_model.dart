class Location {
  late final String id;
  late final String name;
  late final int phone;
  late final String image;
  late final String street1;
  late final String street2;
  late final String city;
  late final String state;
  late final String country;
  late final String zip;
  late final String status;
  Location({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.country,
    required this.zip,
    required this.status,
  });

  String get locationString =>  '$street1 $street2 $city $state $country'; 

  Location.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    street1 = json['street1'];
    street2 = json['street2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    status = json['status'];
  }

  

  Location copyWith({
     String? id,
     String? name,
     int? phone,
     String? image,
     String? street1,
     String? street2,
     String? city,
     String? state,
     String? country,
     String? zip,
     String? status,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      street1: street1 ?? this.street1,
      street2: street2 ?? this.street2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      status: status ?? this.status,
    );
  }
}
