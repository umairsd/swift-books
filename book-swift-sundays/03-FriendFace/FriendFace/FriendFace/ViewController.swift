import UIKit

class ViewController: UITableViewController {

  let dataSource = FriendDataSrouce()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    // Search
    let search = UISearchController(searchResultsController: nil)
    search.searchResultsUpdater = self
    search.obscuresBackgroundDuringPresentation = false
    search.searchBar.placeholder = "Find a friend"
    navigationItem.searchController = search

    dataSource.dataChanged = { [weak self] in
      self?.tableView.reloadData()
    }
    dataSource.fetchData()
    tableView.dataSource = dataSource
  }

}

extension ViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    dataSource.filterText = searchController.searchBar.text
  }

}
