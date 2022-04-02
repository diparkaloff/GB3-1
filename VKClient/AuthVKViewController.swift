//
//  AuthVKViewController.swift
//  VKClient
//
//  Created by Дмитрий Паркалов on 1.04.22.
//
import UIKit
import WebKit

class AuthVKViewController: UIViewController {
    
    var session = Session.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadAuthVK()
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    
    func loadAuthVK() {
        
        // конструктор для URL
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: "8121920"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.126")
        ]
        
        guard let url = urlConstructor.url  else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    

}

extension AuthVKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        // проверка на полученый адрес и получение данных из url
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        if let token = params["access_token"], let userID = params["user_id"] {
            session.token = token
            session.id = Int(userID)!
            print(Session.shared.id)
            print(Session.shared.token)
            GetDataFromVK().loadData(.namesAndAvatars)
            GetDataFromVK().loadData(.groups)
            GetDataFromVK().loadData(.photos)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
