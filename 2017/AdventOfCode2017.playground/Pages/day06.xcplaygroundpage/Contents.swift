//: [Previous](@previous)

import Foundation

extension Array {
    func string() -> String {
        var output : String = ""
        self.forEach { e in
            output.append(" \(e) ")
        }
        return output
    }
}

// Parsing funcs

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func indexToUse(input : [Int]) -> Int {
    var values = (index: 0, element: 0)
    for (idx, element) in input.enumerated() {
        if element > values.element {
            values = (idx, element)
        }
    }
    return values.index
}

func processInput1(input: String) -> Int {
    var movesCount = 0
    var inputArray : [Int] = []
    input.split(separator: " ").forEach{ s in
        inputArray.append(Int(s)!)
    }
    var cache = Set<String>()
    
    var foundLoop = false
    while !foundLoop {
        let arrayString = inputArray.string()
        if cache.contains(arrayString) {
            foundLoop = true
        } else {
            cache.insert(inputArray.string())
            var index = indexToUse(input: inputArray)
            var value = inputArray[index]
            inputArray[index] = 0
            while value > 0 {
                index += 1
                if index >= inputArray.count { index = 0 }
                inputArray[index] += 1
                value -= 1
            }
            movesCount += 1
        }
    }
    
    return movesCount
}

if let input = readInput() {
    print(processInput1(input: input))
}

