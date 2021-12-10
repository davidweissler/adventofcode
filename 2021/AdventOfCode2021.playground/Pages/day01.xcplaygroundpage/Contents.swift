
import Foundation

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(_ input: String) {
  let inputArr = input.components(separatedBy: "\n").map { Int($0)! }
  var current = inputArr.first!
  var increaseCount = 0
  for i in 1..<inputArr.count {
    let new = inputArr[i]
    if new > current {
      increaseCount += 1
    }
    current = new
  }
  print(increaseCount)
}

func processInput2(_ input: String) {
  let inputArr = input.components(separatedBy: "\n").map { Int($0)! }
  var currentWindow = inputArr[0] + inputArr[1] + inputArr[2]
  var increaseCount = 0
  for i in 3..<inputArr.count {
    let newWindow = inputArr[i] + inputArr[i - 1] + inputArr[i - 2]
    if newWindow > currentWindow {
      increaseCount += 1
    }
    currentWindow = newWindow
  }
  print(increaseCount)
}

if let input = readInput() {
  processInput2(input)
}

