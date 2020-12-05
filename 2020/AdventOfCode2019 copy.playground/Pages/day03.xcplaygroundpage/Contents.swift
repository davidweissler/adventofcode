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
  let input = input.components(separatedBy: "\n")
  
  var treeCount = 0
  var xPos = 0
  for line in input {
    if xPos >= line.count {
      xPos -= line.count
    }
    let lineArr = line.map { $0 }
    if lineArr[xPos] == "#" { treeCount += 1 }
    xPos += 3
  }
  print(treeCount)
}

if let input = readInput() {
    processInput1(input)
}
