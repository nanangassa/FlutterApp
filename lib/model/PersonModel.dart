import 'dart:convert';

Person clientFromJson(String str) {
    final jsonData = json.decode(str);
    return Person.fromMap(jsonData);
}

String clientToJson(Person data) {
    final dyn = data.toMap();
    return json.encode(dyn);
}

class Person {
    int personId;
    String firstName;
    String lastName;
    int temporaryCode;
    String country;
    String province;
    String city;
    String streetName;
    int streetNumber;
    int unitNumber;
    String postalCode;
    String mark;
    int sign = 0;
    int volunteer = 0;
    int donate = 0;
    int phoneNumber;
    String email;
    String notes;

    Person({
        this.personId,
        this.firstName,
        this.lastName,
        this.temporaryCode,
        this.country,
        this.province,
        this.city,
        this.streetName,
        this.streetNumber,
        this.unitNumber,
        this.postalCode,
        this.mark,
        this.sign,
        this.volunteer,
        this.donate,
        this.phoneNumber,
        this.email,
        this.notes,
    });

    factory Person.fromMap(Map<String, dynamic> json) => new Person(
        personId: json["personId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        temporaryCode: json["temporaryCode"],
        country: json["country"],
        province: json["province"],
        city: json["city"],
        streetName: json["streetName"],
        streetNumber: json["streetNumber"],
        unitNumber: json["unitNumber"],
        postalCode: json["postalCode"],
        mark: json["mark"],
        sign: json["sign"],
        volunteer: json["volunteer"],
        donate: json["donate"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        notes: json["notes"],
    );

    Map<String, dynamic> toMap() => {
        "personId": personId,
        "firstName": firstName,
        "lastName": lastName,
        "temporaryCode": temporaryCode,
        "country": country,
        "province": province,
        "city": city,
        "streetName": streetName,
        "streetNumber": streetNumber,
        "unitNumber": unitNumber,
        "postalCode": postalCode,
        "mark": mark,
        "sign": sign,
        "volunteer": volunteer,
        "donate": donate,
        "phoneNumber": phoneNumber,
        "email": email,
        "notes": notes,
    };
}
