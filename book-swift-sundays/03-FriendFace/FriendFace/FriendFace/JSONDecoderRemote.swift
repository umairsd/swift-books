import Foundation

extension JSONDecoder {

  func decode<T: Decodable>(
    _ type: T.Type,
    fromURL url: String,
    completion: @escaping (T) -> Void
  ) {
    guard let url = URL(string: url) else {
      fatalError("Invalid URL passed.")
    }

    DispatchQueue.global().async {
      do {
        let data = try Data(contentsOf: url)
        let decodedData = try self.decode(type, from: data)

        DispatchQueue.main.async {
          completion(decodedData)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }

}
