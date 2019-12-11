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
    let inputArr = input.map { Int(String($0))! }
    print(inputArr)
    
    var rowLength = 25
    var colLength = 6
    var layers = [[[Int]]]()
    var layer = [[Int]]()
    var row = [Int]()
    for (index, number) in inputArr.enumerated() {
        row.append(number)
        if index % rowLength == rowLength - 1 {
            layer.append(row)
            // make a new row
            row = [Int]()
        }

        if index % (rowLength * colLength) == (rowLength * colLength) - 1 {
            layers.append(layer)
            // make a new layer
            layer = [[Int]]()
        }
    }

    var lowestLayer = [[Int]]()
    var layerZeroCount = Int.max
    layers.forEach { layer in
        var zeroCount = 0
        layer.forEach { row in
            let zeros = row.filter { $0 == 0 }
            zeroCount += zeros.count
        }
        if zeroCount < layerZeroCount {
            layerZeroCount = zeroCount
            lowestLayer = layer
        }
    }
    print(layers)
    print(lowestLayer)
    var oneDigits = 0
    var twoDigits = 0
    lowestLayer.forEach { row in
        row.forEach {
            if $0 == 1 { oneDigits += 1 }
            else if $0 == 2 { twoDigits += 1 }
        }
    }
    print(oneDigits * twoDigits)
}

if let input = readInput() {
    processInput1(input)
}
