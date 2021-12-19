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
  let fishArr = inputArr.map { Int($0) }
  
  var fishCache = [Int: Int]()
  
  for i in fishArr {
    fishCache[i, default: 0] += 1
  }
  print(fishCache)
  
  for _ in 1...80 {
    for i in 0...8 {
      if fishCache.keys.contains(i) {
        fishCache[i - 1]  = fishCache[i]
        fishCache.removeValue(forKey: i)
      }
    }
    // Move -1 -> 6
    let birthCount: Int = fishCache.removeValue(forKey: -1) ?? 0
    if birthCount > 0 {
      fishCache[8] = birthCount
      fishCache[6, default: 0] += birthCount
    }
  }
  var total = 0
  for (_,v) in fishCache.enumerated() {
    total += v.value
  }
  print(fishCache)
  print(total)
}

if let input = readInput() {
  processInput1(input)
}
