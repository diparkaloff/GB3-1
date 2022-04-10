//
//  GetDataFromVK.swift
//  VKClient
//
//  Created by Дмитрий Паркалов on 1.04.22.
//

import Foundation

class GetDataFromVK {
    
    enum parametersAPI {
        case namesAndAvatars
        case photos
        case groups
        case searchGroups
    }
    
    // запрос данных
    func loadData(_ parameters: parametersAPI) {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.126")
        ]
        
        switch parameters { //параметры конструктора
        case .namesAndAvatars:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.shared.id)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .photos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(Session.shared.id)))
        case .groups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.shared.id)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "video")) // использование поиска
            urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        }
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) else { return }
            print(json)
            
        }
        // запускаем задачу
        task.resume()
    }
    
}
