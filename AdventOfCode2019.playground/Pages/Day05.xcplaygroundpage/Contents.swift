

import UIKit
import PlaygroundSupport

let page = PlaygroundPage.current
//page.needsIndefiniteExecution = true

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




public class ComputerDay05 {
    
    public var opcodes:[Int] = []
    public var userInput:Int = 1
    public var lastOutput:Int = -999
    
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
    func processOpcodes(input:Int, _ instructionPointer:Int) {
        var opcode:Int
        var parameter1Mode:ParameterMode
        var parameter2Mode:ParameterMode
        var parameter3Mode:ParameterMode = .immediate

        var isRunning = true
        
        var ip = instructionPointer
        
        while isRunning {
            
            print("pc=\(ip)")
            //_pc = instructionPointer
            
            if ip >= opcodes.count {
                print("ERROR: \(ip)")
                assertionFailure("ERROR: \(ip) > \(opcodes.count)")
                
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
                opcodes[destPtr] = input
                print("User Input: \(input) -> [\(destPtr)]")

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
                return
                
            default:
                print("invalid cmd: \(cmd), \(opcode)")
                return
            }
        }
    }
    
    public func day02_1(noun:Int, verb:Int) -> Int {
        
        opcodes[1] = noun
        opcodes[2] = verb
        
        processOpcodes(input:1, 0)
        //        print("\(opcodes)")
        return opcodes[0]
    }
    
}
//var opcodes = [1,0,0,3,99]

/*
 
 */


class Day05 {
    
    private func getOpcodes(str:String) -> [Int] {
        let s = str
        let opcodeList:[Int] = str.components(separatedBy:",").compactMap({Int($0)})
        print("# opcodes=\(opcodeList.count)")
        return opcodeList
    }
    
    private func loadOpcodes() -> [Int] {
        let opcodeList:[Int]
        
        let path = Bundle.main.url(forResource: "input02", withExtension: "txt")
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
    
    //replace position 1 with the value 12 and replace position 2 with the value 2.
    
    
    private func validate(noun:Int, verb:Int) -> Int {100 * noun + verb}
    
    private func findNounAndVerb(opcodes:[Int], result:Int) -> (Int,Int){
        //
        let computer = ComputerDay05()
        
        computer.opcodes = opcodes
        
        for noun in 0 ... 99 {
            //        print("noun=\(noun)")
            for verb in 0 ... 99 {
                computer.opcodes = opcodes
                let result1 = computer.day02_1(noun: noun, verb: verb)
                if result == result1 {
                    return (noun, verb)
                }
            }
        }
        return (-1, -1)
    }
    

    /*
     The program 3,0,4,0,99 outputs whatever it gets as input, then halts.
     */
    public func test1() {
        //
        //let opcodes = getOpcodes(str: "input")
        let computer = ComputerDay05()
        let testCodes1 = [3,0,4,0,99]
        //opcodes = loadOpcodes()
        computer.opcodes = testCodes1
        computer.processOpcodes(input: 1, 0)
        print("\(computer.opcodes)")
        assert(computer.opcodes == [1,0,4,0,99])
    }
    
    public func test2() {
        //
        
        let computer = ComputerDay05()
        let testCodes1 = [1002,4,3,4,33]
        //opcodes = loadOpcodes()
        computer.opcodes = testCodes1
        computer.processOpcodes(input:1, 0)
        print("\(computer.opcodes)")
        assert(computer.opcodes == [1002,4,3,4,99])
    }
    
    public func day05_part1(userInput:Int) -> Int {
        //
        let opcodes = getOpcodes(str: input)
        
        let computer = ComputerDay05()
        //let testCodes1 = [3,0,4,0,99]
        //opcodes = loadOpcodes()
        computer.opcodes = opcodes
        computer.userInput = userInput
        computer.processOpcodes(input:userInput, 0)
        //print("\(computer._pc)")
        print("\(computer.opcodes)")
        print("\(computer.lastOutput)") // == 14522484,
        return computer.lastOutput
    }
    
    public func day02_part1_2() {
        var opcodes:[Int] = []
        //opcodes = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,5,23,1,23,9,27,2,27,6,31,1,31,6,35,2,35,9,39,1,6,39,43,2,10,43,47,1,47,9,51,1,51,6,55,1,55,6,59,2,59,10,63,1,6,63,67,2,6,67,71,1,71,5,75,2,13,75,79,1,10,79,83,1,5,83,87,2,87,10,91,1,5,91,95,2,95,6,99,1,99,6,103,2,103,6,107,2,107,9,111,1,111,5,115,1,115,6,119,2,6,119,123,1,5,123,127,1,127,13,131,1,2,131,135,1,135,10,0,99,2,14,0,0]
        //var opcodes = [1,9,10,3,2,3,11,0,99,30,40,50]
        
        let computer = ComputerDay05()
        opcodes = loadOpcodes()
        computer.opcodes = opcodes
        
        // 4945026
        let result1 = computer.day02_1(noun: 12, verb: 2)
        let validate1 = validate(noun: 12, verb: 2)
        // Part 2
        let (noun, verb) = findNounAndVerb(opcodes: opcodes, result: 19690720 )
        // 19690720
        let validate2 = validate(noun: noun, verb: verb)
        print("\(noun), \(verb) => \(validate2)")
    }
}

// Day 05, Part 2

extension Day05 {
    
    // 3,9,8,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).
    
    public func testP2t1() {
        //
        
        let computer = ComputerDay05()
        let testCodes = [3,9,8,9,10,9,4,9,99,-1,8]
        
        computer.opcodes = testCodes
        computer.processOpcodes(input:1, 0)
        print("\(computer.opcodes)")
        print("\(computer.lastOutput)")
        //assert(computer.opcodes == [])
    }
    
    public func testP2t2() {
        //
        
        let computer = ComputerDay05()
        let testCodes = [3,9,8,9,10,9,4,9,99,-1,8]
        
        computer.opcodes = testCodes
        computer.processOpcodes(input: 1, 0)
        print("\(computer.opcodes)")
        print("\(computer.lastOutput)")
        //assert(computer.opcodes == [])
    }
 
    public func testProgram(userInput:Int, opcodes:[Int]) -> Int {
        //
        print("\(opcodes)")

        let computer = ComputerDay05()
        computer.opcodes = opcodes
//        computer.userInput = userInput
        computer.processOpcodes(input:userInput, 0)
        //print("\(computer._pc)")
        print("\(computer.opcodes)")
        print("\(computer.lastOutput)") // == 14522484,
        return computer.lastOutput
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
// xx1 = Util.pow(10,3)
//let xx2 = Util.getDigit(number: 104, n: 3)
let day05 = Day05()

// 3,9,8,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).

//let t1 = day05.testProgram(userInput: 8, opcodes: [3,9,8,9,10,9,4,9,99,-1,8]) // input == 8 ==> 1 otherwise 0
//let t1_1 = day05.testProgram(userInput: 7, opcodes: [3,9,8,9,10,9,4,9,99,-1,8]) // input == 8 ==> 1 otherwise 0

//The program 3,0,4,0,99 outputs whatever it gets as input, then halts.
//let t2 = day05.testProgram(userInput: 42, opcodes: [3,0,4,0,99]) // 42

// 3,9,7,9,10,9,4,9,99,-1,8 - Using position mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).

//let t2 = day05.testProgram(userInput: 9, opcodes: [3,9,7,9,10,9,4,9,99,-1,8]) // input < 8 ==> 1 otherwise 0

//day05.day05_part1(input: 1)
let result2 = day05.day05_part1(userInput: 5) // 14522484
// result2 = userInput: 5 => 4655956
//print("output=\(day05.lastOutput)")
//day05.testP2t1()

print("Done")
//day05.day02_part1_2()
