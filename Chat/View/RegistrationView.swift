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
    @ObservedObject var keyboard: Keyboard;
    
    @State private var enterUserInfo: UserInfo = UserInfo();
    @State private var enterRepeatPassword: String = "";
    
    @State private var iconStatus: Bool?;
    
    @State private var isNameEmpty: Bool?;
    @State private var isLoginEmpty: Bool?;
    @State private var isPasswordEmpty: Bool?;
    @State private var isRepeatPasswordEmpty: Bool?;
    
    private func registrate()
    {
        if ( self.enterUserInfo.password == self.enterRepeatPassword )
        {
            self.db.insert(
                table: "user",
                parameters: [
                    "name": self.enterUserInfo.name,
                    "login": self.enterUserInfo.login,
                    "password": self.enterUserInfo.password
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
                self.enterRepeatPassword = EMPTY;
            }
            
        }
    }
    
    var body: some View
    {
        GeometryReader
        { geometry in
            VStack
            {
                VStack
                {
                    Text( REGISTRATION_TITLE )
                        .font( Font.system( size: 35, design: .rounded ) )
                        .fontWeight( .heavy )
                        .textCase( .uppercase )
                    if ( self.keyboard.keyboardIsHidden )
                    {
                        if ( iconStatus == nil )
                        {
                            Image( systemName: USER_ADD_LOGO )
                                .resizable()
                                .scaledToFit()
                        }
                        else if ( iconStatus! )
                        {
                            Image( systemName: USER_OK_LOGO )
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.green)
                        }
                        else
                        {
                            Image( systemName: USER_ERROR_LOGO )
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red)
                        }
                    }
                    
                    Spacer();
                    TextField( EMPTY, text: self.$enterUserInfo.name )
                        .placeholder(
                            when: self.enterUserInfo.name.isEmpty || nil != isNameEmpty && isNameEmpty!,
                            self.colorScheme,
                            placeholder:
                            {
                                Text( REGISTRATION_FILED_NAME.capitalizingFirstLetter() )
                            }
                        )
                        .padding( 10 )
                    TextField( EMPTY, text: self.$enterUserInfo.login )
                        .placeholder(
                            when: self.enterUserInfo.login.isEmpty || nil != isLoginEmpty && isLoginEmpty!,
                            self.colorScheme,
                            placeholder:
                            {
                                Text( REGISTRATION_FILED_LOGIN.capitalizingFirstLetter() )
                                    .foregroundColor( nil == isLoginEmpty || isLoginEmpty! ? .red : dark( self.colorScheme ) )
                            }
                        )
                        .padding( 10 )
                        .disabled( isLoginEmpty ?? true )
                    
                    SecureField( EMPTY, text: self.$enterUserInfo.password )
                        .placeholder(
                            when: self.enterUserInfo.password.isEmpty || nil != isPasswordEmpty && isPasswordEmpty!,
                            self.colorScheme,
                            placeholder:
                            {
                                Text( LOGIN_FILED_PASSWORD.capitalizingFirstLetter() )
                                    .foregroundColor( nil == isPasswordEmpty || isPasswordEmpty! ? .red : dark( self.colorScheme ) )
                            }
                        )
                        .padding( 10 )
                        .disabled( isPasswordEmpty ?? true )
                    SecureField( EMPTY, text: self.$enterRepeatPassword )
                        .placeholder(
                            when: self.enterRepeatPassword.isEmpty,
                            self.colorScheme,
                            placeholder:
                            {
                                Text( REGISTRATION_FILED_PASSWORD_REPEAT.capitalizingFirstLetter() )
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
                        Text( REGISTRATION_BUTTON_CONFIRM )
                            .frame( maxWidth: .infinity, minHeight: 50 )
                            .background( dark( self.colorScheme ) )
                            .foregroundColor( light( self.colorScheme ) )
                            .border( dark( self.colorScheme ), width: 5.0 )
                            .cornerRadius( 5 )
                            .textCase( .uppercase )
                            .font( Font.system( size: 20, weight: .bold ) )
                    }
                    Button( action: { self.presentationMode.wrappedValue.dismiss() } )
                    {
                        Text( REGISTRATION_BUTTON_CANCEL )
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
                .onChange( of: self.enterUserInfo.name )
                { newValue in
                    isLoginEmpty = newValue.isEmpty;
                    if ( isLoginEmpty! )
                    {
                        self.enterUserInfo.login = EMPTY;
                    }
                }
                .onChange( of: self.enterUserInfo.login )
                { newValue in
                    isPasswordEmpty = newValue.isEmpty;
                    if ( isPasswordEmpty! )
                    {
                        self.enterUserInfo.password = EMPTY;
                        self.enterRepeatPassword = EMPTY;
                    }
                }
                .onChange( of: self.enterUserInfo.password )
                { newValue in
                    isRepeatPasswordEmpty = newValue.isEmpty;
                    if ( isRepeatPasswordEmpty! )
                    {
                        self.enterUserInfo.password = EMPTY;
                        self.enterRepeatPassword = EMPTY;
                    }
                }
            }
            .frame( width: geometry.size.width, height: geometry.size.height, alignment: .center )
        }
        .font( Font.system( size: 20, design: .rounded ) )
        .foregroundColor( dark( self.colorScheme ) )
    }
}

struct RegistrationView_Previews: PreviewProvider
{
    static private var db: DataBase = DataBase();
    static private var keyboard: Keyboard = Keyboard();
    
    static var previews: some View
    {
        RegistrationView( db: db, keyboard: keyboard );
    }
}
