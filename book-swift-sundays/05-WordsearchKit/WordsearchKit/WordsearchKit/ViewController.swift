import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let words = Bundle.main.decode([Word].self, from: "capitals.json")
    let wordSearch = WordSearch()
    wordSearch.words = words
    wordSearch.makeGrid()
  }


}

