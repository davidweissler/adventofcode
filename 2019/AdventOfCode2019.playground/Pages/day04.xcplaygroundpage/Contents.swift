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

func part2(lower: Int, upper: Int) -> Int {
    var possiblePasswords = 0
    
    for num in lower...upper {
        let numArr = String(num).map { Int(String($0))! }
        
        var matchingDigitCount = 1
        var hasDouble = false
        var isDecreasing = false
        var prevNum = -1
        for digit in numArr {
            if digit < prevNum {
                isDecreasing = true
            }
            if isDecreasing { break }

            if !hasDouble {
                if digit == prevNum {
                    matchingDigitCount += 1
                } else {
                    if matchingDigitCount == 2 {
                        hasDouble = true
                    }
                    matchingDigitCount = 1
                }
            }
            prevNum = digit
        }
        
        if (hasDouble || matchingDigitCount == 2) && !isDecreasing {
            possiblePasswords += 1
        }
    }
    return possiblePasswords
}

let lowerBounds = 128392
let upperBounds = 643281
print(part2(lower: lowerBounds, upper: upperBounds))
