import Foundation

public typealias Node = String
public typealias Edge = (Node,Node)

public class Graph {
    //
    private var edges:[Node:Set<Node>] = [:]
    private var _allNodes:Set<Node> = Set()
    private let _isDirected:Bool
    
    public init(isDirected:Bool=false) {_isDirected = isDirected}
    
    public func addEdges(edgeList:[(Node, Node)]) {
        for nodePair in edgeList {
            let source = nodePair.0
            let dest = nodePair.1
            addEdge(source: source, dest: dest)
        }
    }
    
    public func addEdge(source:Node, dest:Node) {
        if !_allNodes.contains(source) {
            _allNodes.insert(source)
        }
        if !_allNodes.contains(dest) {
            _allNodes.insert(dest)
        }
        
        if edges[source] == nil {
             edges[source] = Set<Node>([dest])
        }
        edges[source]?.insert(dest)

        if !_isDirected {
            if edges[dest] == nil {
                edges[dest] = Set<Node>([source])
            }
            edges[dest]?.insert(source)
            
        }
    }
    
    public func dump() {
        print("All Nodes: \(_allNodes)")
        for vert in _allNodes {
            if let edgeList = edges[vert] {
                
                print("\(vert), \(edgeList)")
            }
        }
    }
    
    public func calcTotalLength() -> Int {
        var total = 0
        var currentNodeCtr = 0
        
        let allNodes = _allNodes.sorted()   // fix
        let totalNodes = allNodes.count
        
        for dest in allNodes {
            currentNodeCtr += 1
            
            print("Dest \(dest), \(currentNodeCtr)/\(totalNodes)")
            for src in allNodes {
                if src != dest {
                    print("src=\(src) dest=\(dest)")
                    let path = findPath(node1: src, destNode: dest)
                    if path.count > 0 {
                        total += 1
                        print("\(src) => \(dest), \(total), \(path)")
                    }
                }
                
            }
            
        }
        return total
    }
    
    /*
     
     Work backwards from the destination to see if the startNode can reach me
     */
    /*
    public func findReversePath(destNode:Node, startNode:Node, path:[Node]=[], shortest:[Node]=[]) -> [Node] {
        
//        print("Destination=\(destNode) ->\(startNode), \(path)")
        var newPath = path
        var shortest_path = shortest
        
        if path.contains(destNode) {
            return []
        }
        
        newPath.append(destNode)
        
        if startNode == destNode {// we've arrived
//            print("Done: \(newPath)")
            return newPath
        }
        
        if edges[destNode] == nil {
//            print("Dead end: On \(destNode) => \(startNode) \(newPath)")
            return []
        }// dead end
        
        for nextNode in _allNodes {
            if let edgeSet = edges[nextNode] {
                if edgeSet.contains(destNode) {
//                    print("Checking: \(nextNode) from \(destNode)")
                    let solution = findReversePath(destNode: nextNode, startNode: startNode, path: newPath, shortest: shortest_path)
                    if solution.count > 0 {
                        print("maybe: \(solution):\(solution.count), \(shortest_path):\(shortest_path.count)")
                        if shortest_path.count == 0 || solution.count < shortest_path.count {
                            shortest_path = solution
                            print("shortest: \(solution), \(shortest_path.count)")
                        }
                        
                    }
                }
            }
        }
        return shortest_path
        
    }
    */
    /*
     Our data is being treated as a DAG - Directed Acyclic Graph
     
     Won't find a path from I to J
     */
    public func findPath(node1:Node, destNode:Node, path:[Node]=[], shortest:[Node]=[]) -> [Node] {
        
        var newPath = path
        var shortest_path = shortest
        // Find any path between node1 and destNode (may not be shortest)
        if path.contains(node1) {
            return []
        }
        newPath.append(node1)
        
        if node1 == destNode {// we've arrived
//            print("Done: \(newPath)")
            return newPath
        }
        
        if edges[node1] == nil {
//            print("Dead end: On \(node1) => \(destNode) \(newPath)")
            return []
        }// dead end
        
        
        if let node1EdgeSet = edges[node1] { // else dead end
//                        print("from \(node1) ->\(node1EdgeSet)")
            // all
            
            for (_, nextNode) in node1EdgeSet.enumerated() { // each successor
                
                // if node not in path
                if !newPath.contains(destNode) {
                    //                    print("Checking: \(node), \(destNode), \(newPath)")
                    let solution = findPath(node1:nextNode, destNode: destNode, path:newPath, shortest: shortest_path)
                    //                    print("\(solution), \(shortest_path)")
                    if solution.count > 0 {
                        //                        print("maybe: \(solution), \(shortest_path)")
                        if shortest_path.count == 0 || solution.count < shortest_path.count {
                            shortest_path = solution
                            //                            print("shortest: \(solution)")
                        }
                        
                    }
                    
                }
            }
        }
        return shortest_path
    }
}
