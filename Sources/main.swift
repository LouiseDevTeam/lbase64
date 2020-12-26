//
//  lbase64.swift
//  Louise Dev Team lbase64
//
//  Created by Louis Shen on 2020/12/23.
//

import Foundation

struct Base64{
    /*
     @author Louise Shen
     @version 0.0.1
     @args The origin String to encode
     @return The base64 encode
     */
    static func toBase64(origin : String) -> String{
        let utf8EncodeData = origin.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let base64String = utf8EncodeData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        return base64String!
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
}

let VERSION = "0.0.1"

let HELP_MESSAGE =
"""
Usage:    lbase64 [options] <input text>
  -h, --help     display this message
  -d, --decode   decodes input
  -e, --encode   encodes input

lbase64(Louise Dev Team Base64 \(VERSION))
"""

//let MISSING_OPTION_MESSAGE = "lbase64: error: no options"
//let MISSING_INPUT_MESSAGE = "lbase64: error: no input"
let OPTION_ERROR_MESSAGE = "lbase64: error: invalid option -- "
let MISSING_OPTION_OR_INPUT_MESSAGE = "lbase64: error: no option or input"
let TOO_MUCH_INPUT_MESSAGE = "lbase64: error: too many inputs"

//var input = readLine()!.split(separator: " ")

var input = CommandLine.arguments

// Check the input
if input.count == 1 {
    print(MISSING_OPTION_OR_INPUT_MESSAGE)
    print(HELP_MESSAGE)
}else if input.count == 2 {
    print(MISSING_OPTION_OR_INPUT_MESSAGE)
    print(HELP_MESSAGE)
}else if input.count == 3 {
    if input[1] == "-h" || input[1] == "--help" {
        print(HELP_MESSAGE)
    }else if input[1] == "-d" || input[1] == "--decode" {
        print(Base64.toString(origin: String(input[2])))
    }else if input[1] == "-e" || input[1] == "--encode" {
        print(Base64.toBase64(origin: String(input[2])))
    }
}else{
    print(TOO_MUCH_INPUT_MESSAGE)
    print(HELP_MESSAGE)
}
