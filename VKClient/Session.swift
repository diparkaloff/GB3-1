//
//  Session.swift
//  VKClient
//
//  Created by Дмитрий Паркалов on 1.04.22.
//

import Foundation

class Session {
    private init() {}
    static let shared = Session()
    
    var token = "" // хранение токена в VK
    var id = 0 // хранение идентификатора пользователя VK
}
