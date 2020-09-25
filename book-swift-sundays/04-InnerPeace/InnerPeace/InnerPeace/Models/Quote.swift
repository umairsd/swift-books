import Foundation

struct Quote: Codable {
  var text: String
  var author: String

  var shareMessage: String {
    return "\(text) - \(author)"
  }
}
