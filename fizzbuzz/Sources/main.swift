import Glibc

// Check number of arguments
guard Process.arguments.count == 2 else {
    print("Usage: fizzbuzz NUM")
    exit(1)
}

// Convert String to Integer
guard let num = Int(Process.arguments[1]) else {
    print("Couldn't convert \(Process.arguments[1]) to an integer")
    exit(1)
}

let fb: Mod3And5 = { () -> Mod3And5 in
    switch (num % 3, num % 5) {
    case (0,0):
        return Mod3And5.Both
    case (0, _):
        return Mod3And5.Mod3
    case (_, 0):
        return Mod3And5.Mod5
    default:
        return Mod3And5.Neither(num)
    }
}()
print(fb)
exit(0)
