import Foundation

struct Bit{
    private var value : Bool
    
    init(value : Int) {
        if value == 1{
            self.value = true
        }else{
            self.value = false
        }
    }
    
    public func toString() -> String {
        return value ? "1" : "0"
    }
}
