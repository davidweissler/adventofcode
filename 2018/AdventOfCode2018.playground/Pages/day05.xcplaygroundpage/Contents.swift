//: [Previous](@previous)

import Foundation

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(_ input: String) {
    var newInput = input
    let letter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let letters = letter.map { String($0) }
    
    var found = true
    while found {
        let prevCount = newInput.count
        for l in letters {
            newInput = newInput.replacingOccurrences(of: "\(l.uppercased())\(l.lowercased())", with: "", options: .literal, range: nil)
        }
        for l in letters {
            newInput = newInput.replacingOccurrences(of: "\(l.lowercased())\(l.uppercased())", with: "", options: .literal, range: nil)
        }
        found = prevCount != newInput.count
    }
    print(newInput)
    print(newInput.count)
}

func processInput2(_ input: String) {
    let letter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let letters = letter.map { String($0) }
    var removalScore = [String : Int]()
    var newInput = ""
    for ll in letters {
        newInput = input
        newInput = newInput.replacingOccurrences(of: ll, with: "", options: .literal, range: nil)
            .replacingOccurrences(of: ll.lowercased(), with: "", options: .literal, range: nil)        
        // fully react
        var found = true
        while found {
            let prevCount = newInput.count
            for l in letters {
                newInput = newInput.replacingOccurrences(of: "\(l.uppercased())\(l.lowercased())", with: "", options: .literal, range: nil)
            }
            for l in letters {
                newInput = newInput.replacingOccurrences(of: "\(l.lowercased())\(l.uppercased())", with: "", options: .literal, range: nil)
            }
            found = prevCount != newInput.count
        }
        removalScore[ll, default: 0] = newInput.count
    }
    print(removalScore)
}

if let input = readInput() {
    processInput2(input)
}
