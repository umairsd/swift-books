import UIKit

class MemoryViewController: UIViewController {

  static let storyboardIdentifier = "MemoryViewController"

  @IBOutlet weak var textView: UITextView!
  var item: MemoryItem!
  var blankCounter = 0

  let visibleText: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "Georgia", size: 28)!,
    .foregroundColor: UIColor.black,
  ]
  let invisibleText: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "Georgia", size: 28)!,
    .foregroundColor: UIColor.clear,
    .strikethroughStyle: 1,
    .strikethroughColor: UIColor.black
  ]

  // MARK: UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    let gesture = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
    textView.addGestureRecognizer(gesture)
    textView.attributedText = showText(for: item)
  }

  private func showText(for memoryItem: MemoryItem) -> NSAttributedString {
    let words = memoryItem.text.components(separatedBy: " ")
    let output = NSMutableAttributedString()

    let space = NSAttributedString(string: " ", attributes: visibleText)

    for (index, word) in words.enumerated() {
      if index < blankCounter {
        let attributedWord = NSAttributedString(string: "\(word)", attributes: visibleText)
        output.append(attributedWord)

      } else {
        let attributedWord = NSAttributedString(string: "\(word)", attributes: invisibleText)
        output.append(attributedWord)
      }

      output.append(space)
    }
    return output
  }

  @objc func wordsTapped() {
    blankCounter += 1
    textView.attributedText = showText(for: item)
  }
}
