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
    let index = input.index(input.startIndex, offsetBy: 0)
    input.append(input[index])

    var sum = 0
    for i in 0..<input.count-1 {
        let currentIdx = input.index(input.startIndex, offsetBy: i)
        let nextIdx = input.index(input.startIndex, offsetBy: i + 1)
        let currChar = input[currentIdx]
        let nextChar = input[nextIdx]
        if currChar == nextChar {
            if let val = Int(String(currChar)) {
                sum += val
            }
        }
        
    }
    print(sum)
}

func processInput2(input: inout String) {
    var sum = 0
    for i in 0..<input.count {
        let currentIdx = input.index(input.startIndex, offsetBy: i)
        let nextOffset = (i + (input.count/2)) % input.count
        let nextIdx = input.index(input.startIndex, offsetBy: nextOffset)
        let currChar = input[currentIdx]
        let nextChar = input[nextIdx]
        if currChar == nextChar {
            if let val = Int(String(currChar)) {
                sum += val
            }
        }        
    }
    print(sum)
}

if var input = readInput() {
    processInput2(input: &input)
}

