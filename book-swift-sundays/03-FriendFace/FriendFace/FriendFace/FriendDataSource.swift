import UIKit

class FriendDataSrouce: NSObject, UITableViewDataSource {

  var friends = [Friend]()
  var filteredFriends = [Friend]()
  var dataChanged: (() -> Void)?

  var filterText: String? {
    didSet {
      filteredFriends = friends.matching(filterText)
      dataChanged?()
    }
  }

  func fetchData() {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let url = "https://www.hackingwithswift.com/samples/friendface.json"

    decoder.decode([Friend].self, fromURL: url) { friends in
      self.filteredFriends = friends
      self.friends = friends
      self.dataChanged?()
    }
  }

  // MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredFriends.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let friend = filteredFriends[indexPath.row]

    cell.textLabel?.text = friend.name
    cell.detailTextLabel?.text = friend.printableFriendList
    return cell
  }

}
