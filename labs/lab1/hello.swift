enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

func compareRanks(_ l: Rank, _ r: Rank) -> Bool {
    return l.rawValue < r.rawValue
}


let ace = Rank.ace
let aceRawValue = ace.rawValue

print(ace)
print(aceRawValue)

let two = Rank.two

print(compareRanks(ace, two))



enum Suit {
  case spades, hearts, diamonds, clubs
  func simpleDescription() -> String {
    switch self {
    case .spades:
      return "spades"
    case .hearts:
      return "hearts"
    case .diamonds:
      return "diamonds"
    case .clubs:
      return "clubs"
    }
  }
  func color() -> String {
    switch self {
    case .spades:
      return "black"
    case .hearts:
      return "red"
    case .diamonds:
      return "red"
    case .clubs:
      return "black"
    }
  }
}

let hearts = Suit.hearts

print(hearts.simpleDescription())
print(hearts.color())



enum ServerResponse {
    case result(String, String)
    case failure(String)
    case success(String)
}
 
let result = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")
let success = ServerResponse.success("Cool!")
 
switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
case let .success(message):
    print("Success...  \(message)")
}
