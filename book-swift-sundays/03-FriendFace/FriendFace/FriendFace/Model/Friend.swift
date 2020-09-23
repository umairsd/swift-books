import Foundation

struct Friend: Codable {
  var id: UUID
  var isActive: Bool
  var name: String
  var age: Int
  var company: String
  var email: String

  var address: String
  var about: String
  var registered: Date
  var tags: [String]
  var friends: [Connection]

  var printableFriendList: String {
    return friends.map { $0.name }.joined(separator: ", ")
  }
}


extension Array where Element == Friend {

  func matching(_ text: String?) -> [Friend] {
    if let text = text, text.count > 0 {
      return self.filter { f -> Bool in
        f.name.contains(text) || f.company.contains(text) || f.address.contains(text)
      }
    } else {
      return self
    }
  }

}
