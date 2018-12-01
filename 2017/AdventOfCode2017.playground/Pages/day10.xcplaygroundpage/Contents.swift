//: [Previous](@previous)

import Foundation

func processInput1() {
    var lengths = [3, 4, 1, 5]
    
    // create list
    var list = [Int]()
    for i in 0..<5 {
        list.append(i)
    }
    
    var currPos = 0
    var skipSize = 0
    
    print(list)
    
    for length in lengths {
        print("length: \(length)")
        if currPos + length <= list.count - 1 {
            print(currPos)
            list[currPos..<currPos + length] = ArraySlice(list[currPos..<currPos + length].reversed())
        } else {
            var leftMarker = (currPos + length) - list.count - 1
            
            var leftSlice = list[0...leftMarker]
            var rightSlice = list[currPos...list.count - 1]
            
            var conSlice = ArraySlice((rightSlice + leftSlice).reversed())
            list[currPos...list.count - 1] = conSlice[0...list.count - 1 - currPos]
            list[0...leftMarker] = conSlice[list.count - currPos...conSlice.count - 1]
        }
        
        if length == 1 {
            print("currPos1: \(currPos) skipSize: \(skipSize)")
        }
        currPos += (length + skipSize)
        if currPos > list.count - 1 {
            if length == 1 {
                print("currPos2: \(currPos)")
            }
            currPos = currPos - list.count - 1
        }
        skipSize += 1
        print(list)
        print("currPosX: \(currPos) skipSize: \(skipSize)")
    }
}

processInput1()

