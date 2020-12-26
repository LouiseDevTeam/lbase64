import Foundation

struct Base64{
    static let Base64Table = ["A","B","C","D","E","F","G",
                       "H","I","J","K","L","M","N",
                       "O","P","Q","R","S","T","U",
                       "V","W","X","Y","Z",
                       "a","b","c","d","e","f","g",
                       "h","i","j","k","l","m","n",
                       "o","p","q","r","s","t","u",
                       "v","w","x","y","z",
                       "0","1","2","3","4","5","6",
                       "7","8","9","+","/"]
    
    /*
     @author Louise Shen
     @version 0.0.2
     @args The origin String to encode
     @return The base64 encode
     */
    static func toBase64(origin : String) -> String{
        let binaryData = Data(origin.utf8)
        var raw = String()
        for i in binaryData {
            raw += Byte(value: String(i, radix: 2)).toString()
        }

        var delta = [String]()
        var bytes = [Byte]()

        var isRunning = ""

        if raw.count == 16 {
            isRunning = "="
    
            delta.append(String(raw[raw.startIndex ..< raw.index(raw.startIndex, offsetBy: 6)]))
            delta.append(String(raw[raw.index(raw.startIndex, offsetBy: 6) ..< raw.index(raw.startIndex, offsetBy: 12)]))
            delta.append(String(raw[raw.index(raw.startIndex, offsetBy: 12) ..< raw.endIndex]))
    
            delta[2] += "00"
    
        } else if raw.count == 8 {
            isRunning = "=="
            
            delta.append(String(raw[raw.startIndex ..< raw.index(raw.startIndex, offsetBy: 6)]))
            delta.append(String(raw[raw.index(raw.startIndex, offsetBy: 6) ..< raw.endIndex]))
            
            delta[1] += "0000"
        } else {
            isRunning = ""
            delta = splitBy(length: 6, value: raw)
        }

        for i in delta {
            bytes.append(Byte(value: i))
        }

        var res = String()
        for i in bytes {
            res += Base64Table[Int(i.toString(), radix: 2)!];
        }
        res += isRunning;
        return res;
    }

    /*
     @author Louise Shen
     @version 0.0.1
     @args The base64 String to decode
     @return The origin decode
     */
    static func toString(origin : String) -> String{
        let base64Data = NSData(base64Encoded: origin, options: NSData.Base64DecodingOptions(rawValue: 0))
        let stringWithDecode = NSString(data: base64Data! as Data, encoding: String.Encoding.utf8.rawValue)
        return stringWithDecode! as String
    }

    private static func splitBy(length : Int,value : String) -> [String] {
        var res = [String]()
    
        for i in 0 ..< value.count / length {
            if (i + 1) * length > value.count {
                break;
            }
            let startIndex = value.index(value.startIndex, offsetBy: i * length)
            let endIndex = value.index(value.startIndex, offsetBy: (i + 1) * length)
            res.append(String(value[startIndex ..< endIndex]))
        }
    
        return res
    }
}
