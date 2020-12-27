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
    static let Base64DecodeTable : [String : UInt8] = ["A":0,"B":1,"C":2,"D":3,"E":4,"F":5,"G":6,
                         "H":7,"I":8,"J":9,"K":10,"L":11,"M":12,"N":13,
                         "O":14,"P":15,"Q":16,"R":17,"S":18,"T":19,"U":20,
                         "V":21,"W":22,"X":23,"Y":24,"Z":25,
                         "a":26,"b":27,"c":28,"d":29,"e":30,"f":31,"g":32,
                         "h":33,"i":34,"j":35,"k":36,"l":37,"m":38,"n":39,
                         "o":40,"p":41,"q":42,"r":43,"s":44,"t":45,"u":46,
                         "v":47,"w":48,"x":49,"y":50,"z":51,
                         "0":52,"1":53,"2":54,"3":55,"4":56,"5":57,"6":58,
                         "7":59,"8":60,"9":61,"+":62,"/":63,"=":0]
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

        //avoid compile warning
        for _ in 0 ..< placeholderCnt {
            let _ = res.popLast()
        }
        for _ in 0 ..< placeholderCnt {
            res.append("=")
        }

        return res
    }

    /*
     @author Louise Shen
     @version 0.0.2
     @args The base64 String to decode
     @return The origin decode
     */
    static func toString(origin : String) -> String{
        let latter : [UInt8] = [0b00000011, 0b00001111, 0b00111111]
        var binaryData = [UInt8]()
        for i in origin {
            binaryData.append(Base64DecodeTable[String(i)]!)
        }
        var data : Data = Data()

        var count = 0
        for i in 0 ..< binaryData.count - 1 {
            //when count equals 3, all the value has been used in last loop
            if count == 3 {
                count = 0
                continue
            }
            let delta = (binaryData[i] & latter[3 - count - 1]) << ((count + 1) << 1)
            let buffer = binaryData[i + 1] >> ((3 - count - 1) << 1)
            data.append(delta + buffer)
            count += 1
        }
        return String(data: data, encoding: .utf8)!
    }
}
