import Foundation

let target = 42.0
let learningRate = 0.01

var weight = Double.random(in: -1.0...1.0)

for _ in 0...10000 {
    let inputValue = Double.random(in: 0.0...1.0)
    let prediction = weight * inputValue
    let error = target * inputValue - prediction
    weight += learningRate * inputValue * error
}

let testInput: Double = 2.0
let result = weight * testInput

print("Expected: \(target * testInput)")
print("Result: \(result)")
