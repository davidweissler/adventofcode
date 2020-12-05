//: [Previous](@previous)

import Foundation

// Parsing funcs

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(_ input: String) {
  var count = 0
  for inputLine in input.components(separatedBy: "\n\n") {
    let line = inputLine.replacingOccurrences(of: "\n", with: " ")
    let lineArr = line.components(separatedBy: " ")
    if lineArr.count == 8 {
      count += 1
      continue
    }
    if lineArr.count == 7 && !line.contains("cid") {
      count += 1
      continue
    }
  }
  print(count)
}

if let input = readInput() {
    processInput1(input)
}
