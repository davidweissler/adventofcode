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

func processInput1(input: inout String) {
    var totalSum = 0
    input.split(separator: "\n").forEach { line in
        let lineNums = line.split(separator: " ")
        var lineMin = Int.max
        var lineMax = Int.min
        lineNums.forEach({ (numStr) in
            if let val = Int(numStr) {
                if val < lineMin { lineMin = val }
                if val > lineMax { lineMax = val }
            }
        })
        totalSum += (lineMax - lineMin)
    }
    print("total sum: \(totalSum)")
}

func processInput2(input: inout String) {
    var totalSum = 0
    input.split(separator: "\n").forEach { line in
        var lineNums = line.split(separator: " ").map({ (s) -> Int in
            return Int(s)!
        })
        lineNums = lineNums.sorted()
        var lineVal = 0
        var leftIdx = 0
        var rightIdx = lineNums.count - 1
        while leftIdx < rightIdx {
            let leftVal = lineNums[leftIdx]
            let rightVal = lineNums[rightIdx]
            if rightVal % leftVal == 0 {
                lineVal = rightVal/leftVal
                break
            }
            if leftVal > rightVal/2 {
                rightIdx -= 1
                leftIdx = 0
            } else {
                leftIdx += 1
            }
        }
        totalSum += lineVal
    }
    print("total sum: \(totalSum)")
}

if var input = readInput() {
    processInput2(input: &input)
}
