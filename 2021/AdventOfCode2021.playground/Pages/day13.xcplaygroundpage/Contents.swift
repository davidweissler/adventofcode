import Foundation

struct Coordinate: Hashable {
  let row: Int
  let col: Int
}

func readInput() -> String? {
  let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
  let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
  guard var input = content else { return nil }
  input.removeLast()
  return input
}

func processInput1(_ input: String) {
  let inputArr = input.split(separator: "\n")
  print(inputArr)
  var instructions = [String]()
  var coordinates = [Coordinate]()
  inputArr.forEach { line in
    if line.contains("fold") {
      instructions.append(String(line))
    } else {
      let coordStr = line.components(separatedBy: ",").map { Int($0)! }
      coordinates.append(Coordinate(row: coordStr[1], col: coordStr[0]))
    }
  }
  
  print(coordinates)
  print(instructions)
  var coordinatesSet = Set(coordinates)
  // Get first instruction
//  let endCount = instructions.count
  let endCount = 1
  for i in 0..<endCount {
    var instruction = instructions[i]
    let instructionArr = instruction.components(separatedBy: " ")
    guard let whereToFold = instructionArr.last else {
      fatalError("expeted row")
    }
    
    let whereToFoldSplit = whereToFold.components(separatedBy: "=")
    let toRemove: Set<Coordinate>
    let splitVal = Int(whereToFoldSplit[1])!
    if whereToFoldSplit[0] == "y" {
      // Find all coordinates where row > splitVal
      toRemove = coordinatesSet.filter { $0.row > splitVal }
    } else {
      // Final all coordinates where col > splitVal
      toRemove = coordinatesSet.filter { $0.col > splitVal }
      
    }
    // Remove each coord beyond the split from the coordinate set
    toRemove.forEach { coordinatesSet.remove($0) }
    
    // Map the new coordinates
    let newCoords = toRemove.map { coord -> Coordinate in
      if whereToFoldSplit[0] == "y" {
        var newRow = coord.row - splitVal
        newRow = splitVal - newRow
        return Coordinate(row: newRow , col: coord.col)
      } else {
        var newCol = coord.col - splitVal
        newCol = splitVal - newCol
        return Coordinate(row: coord.row , col: newCol)
      }
    }
    newCoords.forEach { coordinatesSet.insert($0) }
  }
  print(coordinatesSet.count)
}


if let input = readInput() {
  processInput1(input)
}
