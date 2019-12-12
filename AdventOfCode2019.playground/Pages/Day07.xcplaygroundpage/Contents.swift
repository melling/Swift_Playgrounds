//: [Previous](@previous)

/*
 Need a permutation function
 
 Must change my runProgram to take a list of inputs.
 
 https://www.reddit.com/r/adventofcode/comments/e7aou1/2019_day_7_part_2_help_comprehending_instruction/
 */


import UIKit
import PlaygroundSupport

let page = PlaygroundPage.current
//page.needsIndefiniteExecution = true

class Permutation {
    var allPerms:[[Int]] = []
    
    func permutations(_ n:Int, _ a: inout Array<Int>) {
        if n == 1 {
            //print(a)
            allPerms.append(a)
            return
            
        }
        for i in 0..<n-1 {
            permutations(n-1,&a)
            a.swapAt(n-1, (n%2 == 1) ? 0 : i)
        }
        permutations(n-1,&a)
    }
}


public class Util {
    
    class func pow(_ base:Int, _ power:Int) -> Int {
        if power == 0 {
            return 1
        } else if power == 1 {
            return base
        }
        
        let x = (2...power).reduce(base) {result, _ in result*base}
        return x
    }
    
    class func getDigit(number:Int, n:Int) -> Int {
        let p:Int = pow(10, n)
        let x = number / p % 10
        return x
    }
}


enum OpcodeEnum: Int {
    case add = 1
    case multiply = 2
    case input = 3
    case output = 4
    case jump_if_true = 5
    case jump_if_false = 6
    case lessThan = 7
    case equals = 8
    case halt = 99
    case unknown = 9999
}

let input = "3,225,1,225,6,6,1100,1,238,225,104,0,1101,65,73,225,1101,37,7,225,1101,42,58,225,1102,62,44,224,101,-2728,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,1,69,126,224,101,-92,224,224,4,224,1002,223,8,223,101,7,224,224,1,223,224,223,1102,41,84,225,1001,22,92,224,101,-150,224,224,4,224,102,8,223,223,101,3,224,224,1,224,223,223,1101,80,65,225,1101,32,13,224,101,-45,224,224,4,224,102,8,223,223,101,1,224,224,1,224,223,223,1101,21,18,225,1102,5,51,225,2,17,14,224,1001,224,-2701,224,4,224,1002,223,8,223,101,4,224,224,1,223,224,223,101,68,95,224,101,-148,224,224,4,224,1002,223,8,223,101,1,224,224,1,223,224,223,1102,12,22,225,102,58,173,224,1001,224,-696,224,4,224,1002,223,8,223,1001,224,6,224,1,223,224,223,1002,121,62,224,1001,224,-1302,224,4,224,1002,223,8,223,101,4,224,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1008,226,677,224,102,2,223,223,1005,224,329,1001,223,1,223,7,677,226,224,102,2,223,223,1006,224,344,1001,223,1,223,1007,226,677,224,1002,223,2,223,1006,224,359,1001,223,1,223,1007,677,677,224,102,2,223,223,1005,224,374,1001,223,1,223,108,677,677,224,102,2,223,223,1006,224,389,101,1,223,223,8,226,677,224,102,2,223,223,1005,224,404,101,1,223,223,7,226,677,224,1002,223,2,223,1005,224,419,101,1,223,223,8,677,226,224,1002,223,2,223,1005,224,434,101,1,223,223,107,677,677,224,1002,223,2,223,1006,224,449,101,1,223,223,7,677,677,224,1002,223,2,223,1006,224,464,101,1,223,223,1107,226,226,224,102,2,223,223,1006,224,479,1001,223,1,223,1007,226,226,224,102,2,223,223,1006,224,494,101,1,223,223,108,226,677,224,1002,223,2,223,1006,224,509,101,1,223,223,1108,226,677,224,102,2,223,223,1006,224,524,1001,223,1,223,1008,226,226,224,1002,223,2,223,1005,224,539,101,1,223,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,8,677,677,224,102,2,223,223,1005,224,569,101,1,223,223,107,226,677,224,102,2,223,223,1005,224,584,101,1,223,223,1108,226,226,224,1002,223,2,223,1005,224,599,1001,223,1,223,1008,677,677,224,1002,223,2,223,1005,224,614,101,1,223,223,1107,226,677,224,102,2,223,223,1005,224,629,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,677,226,224,1002,223,2,223,1006,224,659,1001,223,1,223,108,226,226,224,102,2,223,223,1006,224,674,101,1,223,223,4,223,99,226"




public class ComputerDay07 {
    
    public var opcodes:[Int] = []
    public var userInput:Int = 1
    public var lastOutput:Int = -999
    public var ip = 0
    public var cpuId = 0
    
    //public var _pc:Int = 0
    
    enum ParameterMode:Int {
        case position = 0
        case immediate = 1
    }
    
    public init() {}
    /*
     ABCDE
     1002
     
     DE - two-digit opcode,      02 == opcode 2
     C - mode of 1st parameter,  0 == position mode
     B - mode of 2nd parameter,  1 == immediate mode
     A - mode of 3rd parameter,  0 == position mode,
     omitted due to being a leading zero
     
     In position mode, parameters are addresses
     In immediate mode, parameters are values
     
     104
     opcode = 04
     parameter 1 = immediate
     */
    private func getParameter(mode:ParameterMode, instructionPointer:Int) -> Int {
        let value:Int
        
        switch mode {
        case .position:
            value = opcodes[opcodes[instructionPointer] ]
        case .immediate:
            value = opcodes[instructionPointer]
        }
        return value
        
    }
    
    
    // runProgram
    func processOpcodes(inputs:[Int]) -> (Int?, Int) {
        var opcode:Int
        var parameter1Mode:ParameterMode
        var parameter2Mode:ParameterMode
        var parameter3Mode:ParameterMode = .immediate
        var inputNum = 0
        
        var isRunning = true
        
        //var ip = instructionPointer
        
        while isRunning {
            
            print("cpu=\(cpuId),pc=\(ip)")
            //_pc = instructionPointer
            
            if ip >= opcodes.count {
                print("ERROR: cpu=\(cpuId), \(ip)")
                return (nil, ip)
                assertionFailure("ERROR: cpu=\(cpuId), ip=\(ip) > \(opcodes.count)")
                
            }
            let cmd = opcodes[ip]
            print("pc =\(ip), cmd=\(cmd)")
            assert(cmd < 10000, "Invalid cmd: \(cmd)" )
            //assert(cmd < 100 || cmd > 1000, "Invalid cmd: \(cmd)" )
            //if cmd < 100 || cmd > 1000 {
            
            //}
            if cmd > 100 {
                // immediate mode
                opcode = Util.getDigit(number: cmd, n: 1) * 10 + Util.getDigit(number: cmd, n: 0)
                parameter1Mode = Util.getDigit(number: cmd, n: 2) == 0 ? .position : .immediate
                parameter2Mode = Util.getDigit(number: cmd, n: 3) == 0 ? .position : .immediate
                
            } else {
                opcode = cmd
                parameter1Mode = .position
                parameter2Mode = .position
            }
            let opcodeEnum:OpcodeEnum = OpcodeEnum(rawValue: opcode) ?? OpcodeEnum.unknown
            
            switch opcode {
            case 1,2: // add, multiply
                
                let value1 = getParameter(mode: parameter1Mode, instructionPointer: ip + 1)
                let value2 = getParameter(mode: parameter2Mode, instructionPointer: ip + 2)
                
                let resultPtr = opcodes[ip + 3]
                
                let result:Int
                
                if opcode == 1 {
                    result = value1 + value2
                } else {
                    result = value1 * value2
                }
                opcodes[resultPtr] = result
                print("pc=\(ip),cmd=\(cmd) op=\(opcode) \(opcodeEnum) \(value1):\(parameter1Mode) \(value2):\(parameter2Mode) -> \(result) -> [\(ip + 3)] ")
                
                ip += 4
            case 3: // input
                /*
                 The program 3,0,4,0,99 outputs whatever it gets as input, then halts.
                 */
                
                let destPtr = opcodes[ip + 1]
                if inputNum < inputs.count {
                    opcodes[destPtr] = inputs[inputNum]
                    inputNum += 1
                    print("User Input: \(input) -> [\(destPtr)]")
                    
                } else {
                    print("Input out of range: \(inputNum) >= \(inputs.count)")
                }
                
                
                print("\(opcodes)")
                ip += 2
            case 4: // output
                
                //let output = opcodes[memoryPtr]
                let output = getParameter(mode: parameter1Mode, instructionPointer: ip + 1)
                
                // Only the last one should be nonzero: 14522484
                if output > 0 {
                    print("Bad output: \(output) @ \(ip) cmd=\(cmd), v=\(output)")
                    print("output=\(output)") // last output
                }
                print("output=\(output)")
                lastOutput = output
                ip += 2
                return (output, ip)
                /*
                 Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
                 */
            case 5: // jump-if-true
                let value1 = getParameter(mode: parameter1Mode, instructionPointer: ip + 1)
                let value2 = getParameter(mode: parameter2Mode, instructionPointer: ip + 2)
                if value1 > 0 {
                    ip = value2
                } else {
                    ip += 3
                }
                print("pc=\(ip),cmd=\(cmd) op=\(opcode) \(value1):\(parameter1Mode) > 0 ip=\(value2):\(parameter2Mode)")
                
                //let resultPtr = opcodes[instructionPointer + 3]
                /*
                 Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
                 */
            case 6: // jump-if-false
                let value1 = getParameter(mode: parameter1Mode, instructionPointer: ip + 1)
                let value2 = getParameter(mode: parameter2Mode, instructionPointer: ip + 2)
                if value1 == 0 {
                    ip = value2
                } else {
                    ip += 3
                    
                }
                print("pc=\(ip),cmd=\(cmd) op=\(opcode) \(opcodeEnum) \(value1):\(parameter1Mode) == 0 ip= \(value2):\(parameter2Mode)")
                
                /*
                 Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
                 */
            case 7: // less than
                let value1 = getParameter(mode: parameter1Mode, instructionPointer: ip + 1)
                let value2 = getParameter(mode: parameter2Mode, instructionPointer: ip + 2)
                let memPtr = getParameter(mode: parameter3Mode, instructionPointer: ip + 3)
                if value1 < value2 {
                    opcodes[memPtr] = 1
                } else {
                    opcodes[memPtr] = 0
                }
                print("pc=\(ip),cmd=\(cmd) op=\(opcode) \(opcodeEnum) \(value1):\(parameter1Mode) \(value2):\(parameter2Mode)")
                
                ip += 4
                
                /*
                 Opcode 8 is equals: if the first parameter is equal to the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
                 */
            case 8: // equals
                let value1 = getParameter(mode: parameter1Mode, instructionPointer: ip + 1)
                let value2 = getParameter(mode: parameter2Mode, instructionPointer: ip + 2)
                let memPtr = getParameter(mode: parameter3Mode, instructionPointer: ip + 3)
                
                let value = (value1 == value2) ? 1 : 0
                opcodes[memPtr] = value
                print("pc=\(ip),cmd=\(cmd) op=\(opcode) \(opcodeEnum) \(value1):\(parameter1Mode) == \(value2):\(parameter2Mode) [\(memPtr)] <- \(value)")
                print("\(opcodes)")
                
                ip += 4
                
            case 99: //halt
                print("halt")
                return (nil, ip)
                
            default:
                print("invalid cmd: \(cmd), \(opcode)")
                return (nil, 0)
            }
        }
    }
    
    
}

/*
 
 */


class Day07 {
    
    private func getOpcodes(str:String) -> [Int] {
        let s = str
        let opcodeList:[Int] = str.components(separatedBy:",").compactMap({Int($0)})
        print("# opcodes=\(opcodeList.count)")
        return opcodeList
    }
    
    private func loadOpcodes(fileName:String) -> [Int] {
        let opcodeList:[Int]
        
        let path = Bundle.main.url(forResource: fileName, withExtension: "txt")
        do {
            
            let text = try String(contentsOf: path!, encoding: .utf8)
            
            opcodeList = text.components(separatedBy:",").compactMap({Int($0)})
        } catch {
            
            print(error)
            opcodeList = []
            // Handle the error
        }
        return opcodeList
    }
    
    
}

// Day 05, Part 2

extension Day07 {
    
    // 3,9,8,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).
    
    public func testP2t1() {
        //
        
        let computer = ComputerDay07()
        let testCodes = [3,9,8,9,10,9,4,9,99,-1,8]
        
        computer.opcodes = testCodes
        computer.processOpcodes(inputs:[1])
        print("\(computer.opcodes)")
        print("\(computer.lastOutput)")
        //assert(computer.opcodes == [])
    }
    
    public func testP2t2() {
        //
        
        let computer = ComputerDay07()
        let testCodes = [3,9,8,9,10,9,4,9,99,-1,8]
        
        computer.opcodes = testCodes
        computer.processOpcodes(inputs: [1])
        print("\(computer.opcodes)")
        print("\(computer.lastOutput)")
        //assert(computer.opcodes == [])
    }
    
    
    public func testProgram(userInputs:[Int], opcodes:[Int]) -> Int {
        //
        print("\(opcodes)")
        
        let computer = ComputerDay07()
        computer.opcodes = opcodes
        //        computer.userInput = userInput
        let (output, ip) = computer.processOpcodes(inputs:userInputs)
        //print("\(computer._pc)")
        print("\(computer.opcodes)")
        print("\(computer.lastOutput)") // == 14522484,
        //assert()
        return computer.lastOutput
    }
    
}

/*
 Day 7 tests and solutions
 
 */
extension Day07 {
    
    func test_day07(phaseSettings:[Int], opcodes:[Int]) -> Int {
        //
        var answer = 0
        var value = 0
        for phase in phaseSettings {
            value = testProgram(userInputs: [phase, value], opcodes: opcodes)
            //value = day05_part1(userInput: v)
            if value > answer {
                answer = value
            }
        }
        return answer
    }
    
    func day07_part1() -> Int {
        
        let perms = Permutation()
        let opcodes = loadOpcodes(fileName: "input07")
        var arr = Array([0,1,2,3,4])
        perms.permutations(arr.count,&arr)
        print("\(perms.allPerms.count)")
        print(perms.allPerms)
        var answer = 0
        for phaseSettings in perms.allPerms {
            var value = 0
            for phase in phaseSettings {
                value = testProgram(userInputs:[phase, value], opcodes: opcodes)
                if value > answer {
                    answer = value
                }
            }
        }
        
        return answer
    }
}

// Part 2

extension Day07 {
    
    func part2_test_day07(phaseSettings:[Int], opcodes:[Int]) -> Int {
        //
        var cpuList:[ComputerDay07] = []
        for i in 1 ... 5 {
            let cpu = ComputerDay07()
            cpu.opcodes = opcodes
            cpu.cpuId = i
            cpuList.append(cpu)
        }
        
        var answer = 0
        var value:Int = 0
        var value0:Int? = nil
        var cpuNum = 0
        var ip1 = 0
        var isDone = false
        var isFirstPhase = true
        while !isDone {
            
        
        for phase in phaseSettings {
            var inputs:[Int] = []
            if isFirstPhase {
                inputs.append(phase)
            }
            inputs.append(value)
            let cpu = cpuList[cpuNum]
            print("cpu=\(cpuNum)")
            
            (value0, ip1) = cpu.processOpcodes(inputs: inputs)
            if value0 == nil {
                print("ans=\(answer)")
                return answer
            } else {
                value = value0!
                if value > answer {
                    answer = value
                    
                }
                cpuNum = (cpuNum + 1) % 5
            }
            
        }
            isFirstPhase = false
        }
        return answer
    }
    
    func day07_part2() -> Int {
        
        let perms = Permutation()
        let opcodes = loadOpcodes(fileName: "input07")
        opcodes.count
        var arr = Array([5,6,7,8,9])
        perms.permutations(arr.count,&arr)
        print("\(perms.allPerms.count)")
        print(perms.allPerms)
        var answer = 0
        var value = 0
        var val:Int? = nil
        
        var isDone = false
        
            
        // 22476942
        for phaseSetting in perms.allPerms {
            let result = part2_test_day07(phaseSettings: phaseSetting, opcodes: opcodes )
            if result > answer {
                answer = result
            }
            
        }
        print("ans=\(answer)")
        return answer
    }
}


// xx1 = Util.pow(10,3)
//let xx2 = Util.getDigit(number: 104, n: 3)
let day07 = Day07()

// 3,9,8,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).

//let t1 = day05.testProgram(userInput: 8, opcodes: [3,9,8,9,10,9,4,9,99,-1,8]) // input == 8 ==> 1 otherwise 0
//let t1_1 = day05.testProgram(userInput: 7, opcodes: [3,9,8,9,10,9,4,9,99,-1,8]) // input == 8 ==> 1 otherwise 0

//The program 3,0,4,0,99 outputs whatever it gets as input, then halts.
//let t2 = day05.testProgram(userInput: 42, opcodes: [3,0,4,0,99]) // 42

// 3,9,7,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).

//let t2 = day05.testProgram(userInput: 9, opcodes: [3,9,7,9,10,9,4,9,99,-1,8]) // input < 8 ==> 1 otherwise 0

//day05.day05_part1(input: 1)
func doPart1() {
    

// 3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0
    let t1 = day07.test_day07(phaseSettings: [ 4,3,2,1,0 ], opcodes: [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]) // 43210
    let t2 = day07.test_day07(phaseSettings: [ 0,1,2,3,4 ], opcodes:  [ 3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0 ] ) // 54321
    let t3 = day07.test_day07(phaseSettings: [ 1,0,4,3,2 ], opcodes: [ 3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0 ]) // 65210

    let result1 = day07.day07_part1() // 77500
}

func doPart2() {
    //let t1 = day07.part2_test_day07(phaseSettings: [ 9,8,7,6,5 ], opcodes: [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]) // 139629729
    //let t2 = day07.part2_test_day07(phaseSettings: [ 9,7,8,5,6 ], opcodes: [ 3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54, -5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10 ]) // 18216
    
    let result2 = day07.day07_part2()
    
}

// result2 = userInput: 5 => 4655956
//print("output=\(day05.lastOutput)")
//day05.testP2t1()
//doPart1()
doPart2()

print("Done")
//day05.day02_part1_2()

//: [Next](@next)
