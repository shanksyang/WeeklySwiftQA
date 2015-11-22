import Foundation

//issue #1

protocol Named {
    var name: String { get }
}

struct Person: Named {
    let name: String
    var age: Int
}

func printNames(objects: [Named]) {
    for object in objects {
        print(object.name)
    }
}

let person1 = Person(name: "Alice", age: 30)
let person2 = Person(name: "Bob", age: 40)
let persons: [Named] = [person1, person2]

printNames([person1]) // Works
printNames([person1, person2]) // Works
printNames(persons) // Error: Cannot convert value of type '[Person]' to expected argument type '[Named]'
persons as? [Named] // Error: 'Named' is not a subtype of 'Person'


// issue #2
let myVariable : String? = "my name"

var myNameVariable = myVariable!

//myNameVariable = nil //Error

var implUnwrapVar:String! = myVariable

implUnwrapVar = nil//OK



let myVariable1 : String? = nil

//var myNameVariable1 = myVariable1! //error
var implUnwrapVar1:String! = myVariable1 // ok



//issue #3

class Singleton {
    class var sharedInstance: Singleton {
        struct Static {
            static let instance: Singleton = Singleton()
        }
        return Static.instance
    }
}

class Singleton1  {
    static let sharedInstance = Singleton1()
}

class Singleton3 {
    class var sharedInstance: Singleton3 {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Singleton3? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Singleton3()
        }
        return Static.instance!
    }
}


