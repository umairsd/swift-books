import UIKit

class ViewController: UITableViewController {

  private let dataSource = MemoryDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = dataSource
  }

  // MARK: - TableView

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = storyboard?.instantiateViewController(
            withIdentifier: MemoryViewController.storyboardIdentifier) as? MemoryViewController
    else {
      fatalError("Unable to instantiate memory view controller")
    }

    vc.item = dataSource.item(at: indexPath.row)
    navigationController?.pushViewController(vc, animated: true)
  }
}

