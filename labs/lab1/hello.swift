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