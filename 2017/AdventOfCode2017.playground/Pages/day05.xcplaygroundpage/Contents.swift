//: [Previous](@previous)

import Foundation

// Parsing funcs

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(input: String) -> Int {
    var movesCount = 0
    var inputArray : [Int] = []
    input.split(separator: "\n").forEach { s in
        inputArray.append(Int(s)!)
    }

    var pos = 0
    while pos < inputArray.count && pos >= 0 {
        let currVal = inputArray[pos]
        inputArray[pos] += 1
        pos += currVal
        movesCount += 1
    }
    return movesCount
}

func processInput2(input: String) -> Int {
    var movesCount = 0
    var inputArray : [Int] = []
    input.split(separator: "\n").forEach { s in
        inputArray.append(Int(s)!)
    }
    
    var pos = 0
    while pos < inputArray.count && pos >= 0 {
        let currVal = inputArray[pos]
        if currVal >= 3 {
            inputArray[pos] -= 1
        } else {
            inputArray[pos] += 1
        }
        pos += currVal
        movesCount += 1
    }
    return movesCount
}

if let input = readInput() {
    print(processInput2(input: input))
}

