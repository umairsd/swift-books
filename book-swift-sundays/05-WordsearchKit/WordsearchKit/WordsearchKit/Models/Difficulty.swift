import Foundation

enum Difficulty {
  case easy
  case medium
  case hard

  var placementTypes: [PlacementType] {
    switch self {
      case .easy:
        return [.leftRight, .upDown].shuffled()

      case .medium:
        return [.leftRight, .rightLeft, .upDown, .downUp].shuffled()

      default:
        return PlacementType.allCases.shuffled()
    }
  }
}
