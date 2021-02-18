class Appointment {
  String id;
  String date;
  String name;
  String location;
  String doctorName;
  String status;
  String appointmentTime;

  Appointment(this.date, this.location, this.name,
      this.doctorName, this.status, this.appointmentTime);
   Appointment.withId(
      this.id,
      this.date,
      this.location,
      this.name,
      this.doctorName,
      this.status,
      this.appointmentTime);

  String get _id => this.id;
  String get _date => this.date;
  String get _location => this.location;
  String get _name => this.name;
  String get _doctorName => this.doctorName;
  String get _status => this.status;
  String get _appointmentTime => this.appointmentTime;

  set _date(String date) {
    this.date = date;
  }

  set _location(String location) {
    this.location = location;
  }

  set _name(String name) {
    this.name = name;
  }

  set _doctorName(String doctorName) {
    this.doctorName = doctorName;
  }

  set _status(String status) {
    this.status = status;
  }

  set _appointmentTime(String appointmentTime) {
    this.appointmentTime = appointmentTime;
  }

  Appointment.fromSnapShot(snapshot) {
    this.id = snapshot.key;
    this._date = snapshot.value['date'];
    this._location = snapshot.value['location'];
    this._name = snapshot.value['name'];
    this._doctorName = snapshot.value['doctorName'];
    this._status = snapshot.value['status'];
    this._appointmentTime = snapshot.value['appointmentTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "location": location,
      "name": name,
      "doctorName": doctorName,
      "status": status,
      "appointmentTime": appointmentTime,
    };
  }
}