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

switch (num % 3, num % 5) {
case (0,0):
    print(Mod3And5.Both)
case (0, _):
    print(Mod3And5.Mod3)
case (_, 0):
    print(Mod3And5.Mod5)
default:
    print(Mod3And5.Neither(num))
}
exit(0)
