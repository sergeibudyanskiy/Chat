//
//  ProfileView.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 26.11.2021.
//

import SwiftUI

struct ProfileView: View
{
    @Environment(\.colorScheme) var colorScheme;
    
    @ObservedObject var status: Status;
    
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
                        HStack
                        {
                            Text( "Profile" )
                                .font( Font.system( size: 70, design: .rounded ) )
                                .fontWeight( .heavy )
                                .textCase( .uppercase )
                            
                            Spacer();
                            
                            Button(
                                action:
                                {
                                    self.status.isLogin = false;
                                }
                            )
                            {
                                Text( "Quit" )
                                    .frame( maxWidth: 120, maxHeight: 50 )
                                    .background( light( self.colorScheme ) )
                                    .foregroundColor( dark( self.colorScheme ) )
                                    .border( dark( self.colorScheme ), width: 5.0 )
                                    .cornerRadius( 5 )
                                    .textCase( .uppercase )
                                    .font( Font.system(size: 20, weight: .bold ) )
                            }
                        }
                        
                        Spacer()
                        NavigationLink
                        {
                        } label:
                        {
                            Text( "Info" )
                                .frame( maxWidth: .infinity, maxHeight: .infinity )
                                .background( light( self.colorScheme ) )
                                .foregroundColor( dark( self.colorScheme ) )
                                .border( dark( self.colorScheme ), width: 5.0 )
                                .cornerRadius( 5 )
                                .textCase( .uppercase )
                                .font( Font.system(size: 20, weight: .bold ) )
                        }
                    }
                    .padding( 10.0 )
                    .navigationBarHidden( true )
                }
                .frame( width: geometry.size.width, height: geometry.size.height, alignment: .center )
            }
            .font( Font.system( size: 20, design: .rounded ) )
            .foregroundColor( dark( self.colorScheme ) )
        }
    }
}

struct ProfileView_Previews: PreviewProvider
{
    static private var status: Status = Status();
    
    static var previews: some View
    {
        ProfileView( status: status );
    }
}
