//
//  ContentView.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 10.11.2021.
//

import SwiftUI

struct LoginView: View
{
    @Environment(\.colorScheme) var colorScheme;
    
    @ObservedObject var db: DataBase;
    @ObservedObject var keyboard: Keyboard;
    @ObservedObject var status: Status;
    
    @State private var isOkay: Bool?;
    @State private var enterUserInfo: UserInfo = UserInfo();
    
    private func login()
    {
        self.db.select(
            table: "user",
            parameters:[
                "login": self.enterUserInfo.login,
                "password": self.enterUserInfo.password
            ]
        )
        {
            withAnimation( .easeInOut( duration: 0.5 ) )
            {
                self.isOkay = self.db.response.status;
                DispatchQueue.main.async
                {
                    self.status.isLogin = self.isOkay!;
                }
            }
        }
    }
    
    var body: some View
    {
        NavigationView
        {
            GeometryReader
            { geometry in
                VStack
                {
                    VStack
                    {
                        Text( TITLE )
                            .font( Font.system( size: 70, design: .rounded ) )
                            .fontWeight( .heavy )
                            .textCase( .uppercase )
                        if ( self.keyboard.keyboardIsHidden )
                        {
                            if ( nil == isOkay )
                            {
                                Image( systemName: USER_DEFAULT_LOGO )
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor( self.colorScheme == .dark ? .white : .black )
                            }
                            else if ( isOkay! )
                            {
                                Image( systemName: USER_DEFAULT_LOGO )
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor( .green )
                            }
                            else
                            {
                                Image( systemName: USER_DEFAULT_LOGO )
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor( .red )
                            }
                        }
                        
                        Spacer();
                        TextField( EMPTY, text: self.$enterUserInfo.login )
                            .placeholder(
                                when: self.enterUserInfo.login.isEmpty,
                                self.colorScheme,
                                placeholder:
                                {
                                    Text( LOGIN_FILED_LOGIN.capitalizingFirstLetter() )
                                }
                            )
                            .padding( 10.0 )
                            .onTapGesture
                            {
                                withAnimation( .easeInOut( duration: 0.5 ) )
                                {
                                    isOkay = nil
                                }
                            }
                            
                        SecureField( EMPTY, text: self.$enterUserInfo.password )
                            .placeholder(
                                when: self.enterUserInfo.password.isEmpty,
                                self.colorScheme,
                                placeholder:
                                {
                                    Text( LOGIN_FILED_PASSWORD.capitalizingFirstLetter() )
                                }
                            )
                            .padding( 10.0 )
                            .onTapGesture {
                                withAnimation( .easeInOut( duration: 0.5 ) )
                                {
                                    isOkay = nil
                                }
                            }
                        
                        Spacer();
                        Button(
                            action:
                            {
                                self.login();
                                UIApplication.shared.endEditing();
                            }
                        )
                        {
                            Text( LOGIN_BUTTON_CONFIRM )
                                .frame( maxWidth: .infinity, minHeight: 50 )
                                .background( dark( self.colorScheme ) )
                                .foregroundColor( light( self.colorScheme ) )
                                .border( dark( self.colorScheme ), width: 5.0 )
                                .cornerRadius( 5 )
                                .textCase( .uppercase )
                                .font( Font.system( size: 20, weight: .bold ) )
                        }
                        
                        NavigationLink
                        {
                            RegistrationView( db: db, keyboard: keyboard )
                        } label:
                        {
                                Text( REGISTRATION_TITLE )
                                    .frame( maxWidth: .infinity, minHeight: 50 )
                                    .background( light( self.colorScheme ) )
                                    .foregroundColor( dark( self.colorScheme ) )
                                    .border( dark( self.colorScheme ), width: 5.0 )
                                    .cornerRadius( 5 )
                                    .textCase( .uppercase )
                                    .font( Font.system(size: 20, weight: .bold ) )
                        }
                    }
                    .frame( width: geometry.size.width / 1.3, alignment: .center )
                    .navigationBarHidden( true )
                }
                .frame( width: geometry.size.width, height: geometry.size.height, alignment: .center )
            }
            .font( Font.system( size: 20, design: .rounded ) )
            .foregroundColor( dark( self.colorScheme ) )
        }
        .onAppear( perform: { self.keyboard.addObserver(); } )
        .onDisappear( perform: { self.keyboard.removeObserver(); } )
    }
}

struct LoginView_Previews: PreviewProvider
{
    static private var db: DataBase = DataBase();
    static private var keyboard: Keyboard = Keyboard();
    static private var status: Status = Status();
    
    static var previews: some View
    {
        Group {
            LoginView( db: self.db, keyboard: self.keyboard, status: self.status );
        };
    }
}
