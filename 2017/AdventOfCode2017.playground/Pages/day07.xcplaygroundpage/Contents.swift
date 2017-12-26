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

func processInput1(input: String) {
    var left = Set<String>()
    var right = Set<String>()
    input.split(separator: "\n").forEach { s in
        let s1 = s.replacingOccurrences(of: ",", with: "")
        var lineSep = s1.split(separator: " ")
        left.insert(String(lineSep[0]))
        if lineSep.count > 3 {
            lineSep.removeFirst(3)
            lineSep.forEach({ rest in
                right.insert(String(rest))
            })
        }
    }
    print(left.subtracting(right))
}

if let input = readInput() {
    processInput1(input: input)
}

