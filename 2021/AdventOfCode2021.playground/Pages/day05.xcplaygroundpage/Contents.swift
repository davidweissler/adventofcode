import Foundation

struct Coordinate {
  let x: Int
  let y: Int
}

func readInput() -> String? {
  let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
  let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
  guard var input = content else { return nil }
  input.removeLast()
  return input
}

func processInput1(_ input: String) {
  let inputArr = input.components(separatedBy: "\n").map { String($0) }
  var allCoords = [[Coordinate]]()
  inputArr.forEach { str in
    let strArr = str.components(separatedBy: "->").map { $0.trimmingCharacters(in: .whitespaces) }
    var coords = [[Int]]()
    strArr.forEach { str in
      let strArr = str.components(separatedBy: ",").map { Int($0)! }
      coords.append(strArr)
    }
    let mappedCoords = coords.map { Coordinate(x: $0[0], y: $0[1]) }
    allCoords.append(mappedCoords)
  }
  
  // find the largest number
  var largest = 0
  allCoords.forEach {
    $0.forEach { num in
      largest = max(largest, max(num.x, num.y))
    }
  }

  // make an NxN array
  var steamMap: [[Int]] = Array(repeating: Array(repeating: 0, count: (largest + 1)), count: (largest + 1))
  
  allCoords.forEach {
    let start = $0[0]
    let end = $0[1]
    
    let isHorizontal = start.x == end.x
    let isVertical = start.y == end.y
    
    guard isHorizontal || isVertical else {
      return
    }
    
    let startX = min(start.x, end.x)
    let endX = max(start.x, end.x)
    let startY = min(start.y, end.y)
    let endY = max(start.y, end.y)
    
    for row in startY...endY {
      for col in startX...endX {
        let currentVal = steamMap[row][col]
        steamMap[row][col] = currentVal + 1
      }
    }
  }
  
  var dangerCount = 0
  for row in steamMap {
    print(row)
    for val in row {
      if val >= 2 {
        dangerCount += 1
      }
    }
  }
  print(dangerCount)
}

if let input = readInput() {
  processInput1(input)
}
