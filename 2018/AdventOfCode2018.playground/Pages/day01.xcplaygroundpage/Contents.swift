//: Playground - noun: a place where people can play

import UIKit


// Parsing funcs

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(input: inout String) {
    let inputArr = input.components(separatedBy: "\n")
        .map {  return Int($0) ?? 0 }
    .reduce(0, +)
    print(inputArr)
}


if var input = readInput() {
    processInput1(input: &input)
}

