//
//  WrapperView.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 02.12.2021.
//

import SwiftUI

struct WrapperView<Content: View>: View
{
    @Environment(\.colorScheme) var colorScheme;
    
    @ObservedObject var keyboard: Keyboard;
    
    @ViewBuilder public var content: () -> Content;
    
    @State public var partOfWidth: Float = 1.3;
    @State public var backgroundFontSize: Float = 20;
    
    init( keyboard: Keyboard, @ViewBuilder content: @escaping () -> Content )
    {
        self.keyboard = keyboard;
        self.content = content;
    }
    
    var body: some View
    {
        NavigationView
        {
            GeometryReader
            { geometry in
                VStack
                {
                    VStack( content: self.content )
                        .frame( width: geometry.size.width / CGFloat(self.partOfWidth), alignment: .center )
                        .navigationBarHidden( true )
                }
                .frame( width: geometry.size.width, height: geometry.size.height, alignment: .center )
            }
            .font( Font.system( size: CGFloat(self.backgroundFontSize), design: .rounded ) )
            .foregroundColor( dark( self.colorScheme ) )
        }
        .onAppear( perform: { self.keyboard.addObserver(); } )
        .onDisappear( perform: { self.keyboard.removeObserver(); } )
        .navigationBarHidden( true )
    }
}

struct WrapperView_Previews: PreviewProvider
{
    static private var keyboard: Keyboard = Keyboard();
    
    static var previews: some View
    {
        WrapperView( keyboard: self.keyboard, content: { Text( "123" ) } );
    }
}
