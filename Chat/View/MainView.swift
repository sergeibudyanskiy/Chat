//
//  MainView.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 26.11.2021.
//

import SwiftUI

struct MainView: View
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
                            Text( TITLE )
                                .font( Font.system( size: 70, design: .rounded ) )
                                .fontWeight( .heavy )
                                .textCase( .uppercase )
                            
                            Spacer();
                            
                            NavigationLink
                            {
                                ProfileView( status: status );
                            }
                            label:
                            {
                                Text( "Profile" )
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
                        }
                        label:
                        {
                            Text( "Create" )
                                .frame( maxWidth: .infinity, maxHeight: .infinity )
                                .background( light( self.colorScheme ) )
                                .foregroundColor( dark( self.colorScheme ) )
                                .border( dark( self.colorScheme ), width: 5.0 )
                                .cornerRadius( 5 )
                                .textCase( .uppercase )
                                .font( Font.system(size: 20, weight: .bold ) )
                        }
                        
                        NavigationLink
                        {
                        }
                        label:
                        {
                            Text( "Find" )
                                .frame( maxWidth: .infinity, maxHeight: .infinity )
                                .background( light( self.colorScheme ) )
                                .foregroundColor( dark( self.colorScheme ) )
                                .border( dark( self.colorScheme ), width: 5.0 )
                                .cornerRadius( 5 )
                                .textCase( .uppercase )
                                    .font( Font.system(size: 20, weight: .bold ) )
                        }
                        NavigationLink
                        {
                        }
                        label:
                        {
                            Text( "News" )
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

struct MainView_Previews: PreviewProvider
{
    static private var status: Status = Status();
    
    static var previews: some View
    {
        MainView( status: status );
    }
}
