import UIKit

class MemoryDataSource: NSObject {
  var items = [MemoryItem]()

  override init() {
    super.init()
    loadData()
  }

  // MARK: Public API

  func item(at index: Int) -> MemoryItem {
    return items[index]
  }


  // MARK: - Private

  private func loadData() {
    guard let url = Bundle.main.url(forResource: "MemoryItems", withExtension: "json") else {
      fatalError("Unable to find MemoryItems.json")
    }

    guard let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load data for MemoryItems.json")
    }

    let decoder = JSONDecoder()
    guard let savedItems = try? decoder.decode([MemoryItem].self, from: data) else {
      fatalError("Failed to decode MemoryItems.json")
    }

    items = savedItems
  }
}


extension MemoryDataSource: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    let item = items[indexPath.row]
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.text

    return cell
  }
}
