//
//  Theme.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 10.11.2021.
//

import Foundation
import SwiftUI

func dark( _ colorScheme: ColorScheme ) -> Color
{
    return colorScheme == .dark ? .white : .black;
}

func light( _ colorScheme: ColorScheme ) -> Color
{
    return colorScheme == .dark ? .black : .white;
}

extension View
{
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        _ colorScheme: ColorScheme,
        @ViewBuilder placeholder: () -> Content
    ) -> some View
    {
        
        ZStack( alignment: alignment )
        {
            placeholder()
                .foregroundColor( dark( colorScheme ) )
                .shadow( color: dark( colorScheme ), radius: 0.1, x: 0, y: 0 )
                .opacity( shouldShow ? 0.2 : 0 )
            self
        }
    }

    @ViewBuilder func isHidden( _ hidden: Bool ) -> some View
    {
        if hidden
        {
            self.hidden()
        }
        else
        {
            self
        }
    }
}

extension String
{
    func capitalizingFirstLetter() -> String
    {
      return prefix( 1 ).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter()
    {
      self = self.capitalizingFirstLetter()
    }
}
