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

func processInput1(_ input: String) {
    var intArr = input.components(separatedBy: ",")
        .map { Int($0) ?? 0 }

    intArr[1] = 12
    intArr[2] = 2
    for i in stride(from: 0, to: intArr.count, by: 4) {
        let currentVal = intArr[i]
        if currentVal == 99 {
            print(intArr[0])
            return
        }

        let pos1 = intArr[i + 1]
        let pos2 = intArr[i + 2]
        let pos3 = intArr[i + 3]
        let val1 = intArr[pos1]
        let val2 = intArr[pos2]

        if currentVal == 1 {
            intArr[pos3] = val1 + val2
            continue
        }
        
        if currentVal == 2 {
            intArr[pos3] = val1 * val2
            continue
        }
    }
}

func processInput2(_ input: String) {
    let originalArr = input.components(separatedBy: ",")
        .map { Int($0) ?? 0 }

    for noun in 0...99 {
        for verb in 0...99 {
            var intArr = originalArr
            intArr[1] = noun
            intArr[2] = verb
            
            for i in stride(from: 0, to: intArr.count, by: 4) {
                let currentVal = intArr[i]
                if currentVal == 99 {
                    if intArr[0] == 19690720 {
                        print("noun \(noun) verb \(verb) reach 99 intArr[0] \(intArr[0])")
                        print(100 * noun + verb)
                        return
                    } else {
                        break
                    }
                }

                let pos1 = intArr[i + 1]
                let pos2 = intArr[i + 2]
                let pos3 = intArr[i + 3]
                let val1 = intArr[pos1]
                let val2 = intArr[pos2]
                if currentVal == 1 {
                    intArr[pos3] = val1 + val2
                    continue
                }
                if currentVal == 2 {
                    intArr[pos3] = val1 * val2
                    continue
                }
            }
        }
    }

}

if let input = readInput() {
    processInput2(input)
}

