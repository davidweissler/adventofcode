//: Playground - noun: a place where people can play

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
        .map {  return Int($0) ?? 0 }
        .reduce(0, +)
    print(inputArr)
}

func processInput2(_ input: String) {
    let inputArr = input.components(separatedBy: "\n").map { return Int($0) ?? 0 }
    var seenFreq = [0: 1]
    var currFreq = 0
    var foundTwice = false
    while (!foundTwice) {
        for num in inputArr {
            currFreq += num
            if seenFreq[currFreq] == 1 {
                foundTwice = true
                break
            }
            seenFreq[currFreq, default:0] += 1
        }
    }
    print(currFreq)
}

if let input = readInput() {
    processInput2(input)
}

