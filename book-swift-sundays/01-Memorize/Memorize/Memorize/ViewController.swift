import UIKit

class ViewController: UITableViewController {

  let dataSource = MemoryDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = dataSource
  }

  // MARK: UITableViewController


  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = storyboard?.instantiateViewController(
      identifier: MemoryViewController.storyboardIdentifier) as? MemoryViewController
    else {
      return
    }

    vc.item = dataSource.item(at: indexPath.row)
    navigationController?.pushViewController(vc, animated: true)
  }
}

