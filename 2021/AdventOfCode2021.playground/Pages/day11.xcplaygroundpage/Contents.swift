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
  var energyMap = [[Int]]()
  inputArr.forEach { row in
    energyMap.append(row.map { Int(String($0))! })
  }

  var totalFlashes = 0
  for _ in 1...100 {
    var willFlash = [(Int, Int)]()
    // incremement every cell
    for row in 0..<energyMap.count {
      for col in 0..<energyMap[row].count {
        energyMap[row][col] += 1
        if energyMap[row][col] > 9 {
          willFlash.append((row, col))
        }
      }
    }
    
    var hasFlashed = [(Int, Int)]()
    while !willFlash.isEmpty {
      let currentFlash = willFlash.removeFirst()
      hasFlashed.append(currentFlash)
      energyMap = incrementNeighbors(map: energyMap, row: currentFlash.0, col: currentFlash.1)
      for row in 0..<energyMap.count {
        for col in 0..<energyMap[row].count {
          if energyMap[row][col] <= 9 {
            continue
          }
          if !hasFlashed.contains(where: { hf in hf.0 == row && hf.1 == col}) && !willFlash.contains(where: { hf in hf.0 == row && hf.1 == col}) {
            willFlash.append((row, col))
          }
        }
      }
    }
    //print(hasFlashed)
    totalFlashes += hasFlashed.count
    hasFlashed.forEach {
      energyMap[$0.0][$0.1] = 0
    }
  }

  for row in energyMap {
    print(row)
  }
  print(totalFlashes)
}

func incrementNeighbors(map: [[Int]], row: Int, col: Int) -> [[Int]] {
  var newMap = map
  // upper left
  if row == 0 && col == 0 {
    newMap[row + 1][col] += 1
    newMap[row + 1][col + 1] += 1
    newMap[row][col + 1] += 1
    return newMap
  }
  // upper right
  if row == 0 && col == map[0].count - 1 {
    newMap[row + 1][col] += 1
    newMap[row + 1][col - 1] += 1
    newMap[row][col - 1] += 1
    return newMap
  }
  // bottom left
  if row == map.count - 1 && col == 0 {
    newMap[row - 1][col] += 1
    newMap[row - 1][col + 1] += 1
    newMap[row][col + 1] += 1
    return newMap
  }
  // bottom right
  if row == map.count - 1 && col == map[0].count - 1 {
    newMap[row - 1][col] += 1
    newMap[row - 1][col - 1] += 1
    newMap[row][col - 1] += 1
    return newMap
  }
  // top row
  if row == 0 {
    newMap[row][col - 1] += 1
    newMap[row + 1][col - 1] += 1
    newMap[row + 1][col] += 1
    newMap[row + 1][col + 1] += 1
    newMap[row][col + 1] += 1
    return newMap
  }
  // bottom row
  if row == map.count - 1 {
    newMap[row - 1][col] += 1
    newMap[row - 1][col - 1] += 1
    newMap[row][col - 1] += 1
    newMap[row][col + 1] += 1
    newMap[row - 1][col + 1] += 1
    return newMap
  }
  // left edge
  if col == 0 {
    newMap[row - 1][col] += 1
    newMap[row + 1][col] += 1
    newMap[row + 1][col + 1] += 1
    newMap[row][col + 1] += 1
    newMap[row - 1][col + 1] += 1
    return newMap
  }
  // right edge
  if col == map[0].count - 1 {
    newMap[row - 1][col] += 1
    newMap[row - 1][col - 1] += 1
    newMap[row][col - 1] += 1
    newMap[row + 1][col - 1] += 1
    newMap[row + 1][col] += 1
    return newMap
  }
  
  newMap[row - 1][col] += 1
  newMap[row - 1][col - 1] += 1
  newMap[row][col - 1] += 1
  newMap[row + 1][col - 1] += 1
  newMap[row + 1][col] += 1
  newMap[row + 1][col + 1] += 1
  newMap[row][col + 1] += 1
  newMap[row - 1][col + 1] += 1
  return newMap
}

if let input = readInput() {
  processInput1(input)
}
