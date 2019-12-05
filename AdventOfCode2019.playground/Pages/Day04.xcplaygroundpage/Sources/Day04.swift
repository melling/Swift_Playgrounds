import Foundation

/*
 https://stackoverflow.com/questions/28129401/determining-if-swift-dictionary-contains-key-and-obtaining-any-of-its-values/28129484
 */

public extension Array where Element: Hashable {
    func histogram() -> [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
}


public class Day04 {
    
    public init() {}

    public func test(num:Int) -> Bool {
        let str = String(num)
        let digits:[Int] = str.map(String.init).compactMap(Int.init)
        return testAllPredicates(digits: digits)
    }
    
    public func testAllPredicates(digits:[Int]) -> Bool {
        if digits.count != 6 {return false}
        
        
        let greaterEqualPred:[Bool] = digits.enumerated().map( { (index, elem) in
            let isGreater =  (index > 0) && (digits[index - 1]) <= elem ? true : false
            return isGreater
        })
        
        
        let allGreaterEqual = !greaterEqualPred.dropFirst().contains(false)
        if !allGreaterEqual {return false}

//        let twoSamePred:[Bool] = digits.enumerated().map( { (index, elem) in
//            let isSame =  (index > 0) && (digits[index - 1]) == elem ? true : false
//            return isSame
//        })
//        let isTwoEqual = twoSamePred.contains(true)
//        if !isTwoEqual {return false}
        
        let hist = digits.histogram()

        let containsTwo = hist.values.contains(2)

        return containsTwo
    }
    
    public func part0() -> Int {
        var cnt = 0
        for i in 130254 ... 678275 {
            if test(num: i) {
                cnt += 1
            }
        }
        return cnt
    }
    
    public func part1() -> Int {
        let n = (130254...678275).map(test).filter {$0}.count
//        let n = (130254...140260).map(test).filter {$0}.count
        return n
    }
}
