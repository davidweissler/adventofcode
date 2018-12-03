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
    let inputArr = input.components(separatedBy: "\n")
    var fabric : [[Int]] = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)

    inputArr.forEach {
        let stripped = $0
            .replacingOccurrences(of: "#", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: " @ ", with: " ", options: .literal, range: nil)
            .replacingOccurrences(of: ":", with: "", options: .literal, range: nil)
        
        let parsed = stripped.components(separatedBy: " ")
        let id: Int = Int(parsed[0]) ?? 0
        let xAndY = parsed[1].components(separatedBy: ",")
        let x = Int(xAndY[0]) ?? 0
        let y = Int(xAndY[1]) ?? 0
        let size = parsed[2].components(separatedBy: "x")
        let width = Int(size[0]) ?? 0
        let height = Int(size[1]) ?? 0
        for i in x..<x + width {
            for j in y..<y + height {
                if fabric[j][i] != 0 {
                    fabric[j][i] = -1
                } else {
                    fabric[j][i] = id
                }
            }
        }
    }
    var overlapCount = 0
    fabric.forEach { $0.forEach { if $0 == -1 { overlapCount += 1 } } }
    print(overlapCount)
}

func processInput2(_ input: String) {
    let inputArr = input.components(separatedBy: "\n")
    var fabric : [[Int]] = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
    
    let strippedInput = inputArr.map {
        $0.replacingOccurrences(of: "#", with: "", options: .literal, range: nil)
        .replacingOccurrences(of: " @ ", with: " ", options: .literal, range: nil)
        .replacingOccurrences(of: ":", with: "", options: .literal, range: nil)
    }
    
    strippedInput.forEach {
        let parsed = $0.components(separatedBy: " ")
        let id: Int = Int(parsed[0]) ?? 0
        let xAndY = parsed[1].components(separatedBy: ",")
        let x = Int(xAndY[0]) ?? 0
        let y = Int(xAndY[1]) ?? 0
        let size = parsed[2].components(separatedBy: "x")
        let width = Int(size[0]) ?? 0
        let height = Int(size[1]) ?? 0
        for i in x..<x + width {
            for j in y..<y + height {
                if fabric[j][i] != 0 {
                    fabric[j][i] = -1
                } else {
                    fabric[j][i] = id
                }
            }
        }
    }
    
    for s in strippedInput {
        let parsed = s.components(separatedBy: " ")
        let id: Int = Int(parsed[0]) ?? 0
        let xAndY = parsed[1].components(separatedBy: ",")
        let x = Int(xAndY[0]) ?? 0
        let y = Int(xAndY[1]) ?? 0
        let size = parsed[2].components(separatedBy: "x")
        let width = Int(size[0]) ?? 0
        let height = Int(size[1]) ?? 0
        
        var found = true
        for i in x..<x + width {
            for j in y..<y + height {
                if fabric[j][i] != id {
                    found = false
                    break
                }
            }
            if !found { break }
        }
        if found {
            print(id)
            return
        }
    }    
}

if let input = readInput() {
    processInput2(input)
}
