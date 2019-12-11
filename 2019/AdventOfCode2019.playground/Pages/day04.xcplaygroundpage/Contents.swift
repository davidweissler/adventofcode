//: [Previous](@previous)

import Foundation


func part1(lower: Int, upper: Int) -> Int {
    var possiblePasswords = 0
    
    for num in lower...upper {
        let numArr = String(num).map { Int(String($0))! }
        
        var isDecreasing = false
        var hasDouble = false
        var prevNum = -1
        for digit in numArr {
            if digit < prevNum {
                isDecreasing = true
            }
            if isDecreasing { break }

            if digit == prevNum {
                hasDouble = true
            }
            prevNum = digit
        }
        
        if hasDouble && !isDecreasing {
            possiblePasswords += 1
        }
    }
    return possiblePasswords
}

let lowerBounds = 128392
let upperBounds = 643281
part1(lower: lowerBounds, upper: upperBounds)
