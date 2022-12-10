//
//  HTTPHeader.swift
import Foundation

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case accept = "Accept"
}

struct HTTPHeader {
    var field: String
    var value: String
    
    init(field: HTTPHeaderField, value: String){
        self.field = field.rawValue
        self.value = value
    }
    
    init(field: String, value: String){
        self.field = field
        self.value = value
    }
}
extension URLRequest {
    mutating func add(header: HTTPHeader){
        self.addValue(header.value, forHTTPHeaderField: header.field)
    }
}

