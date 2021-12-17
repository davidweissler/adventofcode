
import Foundation

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(_ input: String) {
  var inputArr = input.components(separatedBy: "\n").map { String($0) }
  let drawNumbersString = inputArr.first!
  let drawNumbersArr = drawNumbersString.components(separatedBy: ",").map { Int($0)! }
  print(drawNumbersArr)
  inputArr.removeFirst(2)
  
  // Create an array of boards
  var boards = [[[Int]]]()
  var board = [[Int]]()
  for str in inputArr {
    if str == "" {
      boards.append(board)
      board = [[Int]]()
    } else {
      let cleanStr = str.replacingOccurrences(of: "  ", with: " ").trimmingCharacters(in: .whitespaces)
      let row = cleanStr.components(separatedBy: " ")
      let rowNums = row.compactMap { Int($0)! }
      board.append(rowNums)
    }
  }
  // Add the last board
  boards.append(board)

  // Creare an array of transposed boards
  var transBoards = [[[Int]]]()
  
  for board in boards {
    var newBoard = [[Int]]()
    for i in 0..<board[0].count {
      var newRow = [Int]()
      board.forEach { newRow.append($0[i]) }
      newBoard.append(newRow)
    }
    transBoards.append(board)
  }

  var shouldContinue = true
  var drawNumIdx = 0
  // Check if any board has won
  var winningBoard: [[Int]]?
  var winningNumber: Int?

  while shouldContinue && drawNumIdx < drawNumbersArr.count {
    let drawnNumber = drawNumbersArr[drawNumIdx]
    print("drawing number \(drawnNumber)")
    drawNumIdx += 1
    // mark the boards with the drawn number
    
    for board in 0..<boards.count {
      for row in 0..<boards[board].count {
        for val in 0..<boards[board][row].count {
          if boards[board][row][val] == drawnNumber {
            boards[board][row][val] = -1
          }
        }
      }
    }

    for board in 0..<transBoards.count {
      for row in 0..<transBoards[board].count {
        for val in 0..<transBoards[board][row].count {
          if boards[board][row][val] == drawnNumber {
            transBoards[board][row][val] = -1
          }
        }
      }
    }

    if drawnNumber == 21 {
      print(boards)
    }

    for board in boards {
      if winningBoard != nil {
        continue
      }
      for row in board {
        if winningBoard != nil {
          continue
        }
        let nonNeg = row.filter { $0 > 0 }
        if nonNeg.count == 0 {
          winningBoard = board
          shouldContinue = false
          winningNumber = drawnNumber
        }
      }
    }
    
    
    if winningBoard == nil {
      for board in transBoards {
        if winningBoard != nil {
          continue
        }
        for row in board {
          if winningBoard != nil {
            continue
          }
          let nonNeg = row.filter { $0 > 0 }
          if nonNeg.count == 0 {
            winningBoard = board
            shouldContinue = false
            winningNumber = drawnNumber
          }
        }
      }
    }
  }
  
  guard let winningBoard = winningBoard, let winningNumber = winningNumber else {
    print("something went wrong")
    return
  }

  // get all non-marked numbers
  var sum = 0
  for row in winningBoard {
    for val in row {
      if val > 0 {
        sum += val
      }
    }
  }
  
  print("winning sum \(sum) * number \(winningNumber): \(sum * winningNumber)")
}

if let input = readInput() {
  processInput1(input)
}


