//subtopic Closures: The Sorted Method -------------------------------------------------------------------------------------------------

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
  return s1 > s2
  //true - s1 - left, s2 - right
}
var reversedNames = names.sorted(by: backward) //сортирует массив по тому принципу, который в передаваемой функции

// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

//subtopic Closures: Closure Expression Syntax -----------------------------------------------------------------------------------------

{ (<#parameters#>) -> <#return type#> in
  <#statements#>
}

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
  return s1 > s2
}) //то же самое, что и до, только функция расписана внутри

//subtopic Closures: Inferring Type From Context ---------------------------------------------------------------------------------------

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })

//subtopic Closures: Shorthand Argument Names ------------------------------------------------------------------------------------------

reversedNames = names.sorted(by: { $0 > $1 } )
//$0 - 1st arg, $2 - 2nd arg

//subtopic Closures: Operator Methods --------------------------------------------------------------------------------------------------

reversedNames = names.sorted(by: >)

//subtopic Closures: Trailing Closures, Capturing Values -------------------------------------------------------------------------------

func makeIncrementer(forIncrement amount: Int) -> (String) /*тип аргументов внутри incrementer*/ -> Int {
  var runningTotal = 0
  func incrementer(text: String) -> Int {
    runningTotal += amount
    print(text)
    return runningTotal
  }
  return incrementer
}

let incrementByThree = makeIncrementer(forIncrement: 3) //стал равен функции makeIncrementer с увелич на 3,
//хранит в себе и переменную
print(incrementByThree("three ")) // так задается аргумент внутрь замык функ
print(incrementByThree("six ")) // возвр 6

/* print
three 
3
six 
6
*/

//subtopic Closures: Closures Are Reference Types --------------------------------------------------------------------------------------

//ссылочный тип, поэтому после присвоения другой переменной продолжает работать первоначальная
let alsoIncrementByThree = incrementByThree
alsoIncrementByThree()
// returns 12

alsoIncrementByThree()
// returns 15

//subtopic Closures: Escaping Closures -------------------------------------------------------------------------------------------------

var completionHandlers: [ () -> Void ] = []//хранит замык функцию из someFunctionWithEscapingClosure

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
  completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
  closure()
}

class SomeClass {
  var x = 10
  func doSomething() {
    someFunctionWithEscapingClosure { self.x += 100 }
    someFunctionWithNonescapingClosure {/*внутрянка функции someFunctionWithNonescapingClosure*/ x = 200 }
  }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "300"

completionHandlers.first?()
print(instance.x)
// Prints "400"

completionHandlers.first?()
print(instance.x)
// Prints "500"

//subtopic Closures: Autoclosures ------------------------------------------------------------------------------------------------------

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"


let customerProvider = { customersInLine.remove(at: 0) } //возвращает и удаляет первый элемент массива только в замыкании
print(customersInLine.count)
// Prints "5"


print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

func serve(customer customerProvider: () -> String) {
  print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

// customersInLine равен ["Ewa", "Barry", "Daniella"] автозамыкание меняет вызов функции
func serve(customer customerProvider: @autoclosure () -> String) {
  print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Выведет "Now serving Ewa!

//enum --------------------------------------------------------------

enum CompassPoint {
  case north
  case south
  case east
  case west
}

var directionToHead = CompassPoint.west


directionToHead = .south
switch directionToHead {
case .north:
  print("Lots of planets have a north")
case .south:
  print("Watch out for penguins")
case .east:
  print("Where the sun rises")
case .west:
  print("Where the skies are blue")
}
// "Watch out for penguins"

enum Beverage: CaseIterable {
  case coffee, tea, juice
}
// allCases передает все случаи enum
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"

for beverage in Beverage.allCases {
  print(beverage)
}
// coffee
// tea
// juice

enum Barcode {
  case upc(Int, Int, Int, Int)
  case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)

var productBarcode1 = .qrCode("ABCDEFGHIJKLMNOP")


switch productBarcode {
  case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
  case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// последнее присваивалось .qrCode "QR code: ABCDEFGHIJKLMNOP."

enum ErrorCode: Int {
  case invalidInput = 1
  case fileNotFound = 2
  case networkError = 3
}

enum Planet: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPoint: String {
  case north, south, east, west
}

let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"

var test: String = "north"
let northTest = CompassPoint.north

let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet = Planet.uranus

//индирект нужен, чтобы в аргументах использовать сам енум
indirect enum ArithmeticExpression {
  case number(Int)
  case addition(ArithmeticExpression, ArithmeticExpression)
  case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
  
  switch expression {
  case let .number(value):
    return value
  case let .addition(left, right):
    return evaluate(left) + evaluate(right)
  case let .multiplication(left, right):
    return evaluate(left) * evaluate(right)
  }
}


print(evaluate(sum)) // "9"


enum Color {
  case red
  case green
  case blue

  var rgb: (Int, Int, Int) {
    switch self {
    case .red:
      return (255, 0, 0)
    case .green:
      return (0, 255, 0)
    case .blue:
      return (0, 0, 255)
    }
  }
}

let redColor = Color.red
let rgbValue = redColor.rgb
print(rgbValue) // (255, 0, 0)



//функции --------------------------------------------------------------

func greet(person: String) -> String {
  let greeting = "Hello, " + person + "!"
  return greeting
}

func greetAgain(person: String) -> String {
  return "Hello again, " + person + "!"
}

print(greet(person: "Bob"))
// "Hello, Bob!"
print(greetAgain(person: "Bib"))
// "Hello again, Bib!"

//subtopic functions: Function parameters and return values ----------------------------------------------------------------------------

func sayHelloWorld() -> String {
  return "hello, world"
}
print(sayHelloWorld())
// "hello, world"

//subtopic functions: Functions With Multiple Parameters -------------------------------------------------------------------------------

func greet(person: String, alreadyGreeted: Bool) -> String {
  if alreadyGreeted {
    return greetAgain(person: person)
  } else {
    return greet(person: person)
  }
}
print(greet(person: "Bob", alreadyGreeted: true))
// "Hello again, Bob!"

//subtopic functions: Functions Without Return Values ----------------------------------------------------------------------------------

func greet(person: String) {
  print("Hello, \(person)!")
}
greet(person: "Bob")
// "Hello, Bob!"

func printAndCount(string: String) -> Int {
  print(string)
  return string.count
}
func printWithoutCounting(string: String) {
  let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// "hello, world" without num

//subtopic functions: Functions with Multiple Return Values ----------------------------------------------------------------------------

//может быть пара разных типов
//если одного из пары нет - ошибки не будет
//? может ничего не возвращать
func minMax(array: [Int]) -> (min: Int, phrase: String)? {
  var currentMin = array[0]
  var phrase = ""; 
  for value in array[1..<array.count] {
    if value < 0 {
      currentMin = value
    } else if value > 0 {
      phrase = "no";
    }
  }
  return (currentMin, phrase)
}

let ans = minMax(array: [1,2,3,-4])

print(ans.phrase);

//subtopic functions: Functions With an Implicit Return --------------------------------------------------------------------------------

//просит внутрь строку, если засунуть инт внутрь
func greeting(for person: String) -> String {
  let num = 5
  "Hello, " + person + "!" //чтобы возвращало, кроме этой строчки ничего не должно быть
}
print(greeting(for: "Bob"))
print(greeting(person: "Bob")) //выдаст ошибку, просит for

//subtopic functions: Specifying Argument Labels ---------------------------------------------------------------------------------------

func greet(person: String, from hometown: String) -> String {
  return "Hello \(person)!  Glad you could visit from \(hometown)." //уже можно вставлять числа
}
print(greet(person: "Bob", from: "Cupertino"))
// "Hello Bob!  Glad you could visit from Cupertino."

//subtopic functions: Omitting Argument Labels -----------------------------------------------------------------------------------------

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
  // In the function body, firstParameterName and secondParameterName
  // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)

func someFunction(_ firstParameterName: Int, _ secondParameterName: Int) {
  // In the function body, firstParameterName and secondParameterName
  // refer to the argument values for the first and second parameters.
}
someFunction(1, 2)

//subtopic functions: Default Parameter Values -----------------------------------------------------------------------------------------

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
  // If you omit the second argument when calling this function, then
  // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6)
someFunction(parameterWithoutDefault: 4) //без первого ошибка

//subtopic functions: Variadic Parameters-----------------------------------------------------------------------------------------------

//вариативный параметр может иметь несколько/ни одного значений
func arithmeticMean(_ numbers: Double...) -> Double {
  var total: Double = 0
  for number in numbers {
    total += number
  }
  return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0
arithmeticMean()
// returns non

//subtopic functions: In-Out Parameters ------------------------------------------------------------------------------------------------
//ссылка, работает только с переменными

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// "someInt is now 107, and anotherInt is now 3"

//subtopic functions: Using Function Types ---------------------------------------------------------------------------------------------

func addTwoInts(_ a: Int, _ b: Int) -> Int {
  return a + b
}

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")
// "Result: 5

//subtopic functions: Function Types as Parameter Types --------------------------------------------------------------------------------

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
  print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// "Result: 8"

//subtopic functions: Function Types as Return Types -----------------------------------------------------------------------------------


func stepForward(_ input: Int) -> Int {
  return input + 1
}
func stepBackward(_ input: Int) -> Int {
  return input - 1
}

//(int) - тип аргументов замык функции
func chooseStepFunction(backward: Bool) -> (Int) -> Int { 
  return backward ? stepBackward : stepForward //присвоить переменной нельзя
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// first 3 iter calls stepBackward

//subtopic functions: Nested Functions -------------------------------------------------------------------------------------------------

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
  func stepForward(input: Int) -> Int { 
    return input + 1 
  }
  func stepBackward(input: Int) -> Int { 
    return input - 1 
  }
  return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function


//структуры и классы --------------------------------------------------------------

struct Resolution {
  var width = 0
  var height = 0
}

class VideoMode {
  var resolution = Resolution()
  var interlaced = false
  var frameRate = 0.0
  var name: String?
}

//subtopic Structures and Classes: Structure and Class Instances -----------------------------------------------------------------------

//экземпляры
let someResolution = Resolution()
let someVideoMode = VideoMode()

//subtopic Structures and Classes: Accessing Properties --------------------------------------------------------------------------------

print("The width of someResolution is \(someResolution.width)")
// "The width of someResolution is 0"
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// "The width of someVideoMode is 0"

someVideoMode.resolution.width = 1280
print("The new width \(someVideoMode.resolution.width)")
// "The new width 1280"

//subtopic Structures and Classes: Memberwise Initializers for Structure Types ---------------------------------------------------------

let vga = Resolution(width: 640, height: 480)

//class instance init

class Person {
  var name: String
  var age: Int

  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

let person = Person(name: "John", age: 30)

//subtopic Structures and Classes: Structures and Enumerations Are Value Types ---------------------------------------------------------

let hd = Resolution(width: 1920, height: 1080)
//не ссылочный тип
var cinema = hd

cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
// "cinema is now 2048 pixels wide"

print("hd is still \(hd.width) pixels wide")
// "hd is still 1920 pixels wide"

//subtopic Structures and Classes: Classes Are Reference Types -------------------------------------------------------------------------

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0 //тип ссылочный -> меняется исходник (tenEighty)

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"

//subtopic Structures and Classes: Identity Operators ----------------------------------------------------------------------------------

if tenEighty === alsoTenEighty { //так можно проверять на один ли экземпляр класса ссылаются переменные
  print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."