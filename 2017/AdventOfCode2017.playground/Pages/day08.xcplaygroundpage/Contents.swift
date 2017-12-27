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

func updateReg(op: String, diff: Int, val: Int) -> Int {
    if op == "inc" {
        return val + diff
    } else {
        return val - diff
    }
}

func processInput1(input: String) {
    var registers = [String : Int]()
    
    input.split(separator: "\n").forEach { s in
        var line = s.split(separator: " ")
        let regToUpdate = String(line[0])
        let op = String(line[1])
        let amt = Int(String(line[2]))!
        let condReg = String(line[4])
        let condComp = String(line[5])
        let condCheck = Int(String(line[6]))!
        
        var condRegValue = 0
        if let foundCondReg = registers[condReg] {
            condRegValue = foundCondReg
        } else {
            registers[condReg] = 0
        }
        
        var regValue = 0
        if let regToUpdateVal = registers[regToUpdate] {
            regValue = regToUpdateVal
        } else {
            registers[regToUpdate] = 0
        }
        
        if condComp == ">" {
            if condRegValue > condCheck {
                registers[regToUpdate] = updateReg(op: op, diff: amt, val: registers[regToUpdate]!)
            }
        } else if condComp == ">=" {
            if condRegValue >= condCheck {
                registers[regToUpdate] = updateReg(op: op, diff: amt, val: registers[regToUpdate]!)
            }
        } else if condComp == "<" {            
            if condRegValue < condCheck {
                registers[regToUpdate] = updateReg(op: op, diff: amt, val: registers[regToUpdate]!)
            }
        } else if condComp == "<=" {
            if condRegValue <= condCheck {
                registers[regToUpdate] = updateReg(op: op, diff: amt, val: registers[regToUpdate]!)
            }
        } else if condComp == "==" {
            if condRegValue == condCheck {
                registers[regToUpdate] = updateReg(op: op, diff: amt, val: registers[regToUpdate]!)
            }
        } else if condComp == "!=" {
            if condRegValue != condCheck {
                registers[regToUpdate] = updateReg(op: op, diff: amt, val: registers[regToUpdate]!)
            }
        }
    }

    var maxValue = Int.min
    for (_, value) in registers {
        maxValue = max(maxValue, value)
    }
    print(maxValue)
}

if let input = readInput() {
    processInput1(input: input)
}
