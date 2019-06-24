enum FlightType{
    case Economic
    case Standart
    case Business
}

protocol Flight{
    func calculateFlightCost() -> Double
    func getBaggageAllowance() -> Double
    func getFlightType() -> FlightType
}

// Decorator

// Core Component
final class StandartPassanger: Flight{
    
    private let baggageAllowance: Double = 10 //KG
    private let standartCost: Double = 100 // Dolar
    private let flightType: FlightType = .Standart
    
    func calculateFlightCost() -> Double {
        return standartCost
    }
    
    func getBaggageAllowance() -> Double {
        return baggageAllowance
    }
    
    func getFlightType() -> FlightType {
        return flightType
    }
    
}

class EcomoicPassanger: Flight{
   
    private let flight: Flight
    
    init(flight: Flight){
        self.flight = flight
    }
    
    func calculateFlightCost() -> Double {
        return flight.calculateFlightCost()/2
    }
    
    func getBaggageAllowance() -> Double {
        return flight.getBaggageAllowance()*0
    }
    
    func getFlightType() -> FlightType {
        return .Economic
    }
}

class BusinessPassanger: Flight{
    
    private let flight: Flight
    
    init(flight: Flight){
        self.flight = flight
    }
    
    func calculateFlightCost() -> Double {
        return flight.calculateFlightCost()*4
    }
    
    func getBaggageAllowance() -> Double {
        return flight.getBaggageAllowance() + 50
    }
    
    func getFlightType() -> FlightType {
        return .Business
    }
    
}

/////

//Adapter

struct Passanger{
    var name:String
    var flight:Flight
}

class PassangerAdapter{
    
    private var flight: Flight
    private var name:String
    
    init(name:String, flight: Flight) {
        self.flight = flight
        self.name = name
    }
    
    func canBuyExtraBaggage() -> Bool{
        
        if flight is StandartPassanger{
            if flight.getBaggageAllowance() > 50{
                return false
            }else{
                return true
            }
        }
        
        if flight is EcomoicPassanger{
            return false
        }
        
        if flight is BusinessPassanger{
            if flight.getBaggageAllowance() > 100{
                return false
            }else{
                return true
            }
        }
        
        return false
    }
    
}

///


//Factory

struct FlightFactory{
    static func calculateExtraBaggageCost(flight: Flight, extraBaggage: Double) -> Double{
        switch flight.getFlightType() {
        case .Standart:
            return (flight.getBaggageAllowance() + extraBaggage*2)*10
        case .Economic:
            return (flight.getBaggageAllowance() + extraBaggage*1)*5
        case .Business:
            return (flight.getBaggageAllowance() + extraBaggage*3)*15
        }
    }
}


///


//Decorator
let standartPassanger = StandartPassanger()
let economicPassanger = EcomoicPassanger(flight: standartPassanger)
// Double Decorators
let businessPassanger = BusinessPassanger(flight: economicPassanger)

var passangers = [Flight]()
passangers.append(standartPassanger)
passangers.append(economicPassanger)
passangers.append(businessPassanger)

for passanger in passangers{
    print("flight:\(passanger.getFlightType())")
    print("cost: \(passanger.calculateFlightCost())")
    print("baggage: \(passanger.getBaggageAllowance())\n")
}


var adapter = PassangerAdapter(name: "Okan Yücel", flight: standartPassanger)
print(adapter.canBuyExtraBaggage())

var factory = FlightFactory.calculateExtraBaggageCost(flight: standartPassanger, extraBaggage: 10)
print(factory)
