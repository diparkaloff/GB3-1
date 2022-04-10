//
//  Groups.swift
//  VKClient
//
//  Created by Дмитрий Паркалов on 9.04.22.
//

import UIKit

struct Groups: Equatable {
    let groupName: String
    //let groupLogo: UIImage?
    let groupLogo: String
    
    // для проведения сравнения (.contains), только по имени
    static func ==(lhs: Groups, rhs: Groups) -> Bool {
        return lhs.groupName == rhs.groupName
    }
}
