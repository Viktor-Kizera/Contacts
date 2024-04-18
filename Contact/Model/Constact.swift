//
//  Constact.swift
//  Contact
//
//  Created by Viktor Kizera on 17.04.2024.
//

import Foundation

protocol ConstactProtocol {
    var title: String {get set}
    var phone: String {get set}
}
struct Constact: ConstactProtocol {
    var title: String
    var phone: String
}

