import Foundation

func readInput() -> String? {
  let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
  let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
  guard var input = content else { return nil }
  input.removeLast()
  return input
}

func processInput1(_ input: String) {
  let inputArr = input.split(separator: "\n")
  var initialStrArr = inputArr[0].map { String($0) }
  
  var mapping = [String: String]()
  
  for i in 1..<inputArr.count {
    let instArr = inputArr[i].components(separatedBy: " -> ")
    mapping[instArr[0]] = instArr[1]
  }
  
  for _ in 0..<10 {
    var idx1 = 0
    var idx2 = 1
    while idx2 < initialStrArr.count {
      let key = "\(initialStrArr[idx1])\(initialStrArr[idx2])"
      let toInsert = mapping[key] ?? ""
      initialStrArr.insert(toInsert, at: idx2)
      idx2 += 2
      idx1 = idx2 - 1
    }
    print(initialStrArr)
  }
  var amtDict = [String: Int]()
  initialStrArr.forEach {
    amtDict[$0, default: 0] += 1
  }

  var counts = [Int]()
  for (_, v) in amtDict.enumerated() {
    counts.append(v.value)
  }
  counts.sort()
  print(counts.last! - counts.first!)
}
  
if let input = readInput() {
  processInput1(input)
}
