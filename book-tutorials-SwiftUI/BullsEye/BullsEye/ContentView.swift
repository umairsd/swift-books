import SwiftUI

struct ContentView: View {

  let target = Int.random(in: 0...100)

  @State var currentValue: Double
  @State var showAlert = false

  var body: some View {
    VStack {
      Text("Put the Bull's Eye as close as you can to: \(target))")
      HStack {
        Text("0")
        Slider(value: $currentValue, in: 0.0...100.0, step: 1.0)
        Text("100")
      }.padding()

      Button(action: {
        self.showAlert = true
      }) {
        Text("Hit Me!")
      }
      .alert(isPresented: $showAlert) { () -> Alert in
        Alert(title: Text("Your score"), message: Text("\(computeScore())"))
      }
      .padding(.vertical)
    }
  }

  func computeScore() -> Int {
    return Int(currentValue)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(currentValue: 0.75)
      .previewLayout(.fixed(width: 580, height: 320))
  }
}
