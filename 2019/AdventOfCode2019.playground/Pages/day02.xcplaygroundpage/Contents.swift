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

func processInput1(_ input: String) {
    var intArr = input.components(separatedBy: ",")
        .map { Int($0) ?? 0 }

    intArr[1] = 12
    intArr[2] = 2
    for i in stride(from: 0, to: intArr.count, by: 4) {
        let currentVal = intArr[i]
        if currentVal == 99 {
            print(intArr[0])
            return
        }

        let pos1 = intArr[i + 1]
        let pos2 = intArr[i + 2]
        let pos3 = intArr[i + 3]
        let val1 = intArr[pos1]
        let val2 = intArr[pos2]

        if currentVal == 1 {
            intArr[pos3] = val1 + val2
            continue
        }
        
        if currentVal == 2 {
            intArr[pos3] = val1 * val2
            continue
        }
    }
}

if let input = readInput() {
    processInput1(input)
}

