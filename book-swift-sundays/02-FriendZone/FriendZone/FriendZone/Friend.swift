import Foundation

struct Friend: Codable {
  var name: String = "New friend"
  var timeZone: TimeZone = TimeZone.current
}
