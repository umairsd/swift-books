import Foundation


struct Plane: Decodable, Encodable {
  var manufacturer: String
  var model: String
  var seats: Int

  private enum CodingKeys: String, CodingKey {
    case manufacturer
    case model
    case seats
  }

  /// MARK: Decodable

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
    self.model = try container.decode(String.self, forKey: .model)
    self.seats = try container.decode(Int.self, forKey: .seats)
  }

  /// MARK: Encodable

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.manufacturer, forKey: .manufacturer)
    try container.encode(self.model, forKey: .model)
    try container.encode(self.seats, forKey: .seats)
  }
}

let json = """
{
  "manufacturer": "Cessna",
  "model": "172 Skyhawk",
  "seats": 4,
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
do {
  let plane = try decoder.decode(Plane.self, from: json)
  print(plane.manufacturer)

  let encoder = JSONEncoder()
  let reencodedJSON = try! encoder.encode(plane)
  print(String(data: reencodedJSON, encoding: .utf8)!)

} catch {
  print("Error decoding JSON: \(error.localizedDescription)")
}




let jsonObjectData = """
{
  "planes": [
  {
    "manufacturer": "Cessna",
    "model": "172 Skyhawk",
    "seats": 4,
  },
  {
    "manufacturer": "Piper",
    "model": "PA-28 Cherokee",
    "seats": 4,
  }
  ]
}
""".data(using: .utf8)!

let keyedPlanes = try! decoder.decode([String: [Plane]].self, from: jsonObjectData)
let planes = keyedPlanes["planes"]

struct Fleet: Decodable {
  var planes: [Plane]
}

let fleet = try! decoder.decode(Fleet.self, from: jsonObjectData)
let fleetPlanes = fleet.planes
