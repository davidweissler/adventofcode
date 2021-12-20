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
  var map = [[Int]]()
  inputArr.forEach { str in
    var row = [Int]()
    str.forEach {
      row.append(Int(String($0))!)
    }
    map.append(row)
  }
  print(map)
  
  var lowPoints = [Int]()
  
  for row in 0..<map.count {
    for col in 0..<map[row].count {
      let currVal = map[row][col]
      
      if row == 0 && col == 0 {
        // upper left
        if map[row + 1][col] > currVal && map[row][col + 1] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      if row == 0 && col == map[row].count - 1 {
        // upper right
        if map[row + 1][col] > currVal && map[row][col - 1] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      if row == map.count - 1 && col == 0 {
        //lower left
        if map[row - 1][col] > currVal && map[row][col + 1] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      if row == map.count - 1 && col == map[row].count - 1 {
        // lower right
        if map[row - 1][col] > currVal && map[row][col - 1] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      if row == 0 {
        // top row
        if map[row][col - 1] > currVal && map[row][col + 1] > currVal && map[row + 1][col] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      if row == map.count - 1 {
        // bottom row
        if map[row][col - 1] > currVal && map[row][col + 1] > currVal && map[row - 1][col] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      if col == 0 {
        // left edge
        if map[row][col + 1] > currVal && map[row - 1][col] > currVal && map[row + 1][col] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      if col == map[row].count - 1 {
        // right edge
        if map[row][col - 1] > currVal && map[row - 1][col] > currVal && map[row + 1][col] > currVal {
          lowPoints.append(currVal)
        }
        continue
      }
      
      // middle
      if map[row - 1][col] > currVal && map[row + 1][col] > currVal && map[row][col - 1] > currVal && map[row][col + 1] > currVal {
        lowPoints.append(currVal)
      }
    }
  }
  let riskHeights = lowPoints.map { $0 + 1 }
  let riskSum = riskHeights.reduce(0, +)
  print(riskSum)
}


if let input = readInput() {
  processInput1(input)
}
