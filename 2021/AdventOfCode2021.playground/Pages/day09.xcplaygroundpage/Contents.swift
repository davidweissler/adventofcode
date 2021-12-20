import Foundation

func readInput() -> String? {
  let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
  let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
  guard var input = content else { return nil }
  input.removeLast()
  return input
}

func processInput1(_ input: String) -> [(Int, Int)] {
  let inputArr = input.split(separator: "\n")
  var map = [[Int]]()
  inputArr.forEach { str in
    var row = [Int]()
    str.forEach {
      row.append(Int(String($0))!)
    }
    map.append(row)
  }
  
  var lowPoints = [Int]()
  var lowPointCoords = [(Int, Int)]()
  
  for row in 0..<map.count {
    for col in 0..<map[row].count {
      let currVal = map[row][col]
      
      if row == 0 && col == 0 {
        // upper left
        if map[row + 1][col] > currVal && map[row][col + 1] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      if row == 0 && col == map[row].count - 1 {
        // upper right
        if map[row + 1][col] > currVal && map[row][col - 1] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      if row == map.count - 1 && col == 0 {
        //lower left
        if map[row - 1][col] > currVal && map[row][col + 1] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      if row == map.count - 1 && col == map[row].count - 1 {
        // lower right
        if map[row - 1][col] > currVal && map[row][col - 1] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      if row == 0 {
        // top row
        if map[row][col - 1] > currVal && map[row][col + 1] > currVal && map[row + 1][col] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      if row == map.count - 1 {
        // bottom row
        if map[row][col - 1] > currVal && map[row][col + 1] > currVal && map[row - 1][col] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      if col == 0 {
        // left edge
        if map[row][col + 1] > currVal && map[row - 1][col] > currVal && map[row + 1][col] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      if col == map[row].count - 1 {
        // right edge
        if map[row][col - 1] > currVal && map[row - 1][col] > currVal && map[row + 1][col] > currVal {
          lowPoints.append(currVal)
          lowPointCoords.append((row, col))
        }
        continue
      }
      
      // middle
      if map[row - 1][col] > currVal && map[row + 1][col] > currVal && map[row][col - 1] > currVal && map[row][col + 1] > currVal {
        lowPoints.append(currVal)
        lowPointCoords.append((row, col))
      }
    }
  }
  let riskHeights = lowPoints.map { $0 + 1 }
  let riskSum = riskHeights.reduce(0, +)
  return lowPointCoords
}

func processInput2(_ input: String) {
  let inputArr = input.split(separator: "\n")
  var map = [[Int]]()
  inputArr.forEach { str in
    var row = [Int]()
    str.forEach {
      row.append(Int(String($0))!)
    }
    map.append(row)
  }

  var toCheck = [(Int, Int)]()
  let lowpointCoords: [(Int, Int)] = processInput1(input)
  for l in lowpointCoords {
    toCheck.append(l)
    toCheck.append((-1, -1))
  }
  var basins = [[Int]]()
  var currentBasin = [Int]()
  
  while !toCheck.isEmpty {
    let coord = toCheck.removeFirst()
    let row = coord.0
    let col = coord.1
    if row == -1 || col == -1 {
      basins.append(currentBasin)
      currentBasin.removeAll()
      continue
    }
    
    let currValue = map[row][col]
    if currValue == 9 {
      continue
    }
    currentBasin.append(currValue)
    // mark the current location as visited
    map[row][col] = 9
    
    if row == 0 && col == 0 {
      // upper left
      var r = row + 1
      var c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      r = row
      c = col + 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    if row == 0 && col == map[row].count - 1 {
      // upper right
      var r = row + 1
      var c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row
      c = col - 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    if row == map.count - 1 && col == 0 {
      //lower left
      var r = row - 1
      var c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row
      c = col + 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    if row == map.count - 1 && col == map[row].count - 1 {
      // lower right
      var r = row - 1
      var c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row
      c = col - 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    if row == 0 {
      // top row
      var r = row
      var c = col - 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row
      c = col + 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row + 1
      c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    if row == map.count - 1 {
      // bottom row
      var r = row
      var c = col - 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row
      c = col + 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row - 1
      c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    if col == 0 {
      // left edge
      var r = row - 1
      var c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      
      r = row + 1
      c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row
      c = col + 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    if col == map[row].count - 1 {
      // right edge
      var r = row - 1
      var c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row + 1
      c = col
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }

      r = row
      c = col - 1
      if map[r][c] != 9 {
        toCheck.insert((r, c), at: 0)
      }
      continue
    }
    
    // middle
    var r = row - 1
    var c = col
    if map[r][c] != 9 {
      toCheck.insert((r, c), at: 0)
    }

    r = row + 1
    c = col
    if map[r][c] != 9 {
      toCheck.insert((r, c), at: 0)
    }

    r = row
    c = col - 1
    if map[r][c] != 9 {
      toCheck.insert((r, c), at: 0)
    }


    r = row
    c = col + 1
    if map[r][c] != 9 {
      toCheck.insert((r, c), at: 0)
    }
  }
  var basinSizes = [Int]()
  basins.forEach {
    basinSizes.append($0.count)
  }
  basinSizes.sort()
  print(basinSizes)
  let topThree = basinSizes.dropFirst(basinSizes.count - 3).map { $0 }
  let product = topThree.reduce(1, *)
  print(topThree)
  print(product)
}

if let input = readInput() {
  processInput2(input)
}
