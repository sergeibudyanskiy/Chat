//
//  DataBase.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 05.11.2021.
//

import Foundation
import SwiftUI

class DataBase : ObservableObject
{
    private let url = URL( string: DATABASE_HOST )!;
    
    public var response: Response = Response();
    
    public enum Action
    {
        case Use;
        case Select;
        case Insert;
    }
    
    init()
    {
        self.use( database: DATABASE_NAME, onCompleted: {} );
    }
    
    func use( database: String, onCompleted: @escaping () -> () )
    {
        self.query(
            parameters: [
                "action": actionToString( .Use ),
                "database": database
            ],
            onCompleted: onCompleted
        )
    }
    
    func insert( table: String, parameters: [ String: String ], onCompleted: @escaping () -> () )
    {
        self.query(
            parameters: [
                "action": actionToString( .Insert ),
                "table": table,
                "params": self.jsonToString( from: parameters )
            ],
            onCompleted: onCompleted
        );
    }
    
    func select( table: String, parameters: [ String: String ], onCompleted: @escaping () -> () )
    {
        self.query(
            parameters: [
                "action": actionToString( .Select ),
                "table": table,
                "params": self.jsonToString( from: parameters )
            ],
            onCompleted: onCompleted
        );
    }
    
    private func jsonToString( from object:Any ) -> String!
    {
        guard let data = try? JSONSerialization.data( withJSONObject: object, options: [] ) else
        {
            return nil
        }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    private func actionToString( _ action: Action ) -> String
    {
        switch( action )
        {
        case .Use:
            return "use";
        case .Select:
            return "select";
        case .Insert:
            return "insert into";
        }
    }
        
    private func query( parameters: [ String: String ], onCompleted: @escaping () -> () )
    {
        var request = URLRequest( url: self.url );
        request.setValue( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" );
        request.httpMethod = "POST";
        request.httpBody = parameters.percentEncoded();

        let task = URLSession.shared.dataTask( with: request )
        { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else
            {
                print( error ?? "Unknown error" );
                return;
            }

            guard
                ( 200 ... 299 ) ~= response.statusCode
            else
            {
                print( "statusCode should be 2xx, but is \( response.statusCode )" );
                print( "response = \(response)" );
                return;
            }

            let responseString = String( data: data, encoding: .utf8 );
            
            print( "responseString = \( responseString! )" );
            
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any];
            
            self.response.set( json: json! );
            
            //DispatchQueue.main.async {
            onCompleted();
            //}
        }

        task.resume();
    }
}

extension Dictionary
{
    func percentEncoded() -> Data?
    {
        return map
        { key, value in
            let escapedKey = "\( key )".addingPercentEncoding( withAllowedCharacters: .urlQueryValueAllowed ) ?? ""
            let escapedValue = "\( value )".addingPercentEncoding( withAllowedCharacters: .urlQueryValueAllowed ) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined( separator: "&" )
        .data( using: .utf8 )
    }
}

extension CharacterSet
{
    static let urlQueryValueAllowed: CharacterSet =
    {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove( charactersIn: "\( generalDelimitersToEncode )\( subDelimitersToEncode )" )
        return allowed
    }()
}
