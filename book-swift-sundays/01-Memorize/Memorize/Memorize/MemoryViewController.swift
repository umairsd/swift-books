import UIKit

class MemoryViewController: UIViewController {

  // MARK: Public Properties
  static let storyboardIdentifier = "MemoryViewController"
  var item: MemoryItem!

  @IBOutlet weak var textView: UITextView!

  // MARK: Private
  private var blankCounter = 0
  private let visibleText: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "Georgia", size:28)!,
    .foregroundColor: UIColor.black
  ]

  private let invisibleText: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "Georgia", size: 28)!,
    .foregroundColor: UIColor.clear,
    .strikethroughStyle: 1,
    .strikethroughColor: UIColor.black
  ]

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
    textView.addGestureRecognizer(tapRecognizer)

    assert(item != nil, "You must provide an item before trying to show this view controller")
    textView.attributedText = attributedText(for: item)
  }

  // MARK: - UI

  private func attributedText(for memoryItem: MemoryItem) -> NSAttributedString {
    let words = item.text.components(separatedBy: " ")
    let output = NSMutableAttributedString()

    // Reusable space
    let space = NSAttributedString(string: " ", attributes: visibleText)

    for (index, word) in words.enumerated() {
      if index < blankCounter {
        let attributedWord = NSAttributedString(string: word, attributes: visibleText)
        output.append(attributedWord)
      } else {
        var strippedWord = word
        var punctuation: String?

        if ".,".contains(word.last!) {
          punctuation = String(strippedWord.removeLast())
        }

        let attributedWord = NSAttributedString(string: strippedWord, attributes: invisibleText)
        output.append(attributedWord)

        if let symbol = punctuation {
          let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleText)
          output.append(attributedPunctuation)
        }
      }
      output.append(space)
    }

    return output
  }

  // MARK: - Action

  @objc func wordsTapped() {
    blankCounter += 1
    textView.attributedText = attributedText(for: item)
  }

}
