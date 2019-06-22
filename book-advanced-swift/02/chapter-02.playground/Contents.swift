import UIKit

// Parametrizing Functions
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


// Accumulate
extension Array {

  func accumulate<Result>(
    _ initialResult: Result,
    _ nextPartialResult: (Result, Element) -> Result
  ) -> [Result] {
    var running = initialResult
    return map { next in
      running = nextPartialResult(running, next)
      return running
    }
  }
}
[1, 2, 3, 4].accumulate(0, +) // [1, 3, 6, 10]


// Reduce
let fibs = [0, 1, 1, 2, 3, 5]
let sum = fibs.reduce(0) { total, num in total + num }
// OR: let sum = fibs.reduce(0, +)
print(sum)


// Use Reduce to implement map

extension Array {
  func map2<T>(_ transform: (Element) -> T) -> [T] {
    return reduce([]) {
      $0 + [transform($1)]
    }
  }
}

// Use Reduce to implement filter (O(N))

extension Array {
  func filter3(_ isIncluded: (Element) -> Bool) -> [Element] {
    return reduce(into: []) { (result, element) in
      if isIncluded(element) {
        result.append(element)
      }
    }
  }
}


// Flattening Map

extension Array {

  func flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
    var result: [T] = []
    for x in self {
      result.append(contentsOf: transform(x))
    }
    return result
  }
}

let suits = ["♠︎", "♥︎", "♣︎", "♦︎"]
let ranks = ["J", "Q", "K", "A"]
let r1 = suits.flatMap { suit in
  ranks.map { rank in
    (suit, rank)
  }
}

print(r1)


// For each
