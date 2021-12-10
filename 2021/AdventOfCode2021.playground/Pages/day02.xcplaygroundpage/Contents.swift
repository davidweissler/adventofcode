
import Foundation

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(_ input: String) {
  let inputArr = input.components(separatedBy: "\n").map { String($0) }
  let depth = inputArr.filter { $0.contains("up") || $0.contains("down") }
  let horizontal = inputArr.filter { $0.contains("forward") }
  
  let depthNums: [Int] = depth.map { string -> Int in
    let parse = string.components(separatedBy: " ")
    let num = Int(parse[1])!
    if parse[0] == "up" {
      return num * -1
    }
    return num
  }
  let depthSum = depthNums.reduce(0, +)
  
  let horizontalNums: [Int] = horizontal.map { string -> Int in
    let parse: [String] = string.components(separatedBy: " ")
    return Int(parse[1])!
  }
  let horizontalSum = horizontalNums.reduce(0, +)

  print(depthSum * horizontalSum)
}

func processInput2(_ input: String) {
  let inputArr = input.components(separatedBy: "\n").map { String($0) }

  var horizon = 0
  var depth = 0
  var aim = 0
  
  inputArr.forEach { string in
    let parse = string.components(separatedBy: " ")
    let command = parse[0]
    let num = Int(parse[1])!
    
    if command == "up" {
      aim = aim - num
    } else if command == "down" {
      aim = aim + num
    } else if command == "forward" {
      horizon += num
      depth = depth + (num * aim)
    }
  }
  print("h: \(horizon)")
  print("d: \(depth)")
  print(horizon * depth)
}

if let input = readInput() {
  processInput2(input)
}

