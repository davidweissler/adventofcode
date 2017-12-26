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
    var validPassphrases = 0
    input.split(separator: "\n").forEach { passphrase in
        var cache = Set<Substring>()
        var isValid = true
        passphrase.split(separator: " ").forEach({ word in
            if !cache.contains(word) {
                cache.insert(word)
            } else {
                isValid = false
                return
            }
        })
        if isValid { validPassphrases += 1 }
    }
    return validPassphrases
}


let input = readInput()
if let input = input {
    print(processInput1(input: input))
}

