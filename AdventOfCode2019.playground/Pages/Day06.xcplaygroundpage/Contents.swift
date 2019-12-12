//: [Previous](@previous)


/*
 find_path algorithm
 
 https://stackoverflow.com/questions/19472530/representing-graphs-data-structure-in-python
 Part 1: Treat the graph as directed
 Part 2: Treat the graph as undirected
 */

import UIKit
import PlaygroundSupport

let page = PlaygroundPage.current
//page.needsIndefiniteExecution = true


public typealias Node = String
//public typealias Node = String
public typealias Edge = (Node,Node)


class Day06 {
    
    private func loadEdges(fileName:String) -> [(Node,Node)] {
        var edgeList:[(Node,Node)] = []
        
        let path = Bundle.main.url(forResource: fileName, withExtension: "txt")
        do {
            
            let text = try String(contentsOf: path!, encoding: .utf8)
            
            let lines = text.components(separatedBy:.whitespacesAndNewlines)//.compactMap({Int($0)})
            for line in lines {
                if line.count > 0 {
                    let nodes = line.split(separator: ")")
                    let node1:Node = String(nodes[0])
                    let node2:Node = String(nodes[1])
                    let node:(Node,Node) = (node1, node2)
                    edgeList.append(node )
                }
            }
        } catch {
            print(error)
            edgeList = []
            // Handle the error
        }
        return edgeList
        
        
    }
    public func test1() {
        //
        let graph = Graph()
        graph.addEdge(source: "A", dest: "B")
        graph.addEdge(source: "A", dest: "C")
        
        graph.dump()
        
    }
    
    func test2() {
        let graph = Graph()
        //let nodes = [("A", "B"), ("B", "C"), ("B", "D"), ("C", "D"), ("E", "F"), ("F", "C")]
        let nodes = [("a","b"), ("a","c"),  ("b","e"),("b","f"),("e","g"), ("f","g"),("c","d")]
        //let nodes = [("a","b"), ("a","c"),("c","d")]
        graph.addEdges(edgeList: nodes)
        graph.dump()
        let path = graph.findPath(node1: "a", destNode: "d", path: [])
        path.count-1 // 2
        
    }
    
    public func test3() ->Int {
        let graph = Graph()
        let nodes = [("COM","B"),
                     ("B","C"),
                     ("C","D"),
                     ("D","E"),
                     ("E","F"),
                     ("B","G"),
                     ("G","H"),
                     ("D","I"),
                     ("E","J"),
                     ("J","K"),
                     ("K","L")]
        graph.addEdges(edgeList: nodes)
        graph.dump()
        let path = graph.findPath(node1: "COM", destNode: "D")
        let pathToL = graph.findPath(node1: "COM", destNode: "L")
        pathToL.count-1
        let pathToCOM = graph.findPath(node1: "COM", destNode: "COM")
        pathToCOM.count-1
        
        let pathIToK = graph.findPath(node1: "I", destNode: "K")
        
        let orbits = graph.calcTotalLength()
        return orbits
    }
    
    public func test4() ->Int {
        let graph = Graph(isDirected: false)
        let nodes = [("COM","B"),
                     ("B","C"),
                     ("C","D"),
                     ("D","E"),
                     ("E","F"),
                     ("B","G"),
                     ("G","H"),
                     ("D","I"),
                     ("E","J"),
                     ("J","K"),
                     ("K","L"),
                     ("K","YOU"),
                     ("I","SAN")]
        graph.addEdges(edgeList: nodes)
        graph.dump()
        print("--------")
        let pathIToK = graph.findPath(node1: "YOU", destNode: "SAN")
        //        let pathIToK = graph.findReversePath(destNode: "SAN", startNode: "YOU") // == 6
        
        //        let pathIToK = graph.findPath(node1: "I", destNode: "K")
        print("# = \(pathIToK.count)=> \(pathIToK.count-3) PATH=\(pathIToK)")
        print("Test 4 complete")
        return pathIToK.count
    }
    
    public func part1() -> Int {
        //
        let graph = Graph()
        let edges = loadEdges(fileName: "input06")
        graph.addEdges(edgeList: edges)
        
        let orbits = graph.calcTotalLength() // 139597
        return orbits
    }
    
    public func part2() -> Int {
        //
        let graph = Graph(isDirected: false)
        let edges = loadEdges(fileName: "input06")
        graph.addEdges(edgeList: edges)
        graph.dump()
        print("--------")
        //SAN, ["X7C"]
        //YOU, ["31G"]
        
        //        let pathIToK = graph.findReversePath(destNode: "YOU", startNode: "SAN")
        //        let pathIToK = graph.findReversePath(destNode: "YOU", startNode: "SAN")
        let pathIToK = graph.findPath(node1: "YOU", destNode: "SAN")
        //        let pathIToK = graph.findReversePath(destNode: "31G", startNode: "X7C")
        
        //        let pathIToK = graph.findPath(node1: "I", destNode: "K")
        
        //        let orbits = graph.calcTotalLength()
        print("Part 2 complete") // 285 -- 287 too high Freaking off by one.
        // Remove 2 for YOU and SAN, then 1 more. 
        print("# = \(pathIToK.count)=> ** \(pathIToK.count-3) PATH=\(pathIToK)")
        
        //        print("PATH=\(pathIToK)")
        return pathIToK.count - 3
    }
}

let day06 = Day06()
//day06.test2()
//let len = day06.test3()
//let len4 = day06.test4()

//let result1 = day06.part1()
//print("result1=\(result1)")
let result2 = day06.part2()
print("result2=\(result2)")
