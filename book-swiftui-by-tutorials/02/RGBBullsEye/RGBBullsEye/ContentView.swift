import SwiftUI

struct ContentView: View {

  let rTarget = Double.random(in: 0..<1)
  let gTarget = Double.random(in: 0..<1)
  let bTarget = Double.random(in: 0..<1)

  @State var rGuess: Double
  @State var gGuess: Double
  @State var bGuess: Double

  @State var showAlert = false


  var body: some View {
    VStack {
      HStack {
        VStack {
          Color(red: rTarget, green: gTarget, blue: bTarget)
          Text("Match this color")
            .padding()
        }
        VStack {
          Color(red: rGuess, green: gGuess, blue: bGuess)
          Text("R: \(intColor(rGuess)) G: \(intColor(gGuess)) B: \(intColor(bGuess))")
            .padding()
        }
      }

      Button(action: {
        self.showAlert = true
      }) {
        Text("Hit Me!")
      }
      .alert(isPresented: $showAlert, content: {
        Alert(title: Text("Your Score"), message: Text(String(computeScore())))
      })
      .padding()

      ColorSlider(value: $rGuess, textColor: .red)
      ColorSlider(value: $gGuess, textColor: .green)
      ColorSlider(value: $bGuess, textColor: .blue)
    }
  }

  // MARK: Actions

  func computeScore() -> Int {
    let rDiff = rGuess - rTarget
    let gDiff = gGuess - gTarget
    let bDiff = bGuess - bTarget

    let diff = sqrt((rDiff * rDiff + gDiff * gDiff + bDiff * bDiff) / 3.0)
    return lround((1.0 - diff) * 100.0)
  }

  // MARK: Private

  private func intColor(_ value: Double) -> Int {
    return Int(value * 255)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(rGuess: 0.8, gGuess: 0.5, bGuess: 0.5)
      .previewLayout(.fixed(width: 568, height: 320))
  }
}

struct ColorSlider: View {

  @Binding var value: Double
  var textColor: Color

  var body: some View {
    HStack {
      Text("0")
        .foregroundColor(textColor)
      Slider(value: $value)
      Text("255")
        .foregroundColor(textColor)
    }
  }
}
