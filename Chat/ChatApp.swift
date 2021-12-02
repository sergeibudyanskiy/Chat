//
//  ChatApp.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 10.11.2021.
//

import SwiftUI

@main
struct ChatApp: App
{
    @ObservedObject private var db: DataBase = DataBase();
    @ObservedObject private var status: Status = Status();
    
    var body: some Scene
    {
        WindowGroup
        {
            if ( !self.status.isLogin )
            {
                LoginView( db: self.db, status: self.status );
            }
            else
            {
                MainView( status: self.status );
            }
        }
    }
}
