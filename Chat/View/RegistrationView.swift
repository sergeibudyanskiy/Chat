//
//  RegistrationView.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 12.11.2021.
//

import SwiftUI

struct RegistrationView: View
{
    @Environment(\.presentationMode) var presentationMode;
    @Environment(\.colorScheme) var colorScheme;
    
    @ObservedObject var db: DataBase;
    
    @State private var iconStatus: Bool?;
    @State private var isNameEmpty: Bool?;
    @State private var isLoginEmpty: Bool?;
    @State private var isPasswordEmpty: Bool?;
    @State private var isRepeatPasswordEmpty: Bool?;
    @State private var keyboard: Keyboard = Keyboard();
    @State private var enterRepeatPassword: String = "";
    @State private var enterUserInfo: UserInfo = UserInfo();
    
    private func registrate()
    {
        if ( self.enterUserInfo.password == self.enterRepeatPassword )
        {
            self.db.insert(
                table: TABLE_USER,
                parameters: [
                    TABLE_USER_NAME: self.enterUserInfo.name,
                    TABLE_USER_LOGIN: self.enterUserInfo.login,
                    TABLE_USER_PASSWORD: self.enterUserInfo.password
                ])
            {
                withAnimation( .easeInOut( duration: 0.5 ) )
                {
                    self.iconStatus = self.db.response.status;
                }
            };
        }
        else
        {
            withAnimation( .easeInOut( duration: 0.5 ) )
            {
                self.iconStatus = false;
                self.enterRepeatPassword = EMPTY_STRING;
            }
            
        }
    }
    
    var body: some View
    {
        WrapperView( keyboard: self.keyboard )
        {
            Text( "registration-title" )
                .font( Font.system( size: 35, design: .rounded ) )
                .fontWeight( .heavy )
                .textCase( .uppercase )
            if ( self.keyboard.keyboardIsHidden )
            {
                StatusImgView( image: USER_LOGO_ADD, status: self.iconStatus )
            }
            
            Spacer();
            TextField( EMPTY_STRING, text: self.$enterUserInfo.name )
                .placeholder(
                    when: self.enterUserInfo.name.isEmpty || nil != isNameEmpty && isNameEmpty!,
                    self.colorScheme,
                    placeholder:
                    {
                        Text( "registration-field-name" )
                    }
                )
                .padding( 10 )
            TextField( EMPTY_STRING, text: self.$enterUserInfo.login )
                .placeholder(
                    when: self.enterUserInfo.login.isEmpty || nil != isLoginEmpty && isLoginEmpty!,
                    self.colorScheme,
                    placeholder:
                    {
                        Text( "registration-field-login" )
                            .foregroundColor( nil == isLoginEmpty || isLoginEmpty! ? .red : dark( self.colorScheme ) )
                    }
                )
                .padding( 10 )
                .disabled( isLoginEmpty ?? true )
            
            SecureField( EMPTY_STRING, text: self.$enterUserInfo.password )
                .placeholder(
                    when: self.enterUserInfo.password.isEmpty || nil != isPasswordEmpty && isPasswordEmpty!,
                    self.colorScheme,
                    placeholder:
                    {
                        Text( "registration-field-password" )
                            .foregroundColor( nil == isPasswordEmpty || isPasswordEmpty! ? .red : dark( self.colorScheme ) )
                    }
                )
                .padding( 10 )
                .disabled( isPasswordEmpty ?? true )
            SecureField( EMPTY_STRING, text: self.$enterRepeatPassword )
                .placeholder(
                    when: self.enterRepeatPassword.isEmpty,
                    self.colorScheme,
                    placeholder:
                    {
                        Text( "registration-field-repeat-password" )
                            .foregroundColor( nil == isRepeatPasswordEmpty || isRepeatPasswordEmpty! ? .red : dark( self.colorScheme ) )
                    }
                )
                .padding( 10 )
                .disabled( isRepeatPasswordEmpty ?? true )
            
            Spacer();
            Button(
                action:
                {
                    self.registrate();
                    UIApplication.shared.endEditing();
                    
                }
            )
            {
                Text( "registration-button-confirm" )
                    .frame( maxWidth: .infinity, minHeight: 50 )
                    .background( dark( self.colorScheme ) )
                    .foregroundColor( light( self.colorScheme ) )
                    .border( dark( self.colorScheme ), width: 5.0 )
                    .cornerRadius( 5 )
                    .textCase( .uppercase )
                    .font( Font.system( size: 20, weight: .bold ) )
            }
            Button( action: { self.presentationMode.wrappedValue.dismiss(); } )
            {
                Text( "registration-button-cancel" )
                    .frame( maxWidth: .infinity, minHeight: 50 )
                    .background( light( self.colorScheme ) )
                    .foregroundColor( dark( self.colorScheme ) )
                    .border( dark( self.colorScheme ), width: 5.0 )
                    .cornerRadius( 5 )
                    .textCase( .uppercase )
                    .font( Font.system(size: 20, weight: .bold ) )
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider
{
    static private var db: DataBase = DataBase();
    static private var keyboard: Keyboard = Keyboard();
    
    static var previews: some View
    {
        RegistrationView( db: db )
            .environment( \.locale, .init(identifier: "en" ) )
        RegistrationView( db: db )
            .environment( \.locale, .init(identifier: "ru" ) )
    }
}
