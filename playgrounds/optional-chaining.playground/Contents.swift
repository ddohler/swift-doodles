// Demonstrate optional chaining and force unwrap
import UIKit

class Person {
  var residence: Residence?
}

class Residence {
  var numberOfRooms:Int = 1
  var garage:[Car]?
}

class Car {
  var color: String = ""
}

var fink = Person()

if let rooms = fink.residence?.numberOfRooms {
    print("Fink house has \(rooms) rooms")
} else {
    print("Fink has no home")
}

if let firstCarColor = fink.residence?.garage?.first?.color {
    print("Fink's car is \(firstCarColor)")
}

// let house = fink.residence!

fink.residence = Residence()
fink.residence?.numberOfRooms = 3
// let rooms = fink.residence?.numberOfRooms
// print("\(rooms)")
