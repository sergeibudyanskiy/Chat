//
//  Status.swift
//  Chat
//
//  Created by Sergei Budyanskiy on 26.11.2021.
//

import Foundation

@MainActor
final class Status: ObservableObject
{
    @Published public var isLogin: Bool = false;
}
