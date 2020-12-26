import Foundation

struct Byte{
    private var value : [Bit]
    
    init(value : String) {
        self.value = Array(repeating: Bit(value: 0), count: 8)
        var delta = value
        delta = addPrefixZeros(value: delta)
        if(isByte(value: delta)){
            var j = 0
            for i in delta {
                self.value[j] = Bit(value: Int(String(i))!)
                j += 1
            }
        }
    }
    
    public func toString() -> String {
        var res = String()
        for i in value {
            res += i.toString()
        }
        return res
    }

    private func isByte(value : String) -> Bool {
        for i in value {
            if i != "0" && i != "1" {
                return false
            }
        }
        return true
    }

    private func addPrefixZeros(value : String) -> String {
        var res = String()
        let delta = 8 - value.count
        //prevent Range with upperBound < lowerBound
        if delta == 0 {
            return value
        }
        
        for _ in 1 ... delta {
            res.append("0")
        }
        return res + value
    }
}
