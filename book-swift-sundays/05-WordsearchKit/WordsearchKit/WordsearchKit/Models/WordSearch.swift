import Foundation

class WordSearch {

  var words = [Word]()
  var gridSize = 10

  var labels = [[Label]]()
  var difficulty = Difficulty.easy
  var numberOfPages = 10

  let allLetters = (65...90).map { Character(Unicode.Scalar($0)) }

  func makeGrid() {
    labels = (0 ..< gridSize).map { _ in
      (0 ..< gridSize).map { _ in Label() }
    }

    fillGaps()
    printGrid()
  }

  func fillGaps() {
    for row in labels {
      for label in row {
        if label.letter == " " {
          label.letter = allLetters.randomElement()!
        }
      }
    }
  }

  func printGrid() {
    for row in labels {
      for col in row {
        print(col.letter, terminator: "")
      }

      print("")
    }
  }

}
