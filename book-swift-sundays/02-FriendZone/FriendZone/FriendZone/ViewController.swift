import UIKit

class ViewController: UITableViewController {

  var friends = [Friend]()

  var selectedFriend = -1

  // MARK: ViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    loadData()

    title = "Friend Zone"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addFriend))
  }

  // MARK: Data

  private func loadData() {
    let defaults = UserDefaults.standard
    guard let savedData = defaults.data(forKey: "Friend") else {
      return
    }

    let decoder = JSONDecoder()
    guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else {
      return
    }
    friends = savedFriends
  }

  private func saveData() {
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    guard let savedData = try? encoder.encode(friends) else {
      fatalError("Unable to encode friends data.")
    }
    defaults.set(savedData, forKey: "Friends")
  }

  @objc private func addFriend() {
    let friend = Friend()
    friends.append(friend)
    tableView.insertRows(
      at: [IndexPath(row: friends.count - 1, section: 0)],
      with: .automatic)
    saveData()

    configure(friend: friend, position: friends.count - 1)
  }

  // MARK: Friend

  func configure(friend: Friend, position: Int) {
    guard let vc = storyboard?.instantiateViewController(
      identifier: FriendViewController.storyboardIdentifier) as? FriendViewController
    else {
      fatalError("Unable to find FriendViewController")
    }
    vc.friend = friend
    vc.delegate = self
    navigationController?.pushViewController(vc, animated: true)

    selectedFriend = position
  }

  func update(friend: Friend) {
    guard selectedFriend >= 0 else { return }

    tableView.reloadData()
    friends[selectedFriend] = friend
    saveData()
  }

  // MARK: UITableViewController

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return friends.count
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let friend = friends[indexPath.row]
    cell.textLabel?.text = friend.name

    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = friend.timeZone
    dateFormatter.timeStyle = .short

    cell.detailTextLabel?.text = dateFormatter.string(from: Date())
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    configure(friend: friends[indexPath.row], position: indexPath.row)
  }

}

