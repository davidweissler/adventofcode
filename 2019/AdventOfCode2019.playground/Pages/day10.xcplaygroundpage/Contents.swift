import Foundation

var str = "Hello, playground"

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(_ input: String) {
    var inputArr = [[String]]()
    let inputLines = input.components(separatedBy: "\n")
    inputLines.forEach { inputArr.append($0.map { String($0) }) }
    print(inputArr)
    
    var asteroidMax = 0
    for i in 0..<inputArr.count {
        let line = inputArr[i]
        for j in 0..<line.count {
            if inputArr[i][j] == "." { continue }
            // find the unique slopes of all the other asteroids in the map
            var slopeMap = Set<String>()
            for ii in 0..<inputArr.count {
                let lineCheck = inputArr[ii]
                for jj in 0..<lineCheck.count {
                    if ii == i && jj == j { continue }
                    if inputArr[ii][jj] == "." { continue }
                    let rise = i - ii
                    let run = j - jj
                    let ror = Float(Float(rise)/Float(run))
                    
                    if rise == 0 {
                        if run < 0 {
                            slopeMap.insert("-0")
                        } else {
                            slopeMap.insert("+0")
                        }
                        continue
                    }

                    var quad = ""
                    if ii <= i && jj <= j { quad = "1" }
                    else if ii <= i && jj > j { quad = "2" }
                    else if ii > i && jj <= j { quad = "3" }
                    else if ii > i && jj > j { quad = "4" }
                    slopeMap.insert("\(quad)-\(ror)")
                }
            }
            //print("\(j), \(i): \(slopeMap.count)")
            //print(slopeMap)
            asteroidMax = max(asteroidMax, slopeMap.count)
        }
    }
    print(asteroidMax)
}

if let input = readInput() {
    processInput1(input)
}
