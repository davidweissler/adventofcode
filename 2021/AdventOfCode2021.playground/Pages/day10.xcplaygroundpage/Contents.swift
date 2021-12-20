import Foundation

func readInput() -> String? {
  let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
  let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
  guard var input = content else { return nil }
  input.removeLast()
  return input
}

func match(_ input: String) -> String {
  let open = ["(", "[", "{", "<"]
  let close = [")", "]", "}", ">"]
  
  if let foundIdx = open.firstIndex(of: input) {
    return close[foundIdx]
  }
  
  if let foundIdx = close.firstIndex(of: input) {
    return open[foundIdx]
  }
  return ""
}

func processInput1(_ input: String) {
  let inputArr = input.split(separator: "\n")
  let subsystems = inputArr.map { $0.map { String($0) }  }
  let open: Set<String> = ["(", "[", "{", "<"]
  let close: Set<String> = [")", "]", "}", ">"]
  
  var wrongClosers = [String: Int]()
  subsystems.forEach { subsystem in
    var i = 0
    var shouldContinue = true
    var stack = [String]()
    while i < subsystem.count && shouldContinue {
      let curr = subsystem[i]
      if open.contains(curr) {
        stack.insert(curr, at: 0)
      } else {
        if stack.count == 0 {
          shouldContinue = false
          continue
        }
        let top = stack.remove(at: 0)
        if match(curr) != top {
          wrongClosers[curr, default: 0] += 1
          shouldContinue = false
          continue
        }
      }
      i += 1
    }
  }
  print(wrongClosers)
  var score = 0
  for (_, v) in wrongClosers.enumerated() {
    print(v)
    if v.key == ")" {
      score = score + (3 * v.value)
    } else if v.key == "]" {
      score = score + (57 * v.value)
    } else if v.key == "}" {
      score = score + (1197 * v.value)
    } else if v.key == ">" {
      score = score + (25137 * v.value)
    }
  }
  print(score)
}

if let input = readInput() {
  processInput1(input)
}
