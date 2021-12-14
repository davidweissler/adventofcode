
import Foundation

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(_ input: String) {
  let inputArr: [[Int]] = input.components(separatedBy: "\n").map { str in
    var output = [Int]()
    for i in str {
      output.append(Int(String(i))!)
    }
    return output
  }
  var gamma = [Int]()
  var epsilon = [Int]()
  for i in 0..<inputArr.first!.count {
    let bitArr = inputArr.map { $0[i] }
    let count = bitArr.reduce(0, +)
    if count > (bitArr.count / 2) {
      gamma.append(1)
      epsilon.append(0)
    } else {
      gamma.append(0)
      epsilon.append(1)
    }
  }
  let gammaString = gamma.reduce("") { partialResult, val in partialResult.appending("\(val)") }
  let epsilonString = epsilon.reduce("") { partialResult, val in partialResult.appending("\(val)") }
  
  let gammaInt = Int(gammaString, radix: 2)!
  let epsilonInt = Int(epsilonString, radix: 2)!
  print("\(gammaInt) x \(epsilonInt) = \(gammaInt * epsilonInt)")  
}

if let input = readInput() {
  processInput1(input)
}


