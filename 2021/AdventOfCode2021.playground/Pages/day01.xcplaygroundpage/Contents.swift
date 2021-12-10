
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

if let input = readInput() {
  processInput1(input)
}

