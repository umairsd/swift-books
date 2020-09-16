import UIKit

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

