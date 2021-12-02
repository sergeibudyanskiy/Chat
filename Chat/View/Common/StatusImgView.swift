//
//  StatusImgView.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 02.12.2021.
//

import SwiftUI

struct StatusImgView: View
{
    @Environment(\.colorScheme) var colorScheme;
    
    public var image: String;
    public var status: Bool?;
    
    var body: some View
    {
        if ( nil == self.status )
        {
            Image( systemName: self.image )
                .resizable()
                .scaledToFit()
                .foregroundColor( self.colorScheme == .dark ? .white : .black )
        }
        else if ( self.status! )
        {
            Image( systemName: self.image )
                .resizable()
                .scaledToFit()
                .foregroundColor( .green )
        }
        else
        {
            Image( systemName: self.image )
                .resizable()
                .scaledToFit()
                .foregroundColor( .red )
        }
    }
}

struct StatusImgView_Previews: PreviewProvider
{
    static private var status: Bool?;
    
    static var previews: some View
    {
        StatusImgView( image: USER_LOGO, status: self.status );
    }
}
