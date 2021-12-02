//
//  Keyboard.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 15.11.2021.
//

import Foundation
import SwiftUI
import Combine

final class Keyboard: ObservableObject
{
    let didChange = PassthroughSubject<CGFloat, Never>();
    
    public var keyboardIsHidden: Bool = true;
    private(set) var currentHeight: CGFloat = 0
    {
        didSet
        {
            didChange.send( currentHeight )
        }
    };
    
    func addObserver()
    {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector( keyboardWillShow( notification: ) ),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        );
        NotificationCenter.default.addObserver(
            self, selector: #selector( keyboardWillHide( notification: ) ),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        );
    }

    func removeObserver()
    {
        NotificationCenter.default.removeObserver( self );
    }

    deinit
    {
        NotificationCenter.default.removeObserver( self );
    }

    @objc func keyboardWillShow( notification: Notification )
    {
        if self.keyboardIsHidden
        {
            self.keyboardIsHidden = false;
            
            if let keyboardSize = ( notification.userInfo? [UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue )?.cgRectValue
            {
                currentHeight = keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide( notification: Notification )
    {
        self.keyboardIsHidden = true;
    }
}


extension UIApplication
{
    func endEditing()
    {
        sendAction( #selector( UIResponder.resignFirstResponder ), to: nil, from: nil, for: nil );
    }
}
