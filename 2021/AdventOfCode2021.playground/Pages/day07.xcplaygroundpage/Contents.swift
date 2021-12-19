import Foundation

func readInput() -> String? {
  let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
  let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
  guard var input = content else { return nil }
  input.removeLast()
  return input
}

func processInput1(_ input: String) {
  let inputArr = input.split(separator: ",").map { Int($0)! }
  let posArr = inputArr.map { Int($0) }
  let largest = posArr.max() ?? 0
  var totalGas = [Int]()
  
  for i in 0...largest {
    let changed = posArr.map { val in
      return abs(val - i)
    }
    let sum = changed.reduce(0, +)
    totalGas.append(sum)
  }
  print(totalGas)
  print(totalGas.min() ?? -1)
}

if let input = readInput() {
  processInput1(input)
}
