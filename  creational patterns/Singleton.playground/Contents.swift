/*
 The Singleton Pattern
 
 The Singleton design pattern ensures that only one instance exists for a given class and that there’s a global access point to that instance. It usually uses lazy loading to create the single instance when it’s needed the first time.
 
 You’re likely wondering why you care if there’s more than one instance of a class floating around. Code and memory is cheap, right?
 
 There are some cases in which it makes sense to have exactly one instance of a class. For example, there’s only one instance of your application and one main screen for the device, so you only want one instance of each. Or, take a global configuration handler class: it’s easier to implement a thread-safe access to a single shared resource, such as a configuration file, than to have many class modifying the configuration file possibly at the same time.
 */


import UIKit
import PlaygroundSupport

final class FriendsAPI {
    
    // The shared static constant approach gives other objects access to the singleton object FriendsAPI.
    static let shared = FriendsAPI()
    private let persistencyManager = PersistencyManager()

    // The private initializer prevents creating new instances of FriendsAPI from outside.
    private init() {
        
    }
    
    func getFriends() -> [Person] {
        return persistencyManager.getFriends()
    }
    
    func addFriend(_ friend: Person) {
        persistencyManager.addFriend(friend)
    }
    
    func deleteFriend(at index: Int) {
        persistencyManager.deleteFriend(at: index)
    }
    
}

//DUMMY DATA

final class PersistencyManager {
    private var friends = [Person]()
    
    init() {
        //Dummy list of friends
        let friend1 = Person(name: "Okan",
                           surname: "Yücel",
                           genre: "Male",
                           age: 24)
        
        let friend2 = Person(name: "Uğur",
                             surname: "Özışık",
                             genre: "Male",
                             age: 24)
        
        let friend3 = Person(name: "Ali",
                             surname: "Yüce",
                             genre: "Male",
                             age: 24)
        
        friends = [friend1, friend2, friend3]
    }
    
    func getFriends() -> [Person] {
        return friends
    }
    
    func addFriend(_ friend: Person) {
        friends.append(friend)
    }
    
    func deleteFriend(at index: Int) {
        friends.remove(at: index)
    }
    
}

//MODEL

struct Person {
    let name : String
    let surname : String
    let genre : String
    let age : Int
}

extension Person: CustomStringConvertible {
    var description: String {
        return "\nname: \(name)" +
            " surname: \(surname)" +
            " genre: \(genre)" +
            " age: \(age)"
    }
}

print(FriendsAPI.shared.getFriends().description)

let newPerson = Person.init(name: "Burak", surname: "Inner", genre: "Male", age: 39)
FriendsAPI.shared.addFriend(newPerson)
print(FriendsAPI.shared.getFriends().description)

FriendsAPI.shared.deleteFriend(at: 0)
print(FriendsAPI.shared.getFriends().description)

PlaygroundPage.current.needsIndefiniteExecution = true

let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
    let newPerson = Person.init(name: "Burak", surname: "Inner", genre: "Male", age: 39)
    FriendsAPI.shared.addFriend(newPerson)
    print(FriendsAPI.shared.getFriends().description)
}

let timer1 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
    let newPerson = Person.init(name: "Okan", surname: "Yücel", genre: "Male", age: 39)
    FriendsAPI.shared.addFriend(newPerson)
    print(FriendsAPI.shared.getFriends().description)
}
    

    

    




