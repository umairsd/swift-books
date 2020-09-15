import UIKit

let jsonStr = """
{
  "aircraft": {
    "identification": "NA12345",
    "color": "Blue/White"
  },
  "route": ["KTTD", "KHIO"],
  "flight_rules": "VFR",
  "departure_time": {
    "proposed": "2018-04-20T14:15:00-07:00",
    "actual": "2018-04-20T14:20:00-07:00"
  },
  "remarks": null
}
"""

struct Aircraft: Decodable {
  var identification: String
  var color: String
}

struct FlightPlan: Decodable {
  var aircraft: Aircraft
  var route: [String]
  var flightRules: FlightRules
  private var departureDates: [String: Date]
  var remarks: String?

  var proposedDepartureDate: Date? {
    return departureDates["proposed"]
  }
  var actualDepartureDate: Date? {
    return departureDates["actual"]
  }

  private enum CodingKeys: String, CodingKey {
    case aircraft
    case route
    case flightRules = "flight_rules"
    case departureDates = "departure_time"
    case remarks
  }
}

enum FlightRules: String, Decodable {
  case visual = "VFR"
  case instrument = "IFR"
}


let jsonData = jsonStr.data(using: .utf8)!
var decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601

let plan = try! decoder.decode(FlightPlan.self, from: jsonData)
print(plan.aircraft.identification)
