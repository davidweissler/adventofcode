//: [Previous](@previous)

import Foundation

class Node : Hashable {
    var name: String
    var hashValue: Int {
        return self.name.hashValue
    }
    var selfWeight: Int = 0
    var weight: Int = 0 {
        willSet(newWeight) {
        }
        didSet {
            let diff = weight - oldValue
            if let parent = self.parent {
                parent.addWeight(w: diff)
            }
        }
    }
    var children = [Node]()
    var parent: Node? = nil
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }
    
    func addWeight(w: Int) {
        self.weight += w
    }
    
    func addChild(child: Node) {
        child.parent = self;
        self.children.append(child)
    }
    
    func findNode(name: String) -> Node? {
        if self.name == name {
            return self
        }
        var queue = [Node]()
        queue.insert(self, at: 0)
        
        while queue.count > 0 {
            let count = queue.count
            for _ in 0..<count {
                let lastNode = queue.popLast()
                if lastNode?.name == name {
                    return lastNode
                } else {
                    lastNode?.children.forEach{ c in queue.insert(c, at: 0) }
                }
            }
        }
        return nil
    }
}

// Parsing funcs

func readInput() -> String? {
    let fileURL = Bundle.main.url(forResource: "Input", withExtension: "txt")
    let content = try? String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    guard var input = content else { return nil }
    input.removeLast()
    return input
}

func processInput1(input: String) {
    var left = Set<String>()
    var right = Set<String>()
    input.split(separator: "\n").forEach { s in
        let s1 = s.replacingOccurrences(of: ",", with: "")
        var lineSep = s1.split(separator: " ")
        left.insert(String(lineSep[0]))
        if lineSep.count > 3 {
            lineSep.removeFirst(3)
            lineSep.forEach({ rest in
                right.insert(String(rest))
            })
        }
    }
    print(left.subtracting(right))
}

func processInput2(input: String) {
    // Create all nodes
    var left = [String : Node]()
    input.split(separator: "\n").forEach { s in
        let s1 = s.replacingOccurrences(of: ",", with: "")
        var lineSep = s1.split(separator: " ")
        let name = String(lineSep[0])
        let lNode = Node(name: name)
        left[name] = lNode
    }
    
    // Add nodes to tree
    input.split(separator: "\n").forEach { s in
        let s1 = s.replacingOccurrences(of: ",", with: "")
        var lineSep = s1.split(separator: " ")
        let lName = String(lineSep[0])
        if lineSep.count > 3 {
            lineSep.removeFirst(3)
            lineSep.forEach({ rest in
                let rName = String(rest)
                if left[rName] != nil  {
                    let cNode = left.removeValue(forKey: rName)!
                    if let leftNode = left[lName] {
                        leftNode.addChild(child: cNode)
                    } else {
                        for (_, node) in left {
                            if let searchedNode = node.findNode(name: lName) {
                                searchedNode.addChild(child: cNode)
                            }
                        }
                    }
                    
                }
            })
        }
    }
    
    print(left)
    let parentNode: Node = Array(left.values)[0]
    
    // update weights
    input.split(separator: "\n").forEach { s in
        let s1 = s.replacingOccurrences(of: ",", with: "")
        var lineSep = s1.split(separator: " ")
        let name = String(lineSep[0])
        let weight = lineSep[1].replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        if let findNode = parentNode.findNode(name: name) {
            findNode.selfWeight = Int(weight)!
            findNode.addWeight(w: Int(weight)!)
        }
    }
    
    // Level traverse tree and print weights
    var queue = [Node]()
    queue.insert(parentNode, at: 0)
    
    while queue.count > 0 {
        let count = queue.count
        for _ in 0..<count {
            if let lastNode = queue.popLast() {
                print("\(lastNode.name)(\(lastNode.weight)) ", separator: " ", terminator: "")
                lastNode.children.forEach{ c in queue.insert(c, at: 0) }
            }
        }
        print()
        print()
    }
}

if let input = readInput() {
    processInput2(input: input)
}

