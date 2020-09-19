import UIKit

/// Flight School Guide to Swift - Codable
///

let json = """
{
  "points": ["KSQL", "KWVI"],
  "KSQL": {
    "code": "KSQL",
    "name": "San Carlos Airport"
  },
  "KWVI": {
    "code": "KWVI",
    "name": "Watsonville Municipal Airport"
  }
}
"""


struct Route: Decodable {
  struct Airport: Decodable {
    var code: String
    var name: String
  }

  var points: [Airport]

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: RouteCodingKeys.self)

    var points: [Airport] = []

    // Gets the array of points. Each point is of type `String`.
    let codes = try container.decode([String].self, forKey: .points)

    for code in codes {
      let key = RouteCodingKeys(stringValue: code)!
      let airport = try container.decode(Airport.self, forKey: key)
      points.append(airport)
    }

    self.points = points
  }

  private struct RouteCodingKeys: CodingKey {
    var stringValue: String

    init?(stringValue: String) {
      self.stringValue = stringValue
    }

    var intValue: Int? {
      return nil
    }

    init?(intValue: Int) {
      return nil
    }

    static let points = RouteCodingKeys(stringValue: "points")!
  }
}

// ---------------


let birdJson = """
[
  {
    "type": "bird",
    "genus": "Chaetura",
    "species": "Vauxi"
  },
  {
    "type": "plane",
    "identifier": "NA12345"
  }
]
""".data(using: .utf8)!

struct Bird: Decodable {
  var genus: String
  var species: String
}

struct Plane: Decodable {
  var identifier: String
}

enum Either<L,R> {
  case left(L)
  case right(R)
}

extension Either: Decodable where L: Decodable, R: Decodable {

  init(from decoder: Decoder) throws {
    if let value = try? L(from: decoder) {
      self = .left(value)
    } else if let value = try? R(from: decoder) {
      self = .right(value)
    } else {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Cannot decode \(L.self) or \(R.self)")
      throw DecodingError.dataCorrupted(context)
    }
  }
}

let weirdJson = """
[
  {
    "type": "bird",
    "genus": "Chaetura",
    "species": "Vauxi"
  },
  {
    "type": "plane",
    "identifier": "NA12345"
  },
  {
    "type": "animal",
    "name": "Dog"
  }
]
""".data(using: .utf8)!

struct Animal: Decodable {
  var name: String
}

enum Triple<T,U,V> {
  case left(T)
  case middle(U)
  case right(V)
}

extension Triple: Decodable where T: Decodable, U: Decodable, V: Decodable {

  init(from decoder: Decoder) throws {
    if let value = try? T(from: decoder) {
      self = .left(value)
    } else if let value = try? U(from: decoder) {
      self = .middle(value)
    } else if let value = try? V(from: decoder) {
      self = .right(value)
    } else {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Cannot decode \(T.self), \(U.self), or \(V.self)")
      throw DecodingError.dataCorrupted(context)
    }
  }
}

let decoder = JSONDecoder()
let objects = try! decoder.decode([Triple<Animal, Plane, Bird>].self, from: weirdJson)

for o in objects {

  switch o {
    case .left(let animal):
      print("Animal: \(animal.name)")
      break

    case .middle(let plane):
      print("Plane: \(plane.identifier)")
      break

    case .right(let bird):
      print("Bird: \(bird.genus)")
      break
  }
}


/**
let json = """
{
  "points": ["KSQL", "KWVI"],
  "KSQL": {
    "code": "KSQL",
    "name": "San Carlos Airport"
  },
  "KWVI": {
    "code": "KWVI",
    "name": "Watsonville Municipal Airport"
  }
}
"""
let jsonData = json.data(using: .utf8)!


struct Route: Decodable {
  struct Airport: Decodable {
    var code: String
    var name: String
  }

  var points: [Airport]

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    var points: [Airport] = []
    let codes = try container.decode([String].self, forKey: .points)

    for code in codes {
      let key = CodingKeys(stringValue: code)!
      let airport = try container.decode(Airport.self, forKey: key)
      points.append(airport)
    }
    self.points = points
  }

  private struct CodingKeys: CodingKey {
    var stringValue: String

    var intValue: Int? {
      return nil
    }

    init?(stringValue: String) {
      self.stringValue = stringValue
    }

    init?(intValue: Int) {
      return nil
    }

    static let points = CodingKeys(stringValue: "points")!
  }
}

let decoder = JSONDecoder()
let route = try decoder.decode(Route.self, from: jsonData)
print(route.points.first?.code ?? "")


let json2Data = """
[
  {
    "type": "bird",
    "genus": "Chaetura",
    "species": "Vauxi"
  },
  {
    "type": "plane",
    "identifier": "NA12345"
  }
]
""".data(using: .utf8)!

struct Bird: Decodable {
  var genus: String
  var species: String
}

struct Plane: Decodable {
  var identifier: String
}

enum Either<T, U> {
  case left(T)
  case right(U)
}

extension Either: Decodable where T: Decodable, U: Decodable {

  init(from decoder: Decoder) throws {
    if let value = try? T(from: decoder) {
      self = .left(value)
    } else if let value = try? U(from: decoder) {
      self = .right(value)
    } else {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Cannot decode \(T.self) or \(U.self)")
      throw DecodingError.dataCorrupted(context)
    }
  }
}

let objects = try! decoder.decode([Either<Bird, Plane>].self, from: json2Data)
for object in objects {
  switch object {
    case .left(let bird):
      print("Its a bird!! \(bird.genus)")

    case .right(let plane):
      print("Its a Plaaannnnnne! \(plane.identifier)")

  }
}

*/

// American
// (prices in USD/gallon)
let jsonUSD = """
[
  {
    "fuel": "100LL",
    "price": 5.6
  },
  {
    "fuel": "Jet A",
    "price": 4.1
  }
]
"""

// Canadian
// (prices in CAD/liter)
let jsonCAD = """
[
  {
    "fuel": "100LL",
    "price": 2.54
  },
  {
    "fuel": "Jet A",
    "price": 3.14
  },
  {
    "fuel": "Jet B",
    "price": 3.03
  },
]
"""

enum Fuel: String, Decodable {
  case jetA = "Jet A"
  case jetB = "Jet B"
  case oneHundredLowLead = "100LL"
}

struct AmericanFuelPrice: Decodable {
  let fuel: Fuel
  /// USD / gallon
  let price: Decimal
}

struct CanadianFuelPrice: Decodable {
  let fuel: Fuel
  /// CAD / liter
  let price: Decimal
}

protocol FuelPrice {
  var type: Fuel { get }
  var pricePerLiter: Decimal { get }
  var currency: String { get }
}

extension AmericanFuelPrice: FuelPrice {
  var type: Fuel {
    return self.fuel
  }
  var pricePerLiter: Decimal {
    return self.price / 3.78541
  }
  var currency: String {
    return "USD"
  }
}

extension CanadianFuelPrice: FuelPrice {
  var type: Fuel {
    return self.fuel
  }
  var pricePerLiter: Decimal {
    return self.price
  }
  var currency: String {
    return "USD"
  }
}
