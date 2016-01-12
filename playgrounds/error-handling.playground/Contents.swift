// Error handling

import UIKit

let users = [[
  "name": "Andrew",
  "age": 26,
  "address": [
    "street": "340 N 12th St"
  ]
], [
  "name": "Adam",
  "address": [
    "street": "1000 Market St",
    "city": "Philadelphia"
  ]
]]

class User {
  var name: String = ""
  var age: Int = 0
  var address:[String: String]
  init(name: String, age: Int, address:[String: String]) {
    self.name = name
    self.age = age
    self.address = address
  }
}

for user in users {
  // Downcasting
  if let name = user["name"] as? String,
     let age = user["age"] as? Int,
     let address = user["address"] as? [String:String] {
    let u = User(name: name, age: age, address: address)
  } else {
    print("Unable to create User")
  }
}

// Vending machine example error handling

enum VendingMachineError: ErrorType {
  case InvalidSelection
  case InsufficientFunds(coinsNeeded: Int)
  case OutOfStock
}

struct Item {
  var price: Int
  var count: Int
}

class VendingMachine {
  var inventory = [
    "Candy Bar": Item(price: 12, count: 7),
    "Chips": Item(price: 10, count: 4),
    "Pretzels": Item(price: 7, count: 11)
  ]
  var coinsDeposited = 0
  func dispenseSnack(snack: String) {
    print("Dispensing \(snack)")
  }
  
  func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
      throw VendingMachineError.InvalidSelection
    }
    
    guard item.count > 0 else {
      throw VendingMachineError.OutOfStock
    }
    
    guard item.price <= coinsDeposited else {
      throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
    }
    
    coinsDeposited -= item.price

    --item.count
    inventory[name] = item
    dispenseSnack(name)
  }
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 10
do {
  try vendingMachine.vend(itemNamed: "Chips")
  vendingMachine.coinsDeposited = 8
  vendingMachine.vend(itemNamed: "Chips")
  //try vendingMachine.vend(itemNamed: "Chips")
  try vendingMachine.vend(itemNamed: "Snickers")
} catch VendingMachineError.InvalidSelection {
  print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
  print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
  print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
