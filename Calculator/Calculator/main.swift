//
//  main.swift
//  Calculator
//
import Foundation

var postInput: [String] = [""]
var operators = ["+","-","*","/"]
var otherInput = ""

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
  switch opString {
  case "+":
    return {x, y in x + y }
  case "-":
    return {x, y in x - y }
  case "*":
    return {x, y in x * y }
  case "/":
    return {x, y in x / y }
  default:
    return {x, y in x + y }
  }
}
func regOrHigh (_ input: String){
if input == "1" {
   calculatorInput()
} else if input == "2" {
    highFunctionInput(readLine() ?? "-1")
} else {
    print("Please choose a valid method of calculation. ")
    regOrHigh(readLine() ?? "-1")
}
}

func calculatorInput () {
    print("Enter your operation, e.g. 2 + 3")
let userInput = readLine() ?? "-1"
postInput = userInput.components(separatedBy: " ")
otherInput = postInput[1]
    calculation()
}
func calculation () {
    if postInput[1] == "?" {
        postInput[1] = operators.randomElement() ?? "+"
    }
    let closureOperation = mathStuffFactory(opString: postInput[1])
    let result = closureOperation(Double(postInput[0]) ?? 0.0,Double(postInput[2]) ?? 0.0)
if operators.contains(postInput[1]) {
print("result of operation is  \(result)")
    if otherInput == "?" {
        randomOperator()
    } else {
    calculatorInput()
    }
} else {
    print("Unknown operator: \(postInput[1])")
    calculatorInput()
}
    
}

func randomOperator () {
    print("Can you guess what operator was used?")
    let operatorGuess = readLine() ?? "+"
    if operatorGuess == postInput[1] {
        print("Correct!")
        calculatorInput()
    } else {
        print("Incorrect!")
        calculation()
    }
}

func customMap(_ arr:[Int],_ closure: (Int) -> Int) -> [Int] {
    var transformedArr = [Int]()
    for num in arr {
        transformedArr.append(closure(num))
    }
return transformedArr
}

func customFilter(_ arr: [Int],_ closure:(Int) -> Bool) -> [Int]{
    var filteredArr = [Int]()
    for num in arr {
        if closure(num){
            filteredArr.append(num)
        }
    }
    return filteredArr
}
func customReduce(_ arr: [Int], _ input: Int, _ closure:(Int, Int) -> Int) -> Int{
    var reducedNum = input
    for num in arr {
        reducedNum =  closure(reducedNum, num)
    }
    return reducedNum
}

func highFunctionInput(_ input: String) {
    let highFuncInputComponents = input.components(separatedBy: " ")
    let arrayComponents = highFuncInputComponents[1].components(separatedBy: ",")
    let arrayComponentsInt = arrayComponents.map {Int($0) ?? 0}
    let highInteger = Int(highFuncInputComponents[4])
    switch true {
    case highFuncInputComponents[0] == "map":
        switch true {
        case highFuncInputComponents[3] == "*" :
            for num in customMap((arrayComponentsInt), {$0 * (highInteger ?? 0)}) {
                print(num, terminator:",") }
        case highFuncInputComponents[3] == "/":
            for num in customMap((arrayComponentsInt), {$0 / (highInteger ?? 0)}) {
                print(num, terminator:",") }
        default:
        print("Not valid operator")
        }
    case highFuncInputComponents[0] == "filter":
        switch true {
        case highFuncInputComponents[3] == "<" :
            for num in customFilter((arrayComponentsInt), {$0 < (highInteger ?? 0)}) {
                print(num, terminator:",") }
        case highFuncInputComponents[3] == ">":
            for num in customFilter((arrayComponentsInt), {$0 > (highInteger ?? 0)}) {
                print(num, terminator:",") }
        default:
            print("Not valid operator")
        }
    case highFuncInputComponents[0] == "reduce":
        switch true {
        case highFuncInputComponents[3] == "+" :
            print(customReduce(arrayComponentsInt, highInteger ?? 0, { $0 + $1 }))
        case highFuncInputComponents[3] == "*":
            print(customReduce(arrayComponentsInt, highInteger ?? 0, { $0 * $1 }))
        default:
            print("Not valid operator")
        }
    default:
        print("Not valid")
    }
    highFunctionInput(readLine() ?? "-1")
    }
    


print("Welcome to my calculator!")
print("Are you performing a regular (1) or high order (2) calculation?")
regOrHigh (readLine() ?? "-1")
 //waiting for tonight
