//
//  lbase64.swift
//  Louise Dev Team lbase64
//
//  Created by Louis Shen on 2020/12/23.
//

import Foundation

let VERSION = "0.0.2-beta.1"

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
