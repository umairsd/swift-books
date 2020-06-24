import SwiftUI

struct ContentView: View {

  let redTarget = Double.random(in: 0..<1)
  let greenTarget = Double.random(in: 0..<1)
  let blueTarget = Double.random(in: 0..<1)

  @State var redGuess: Double
  @State var greenGuess: Double
  @State var blueGuess: Double

  var body: some View {
    VStack {
      HStack {
        VStack {
          Color(red: redTarget, green: greenTarget, blue: blueTarget)
          Text("Match this color")
        }
        VStack {
          Color(red: redGuess, green: greenGuess, blue: blueGuess)
          Text("R: \(Int(redGuess * 255)) G: \(Int(greenGuess * 255)) B: \(Int(blueGuess * 255))")
        }
      }

      Button(action: {}) {
        Text("Hit me!")
      }

      ColorSlider(value: $redGuess, textColor: .red)
      ColorSlider(value: $greenGuess, textColor: .green)
      ColorSlider(value: $blueGuess, textColor: .blue)

    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(redGuess: 0.7, greenGuess: 0.5, blueGuess: 0.5)
      .previewLayout(.fixed(width: 580, height: 320))
  }
}

struct ColorSlider: View {
  // Color slider does not own this data, thus use @Binding
  @Binding var value: Double
  var textColor: Color

  var body: some View {
    HStack {
      Text("0")
        .foregroundColor(textColor)
      Slider(value: $value)
      Text("255")
        .foregroundColor(textColor)
    }.padding(.horizontal)
  }
}
