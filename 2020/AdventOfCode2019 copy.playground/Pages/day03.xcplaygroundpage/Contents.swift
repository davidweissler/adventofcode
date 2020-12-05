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

func processInput2(_ input: String) {
  let input = input.components(separatedBy: "\n")
  
  var treeCount = [0, 0, 0, 0, 0]
  var xPos = [0, 0, 0, 0, 0]
  var lineIndex = 0
  for line in input {
    for i in 0..<xPos.count {
      if xPos[i] >= line.count {
        xPos[i] -= line.count
      }
    }
    let lineArr = line.map { $0 }
    for i in 0..<treeCount.count {
      if i == 4 && lineIndex % 2 == 1 {
        continue
      }
      if lineArr[xPos[i]] == "#" {
        treeCount[i] += 1
      }
    }
    
    xPos[0] += 1
    xPos[1] += 3
    xPos[2] += 5
    xPos[3] += 7
    if lineIndex % 2 == 0 {
      xPos[4] += 1
    }
    lineIndex += 1
  }  
  print(treeCount.reduce(1, *))
}

if let input = readInput() {
    processInput2(input)
}
