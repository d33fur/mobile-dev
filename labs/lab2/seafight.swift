// размер поля
let gridSize = 3

// структура координат
struct Coordinate: Equatable {
    let row: Int
    let col: Int
}

// создаем поля
var playerGrid = Array(repeating: Array(repeating: "-", count: gridSize), count: gridSize)
var computerGrid = Array(repeating: Array(repeating: "-", count: gridSize), count: gridSize)
var attackGrid = Array(repeating: Array(repeating: "-", count: gridSize), count: gridSize)

// расставляем случайно корабли
let playerShip = Coordinate(row: Int.random(in: 0..<gridSize), col: Int.random(in: 0..<gridSize))
let computerShip = Coordinate(row: Int.random(in: 0..<gridSize), col: Int.random(in: 0..<gridSize))

playerGrid[playerShip.row][playerShip.col] = "S"

// выводим поле
func printGrid(_ grid: [[String]]) {
    for row in grid {
        print(row.joined(separator: " "))
    }
}

// игра
var gameRunning = true
while gameRunning {
    print("Ваше поле:")
    printGrid(playerGrid)
    
    print("\nПоле атак:")
    printGrid(attackGrid)
    
    print("\nВведите координаты для атаки (например, 1 1): ", terminator: "")
    
    let input = readLine() ?? ""
    let parts = input.split(separator: " ")
    if parts.count == 2, let row = Int(parts[0]), let col = Int(parts[1]), row < gridSize, col < gridSize {
        let attack = Coordinate(row: row, col: col)
        
        if attackGrid[attack.row][attack.col] == "-" {
            if attack == computerShip {
                print("Вы потопили корабль компьютера!")
                attackGrid[attack.row][attack.col] = "X"
                gameRunning = false
            } else {
                print("Мимо!")
                attackGrid[attack.row][attack.col] = "O"
                computerGrid[attack.row][attack.col] = "O"
                
                let computerAttack = Coordinate(row: Int.random(in: 0..<gridSize), col: Int.random(in: 0..<gridSize))
                print("Компьютер атакует координаты: \(computerAttack.row) \(computerAttack.col)")
                
                if computerAttack == playerShip {
                    print("Ваш корабль потоплен!")
                    playerGrid[computerAttack.row][computerAttack.col] = "X"
                    attackGrid[computerShip.row][computerShip.col] = "C"
                    gameRunning = false
                } else {
                    print("Компьютер промахнулся!")
                    playerGrid[computerAttack.row][computerAttack.col] = "O"
                }
            }
        } else {
            print("Вы уже стреляли в эти координаты. Попробуйте снова.")
        }
    } else {
        print("Неверные координаты. Попробуйте снова.")
    }
}

print("Игра окончена.")

print("Ваше поле:")
printGrid(playerGrid)

print("\nПоле компьютера:")
printGrid(attackGrid)