//: [Previous](@previous)

import Foundation

class Stack {
    var array: [Character] = []
    
    func push(_ element: Character) {
        self.array.insert(element, at: 0)
    }
    
    func pop() -> Character {
        return self.array.removeFirst()
    }
    
    func peek() -> Character? {
        return self.array.first
    }
    
    func count() -> Int {
        return self.array.count
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

func processInput1(input: String) {
    let stack: Stack = Stack()
    var score = 0
    var isCanceled = false
    var isGarbage = false
    for i in input {
        if isCanceled {
            isCanceled = false
            continue
        }
        isCanceled = i == "!"

        if isGarbage && i == ">" {  isGarbage = false }
        if isGarbage { continue }
        isGarbage = i == "<"
        
        if i == "}" && stack.peek() == "{" {
            stack.pop()
        }
        else if i == "{" || i == "}" {
            stack.push(i)
            score += stack.count()
        }
    }
    print(score)
}

func processInput2(input: String) {
    let stack: Stack = Stack()
    var score = 0
    var garbageCount = 0
    var isCanceled = false
    var isGarbage = false
    for i in input {
        if isCanceled {
            isCanceled = false
            continue
        }
        isCanceled = i == "!"

        if isGarbage && i == ">" {  isGarbage = false }
        if isGarbage {
            if i != "!" { garbageCount += 1 }
            continue
        }
        isGarbage = i == "<"
        
        if i == "}" && stack.peek() == "{" {
            stack.pop()
        }
        else if i == "{" || i == "}" {
            stack.push(i)
            score += stack.count()
        }
    }
    print(garbageCount)
}

if let input = readInput() {
    processInput2(input: input)
}
