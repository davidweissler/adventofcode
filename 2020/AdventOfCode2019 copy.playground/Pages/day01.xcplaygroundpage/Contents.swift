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
  let inputArr = input.components(separatedBy: "\n").map { Int($0)! }
  var cache = Set<Int>()
  for i in inputArr {
    let needed = 2020 - i
    if cache.contains(needed) {
      print(needed * i)
      break
    } else {
      cache.insert(i)
    }
  }
}

struct Combo: Hashable {
  let a: Int
  let b: Int
  var sum: Int {
    get { return a + b }
  }
  var product: Int {
    get { return a * b }
  }
  static func == (lhs: Combo, rhs: Combo) -> Bool {
      return (lhs.a == rhs.a && lhs.b == rhs.b) || (lhs.a == rhs.b && lhs.b == rhs.a)
  }
}

func processInput2(_ input: String) {
  let inputArr = input.components(separatedBy: "\n").map { Int($0)! }
  var cache = Set<Combo>()
  var seen = Set<Int>()
  
  for i in inputArr {
    if !seen.contains(i) {
      for combo in cache {
        if combo.sum + i == 2020 {
          print(combo.product * i)
          return
        }
      }

      seen.forEach { cache.insert(Combo(a: i, b: $0)) }
      seen.insert(i)
    }
  }
}

if let input = readInput() {
    processInput2(input)
}

