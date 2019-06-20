import UIKit

var str = "Hello, playground"

let array: [Int] = [1, 2, 2, 2, 3, 4, 4]

var result: [[Int]] = array.isEmpty ? [] : [[array[0]]]

for (previous, current) in zip(array, array.dropFirst()) {
  if previous == current {
    result[result.endIndex - 1].append(current)
  } else {
    result.append([current])
  }
}

print(result)

extension Array {

  func split(where condition:(Element, Element) -> Bool) -> [[Element]] {
    var result: [[Element]] = isEmpty ? [] : [[self[0]]]

    for (previous, current) in zip(self, self.dropFirst()) {
      if condition(previous, current) {
        result.append([current])
      } else {
        result[result.endIndex - 1].append(current)
      }
    }

    return result
  }
}

let parts = array.split { $0 != $01}

print(parts)
