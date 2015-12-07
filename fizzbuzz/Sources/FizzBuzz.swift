enum Mod3And5: CustomStringConvertible {
    case Mod3
    case Mod5
    case Both
    case Neither(Int)

    var description: String {
        switch self {
        case Mod3:
            return "Fizz"
        case Mod5:
            return "Buzz"
        case Both:
            return "FizzBuzz"
        case Neither(let num):
            return String(num)
        }
    }
}
