//
//  Response.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 26.11.2021.
//

import Foundation

class Response
{
    public var okay: String?;
    var status: Bool {
        get {
            return okay != nil && !okay!.isEmpty;
        }
    }
    
    func set( json: [String: Any] )
    {
        self.okay = json["okay"] as? String;
    }
    
}
