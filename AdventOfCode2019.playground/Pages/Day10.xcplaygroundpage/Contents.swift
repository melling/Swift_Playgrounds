//: [Previous](@previous)


/*
 
 Problem: https://adventofcode.com/2019/day/10
 
 https://www.reddit.com/r/adventofcode/comments/e8zu6b/day_10_part_1_is_my_thinking_mathematically_wrong/
 
 https://www.reddit.com/r/adventofcode/comments/e8vyn5/2019_day_10_part1_why_slopes_wont_work_or_what_am/
 
 https://en.wikipedia.org/wiki/Polar_coordinate_system
 
 https://www.mathsisfun.com/polar-cartesian-coordinates.html
 
 p1=267?
 @10m p2
 @32:40 review
 
 maximum slopes by each location
 
 4 quadrant slope
 
 */
import UIKit

typealias Grid = [[String]]

struct Coord:Hashable {
    let row:Int
    let col:Int
}

struct Solution {
    let row:Int
    let col:Int
    let nVisible:Int
    
}
func gcd(_ a:Int,_ b:Int) -> Int {
    if (b==0) {
        return a
    } else {
        return gcd(b,a % b)
    }
}

//let x = gcd(60, 48)


class Day10 {
    //
    
    private func loadGrid(fileName:String) -> Grid {
        var grid:Grid = []
        
        let path = Bundle.main.url(forResource: fileName, withExtension: "txt")
        do {
            
            var text = try String(contentsOf: path!, encoding: .utf8)
            
            let lines = text.components(separatedBy:.whitespacesAndNewlines)//.compactMap({Int($0)})
            for line in lines {
                if line.count > 0 {
                    
                    let row = line.map { String($0) }
//                    print("\(row)")
                    grid.append(row)
                }
            }
        } catch {
            
            print(error)
            
        }
        return grid
    }
    
    /*
     .#..#
     .....
     #####
     ....#
     ...##
     */
    
    func findNumberVisible(_ r:Int,_ c:Int, grid:Grid) -> Int {
        let nCols:Int = grid[0].count
        var visible:Set<Coord> = []
        
        for row in 0 ..< grid.count {
            for col in 0 ..< nCols {
                if grid[row][col] == "#" && (row != r || col != c){
//                    print("(\(r),\(c)) -> (\(row),\(col))")
                    let dr = row - r
                    let dc = col - c
                    var g = gcd(dr, dc)
                    if g < 0 {
                        g *= -1
                    }
                    let r0 = -dr / g
                    let c0 = dc / g
//                    print("\(r),\(c) -> \(row),\(col) = \(r0), \(c0)")
                    let coord = Coord(row: r0, col: c0)
                    visible.insert(coord)
                }
                
            }
        }
        return visible.count
    }
    
    func calc(grid:Grid) {
        //
        let nCols:Int = grid[0].count
        var coord = Coord(row: -1, col: -1)
        var largest = -1
        
        for row in 0 ..< grid.count {
            for col in 0 ..< nCols {
                if grid[row][col] == "#" {
//                    print("\(row),\(col)")
                    let n = findNumberVisible(row, col, grid: grid)
                    if n > largest {
                        largest = n
                        coord = Coord(row: row, col: col)
                    }
                }
                
            }
        }
        print("ans= \(largest) \(coord)")
        
    }
    
    
    
    public func test1() {
        
        //let grid = loadGrid(fileName: "input10_t0")
        let grid = loadGrid(fileName: "input10")
        calc(grid: grid)
        //let g = processGrid(grid: grid1)
        //g.count
        
    }
    
}




let str0 = """
.#..#
 .....
 #####
 ....#
 ...##
"""

let day10 = Day10()
day10.test1()


//: [Next](@next)
