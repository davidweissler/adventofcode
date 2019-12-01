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
    let inputArr = input.components(separatedBy: "\n")
        .map { ((Int($0) ?? 0) / 3) - 2 }
        .reduce(0,+)
    print(inputArr)
}

func processInput2(_ input: String) {
    let inputArr = input.components(separatedBy: "\n")
        .map {
            var initialFuel = ((Int($0) ?? 0) / 3) - 2
            var additionalFuel = initialFuel
            while additionalFuel > 0 {
                additionalFuel = (additionalFuel / 3) - 2
                if additionalFuel > 0 {
                    initialFuel += additionalFuel
                }
            }
            return initialFuel
    }
        .reduce(0,+)
    print(inputArr)
}

if let input = readInput() {
    processInput2(input)
}

