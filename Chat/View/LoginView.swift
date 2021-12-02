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
    
    @ObservedObject public var db: DataBase;
    @ObservedObject public var status: Status;
    
    @State private var isOkay: Bool?;
    @State private var keyboard: Keyboard = Keyboard();
    @State private var enterUserInfo: UserInfo = UserInfo();
    
    private func login()
    {
        self.db.select(
            table: TABLE_USER,
            parameters:[
                TABLE_USER_LOGIN: self.enterUserInfo.login,
                TABLE_USER_PASSWORD: self.enterUserInfo.password
            ]
        )
        {
            withAnimation( .easeInOut( duration: 0.5 ) )
            {
                self.isOkay = self.db.response.status;
            }
            DispatchQueue.main.asyncAfter( deadline: .now() + 0.5 )
            {
                withAnimation( .easeInOut( duration: 0.5 ) )
                {
                    self.status.isLogin = self.isOkay!;
                }
            }
        }
    }
    
    var body: some View
    {
        WrapperView( keyboard: self.keyboard )
        {
            Text( "login-title" )
                .font( Font.system( size: 70, design: .rounded ) )
                .fontWeight( .heavy )
                .textCase( .uppercase )
            if ( self.keyboard.keyboardIsHidden )
            {
                StatusImgView( image: USER_LOGO, status: self.isOkay );
            }
            
            Spacer();
            TextField( EMPTY_STRING, text: self.$enterUserInfo.login )
                .placeholder(
                    when: self.enterUserInfo.login.isEmpty,
                    self.colorScheme,
                    placeholder:
                    {
                        Text( "login-field-login" )
                    }
                )
                .padding( 10.0 )
                .onTapGesture
                {
                    withAnimation( .easeInOut( duration: 0.5 ) )
                    {
                        self.isOkay = nil;
                    }
                }
                
            SecureField( EMPTY_STRING, text: self.$enterUserInfo.password )
                .placeholder(
                    when: self.enterUserInfo.password.isEmpty,
                    self.colorScheme,
                    placeholder:
                    {
                        Text( "login-field-password" )
                    }
                )
                .padding( 10.0 )
                .onTapGesture {
                    withAnimation( .easeInOut( duration: 0.5 ) )
                    {
                        self.isOkay = nil;
                    }
                }
            
            Spacer();
            Button(
                action:
                {
                    UIApplication.shared.endEditing();
                    self.login();
                }
            )
            {
                Text( "login-button-confirm" )
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
                RegistrationView( db: db )
                    .onAppear( perform: { self.isOkay = nil; } )
            }
            label:
            {
                Text( "login-button-registrate" )
                    .frame( maxWidth: .infinity, minHeight: 50 )
                    .background( light( self.colorScheme ) )
                    .foregroundColor( dark( self.colorScheme ) )
                    .border( dark( self.colorScheme ), width: 5.0 )
                    .cornerRadius( 5 )
                    .textCase( .uppercase )
                    .font( Font.system( size: 20, weight: .bold ) )
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider
{
    static private var db: DataBase = DataBase();
    static private var keyboard: Keyboard = Keyboard();
    static private var status: Status = Status();
    
    static var previews: some View
    {
        LoginView( db: self.db, status: self.status )
            .environment( \.locale, .init(identifier: "en" ) )
        LoginView( db: self.db, status: self.status )
            .environment( \.locale, .init(identifier: "ru" ) )
    }
}
