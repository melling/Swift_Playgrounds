//: [Previous](@previous)

import Foundation


//: [Next](@next)



let day04 = Day04()
let t1 = day04.test(num: 111111) // true

let t2 = day04.test(num: 223450) // false
let t3 = day04.test(num: 123789) // false
let result1 = day04.part1()
print("result1=\(result1)") // 2090


let hist = [1,3,3,4,5].histogram()
hist.values.contains(2)
