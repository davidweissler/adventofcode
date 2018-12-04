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
    let inputArr = input.components(separatedBy: "\n").sorted()
    var times = [Int: [Int]]()
    var guardId = 0
    var sleepStart = 0
    var sleepEnd = 0
    for line in inputArr {
        let strippedLine = line.replacingOccurrences(of: "[", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: "]", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: "#", with: "", options: .literal, range: nil)
        let parsedLine = strippedLine.components(separatedBy: " ")
        if parsedLine.count == 6 {
            // Get guard id
            guardId = Int(parsedLine[3]) ?? 0
            if times[guardId] == nil {
                times[guardId] = Array(repeating: 0, count: 60)
            }
            sleepStart = 0
            sleepEnd = 0
        } else if parsedLine.last == "asleep" {
            sleepStart = Int(parsedLine[1].replacingOccurrences(of: "00:", with: "", options: .literal, range: nil)) ?? 0
        } else if parsedLine.last == "up" {
            sleepEnd = Int(parsedLine[1].replacingOccurrences(of: "00:", with: "", options: .literal, range: nil)) ?? 0
            for i in sleepStart..<sleepEnd {
                times[guardId]?[i] += 1
            }
        }
    }
    
    var maxKey = (0, 0)
    for (_,v) in times.enumerated() {
        let totalMinutes = v.value.reduce(0,+)
        if totalMinutes > maxKey.1 {
            maxKey.0 = v.key
            maxKey.1 = totalMinutes
        }
    }
    let maxValue = times[maxKey.0]?.max() ?? 0
    let maxIndex = times[maxKey.0]?.firstIndex(of: maxValue)
    
    print(maxKey.0 * (maxIndex ?? 0))
}

func processInput2(_ input: String) {
    let inputArr = input.components(separatedBy: "\n").sorted()
    var times = [Int: [Int]]()
    var guardId = 0
    var sleepStart = 0
    var sleepEnd = 0
    for line in inputArr {
        let strippedLine = line.replacingOccurrences(of: "[", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: "]", with: "", options: .literal, range: nil)
            .replacingOccurrences(of: "#", with: "", options: .literal, range: nil)
        let parsedLine = strippedLine.components(separatedBy: " ")
        if parsedLine.count == 6 {
            // Get guard id
            guardId = Int(parsedLine[3]) ?? 0
            if times[guardId] == nil {
                times[guardId] = Array(repeating: 0, count: 60)
            }
            sleepStart = 0
            sleepEnd = 0
        } else if parsedLine.last == "asleep" {
            sleepStart = Int(parsedLine[1].replacingOccurrences(of: "00:", with: "", options: .literal, range: nil)) ?? 0
        } else if parsedLine.last == "up" {
            sleepEnd = Int(parsedLine[1].replacingOccurrences(of: "00:", with: "", options: .literal, range: nil)) ?? 0
            for i in sleepStart..<sleepEnd {
                times[guardId]?[i] += 1
            }
        }
    }
    
    var maxKey = (guardID: 0, vals: (maxVal: 0, minute: 0))
    for (_,v) in times.enumerated() {
        let times = v.value
        let max = times.max() ?? 0
        if max > maxKey.vals.maxVal {
            maxKey.guardID = v.key
            maxKey.vals.maxVal = max
            maxKey.vals.minute = times.firstIndex(of: max) ?? 0
        }
    }
    print(maxKey)
    print(maxKey.guardID * maxKey.vals.minute)
}

if let input = readInput() {
    processInput2(input)
}
