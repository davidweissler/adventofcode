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
  var count = 0
  for inputLine in input.components(separatedBy: "\n\n") {
    let line = inputLine.replacingOccurrences(of: "\n", with: " ")
    let lineArr = line.components(separatedBy: " ")
    if lineArr.count == 8 {
      count += 1
      continue
    }
    if lineArr.count == 7 && !line.contains("cid") {
      count += 1
      continue
    }
  }
  print(count)
}

func processInput2(_ input: String) {
  var present = [[String]]()
  for inputLine in input.components(separatedBy: "\n\n") {
    let line = inputLine.replacingOccurrences(of: "\n", with: " ")
    let lineArr = line.components(separatedBy: " ")
    if lineArr.count == 8 {
      present.append(lineArr)
      continue
    }
    if lineArr.count == 7 && !line.contains("cid") {
      present.append(lineArr)
      continue
    }
  }

  var valid = 0
  for entry in present {
    print(entry)
    var isValid = true
    for attribute in entry {
      if !isValid {
        continue
      }
      
      let attributeArr = attribute.components(separatedBy: ":")
      if attributeArr[0] == "byr" {
        if let yr = Int(attributeArr[1]) {
          if !(yr >= 1920 && yr <= 2002) {
            isValid = false
            continue
          }
        } else {
          isValid = false
          continue
        }
      } else if attributeArr[0] == "iyr" {
        if let yr = Int(attributeArr[1]) {
          if !(yr >= 2010 && yr <= 2020) {
            isValid = false
            continue
          }
        } else {
          isValid = false
          continue
        }
      } else if attributeArr[0] == "eyr" {
        if let yr = Int(attributeArr[1]) {
          if !(yr >= 2020 && yr <= 2030) {
            isValid = false
            continue
          }
        } else {
          isValid = false
          continue
        }
      } else if attributeArr[0] == "ecl" {
        let color = attributeArr[1]
        if !["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(color) {
          isValid = false
          continue
        }
      } else if attributeArr[0] == "pid" {
        let num = attributeArr[1]
        if num.count != 9 {
          isValid = false
          continue
        }
        if Int(num) == nil {
          isValid = false
          continue
        }
      } else if attributeArr[0] == "hcl" {
        let color = attributeArr[1]
        if color.count != 7 {
          isValid = false
          continue
        }
        let colorArr = color.map { $0 }
        if colorArr[0] != "#" {
          isValid = false
          continue
        }
        for i in 1..<colorArr.count {
          if Int(String(colorArr[i])) != nil {
            continue
          }
          if !((colorArr[i].asciiValue ?? 0) >= 97 && (colorArr[i].asciiValue ?? 0) <= 102) {
            isValid = false
            continue
          }
        }
      } else if attributeArr[0] == "hgt" {
        var height = attributeArr[1]
        if height.contains("in") {
          height = height.replacingOccurrences(of: "in", with: "")
          if let heightNum = Int(height) {
            if !(heightNum >= 59 && heightNum <= 76) {
              isValid = false
              continue
            }
          } else {
            isValid = false
            continue
          }
        } else if height.contains("cm") {
          height = height.replacingOccurrences(of: "cm", with: "")
          if let heightNum = Int(height) {
            if !(heightNum >= 150 && heightNum <= 193) {
              isValid = false
              continue
            }
          } else {
            isValid = false
            continue
          }

        } else {
          isValid = false
          continue
        }
      }
    }
    if isValid {
      valid += 1
    }
  }
  print(valid)
}

if let input = readInput() {
    processInput2(input)
}
