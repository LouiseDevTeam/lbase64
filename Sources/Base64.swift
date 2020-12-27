import Foundation

struct Base64{
    static let Base64EncodeTable = ["A","B","C","D","E","F","G",
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
     @version 0.0.3
     @args origin
     @return The base64 encode
     */
    static func toBase64(origin : String) -> String {
        var binaryData = Data(origin.utf8)
        let latter : [UInt8] = [0b00000011, 0b00001111, 0b00111111]
        var buffer : UInt8 = 0b00000000
        var res = String()
        var placeholderCnt = 0

        for _ in 0 ..< (3 - binaryData.count % 3) % 3 {
            binaryData.append(0b00000000)
            placeholderCnt += 1
        }

        var count = 0
        for i in binaryData {
            if count == 3 {
                buffer = 0b00000000
                count = 0
            }
            let delta = buffer << ((3 - count) << 1)
            buffer = i & latter[count]
            res += Base64EncodeTable[Int(delta + (i >> ((count + 1) << 1)))]
            if count == 2 {
                res += Base64EncodeTable[Int(buffer)]
            }
            count += 1
        }

        for _ in 0 ..< placeholderCnt {
            res.popLast()
        }
        for _ in 0 ..< placeholderCnt {
            res.append("=")
        }

        return res
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
