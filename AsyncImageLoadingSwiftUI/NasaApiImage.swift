//
//  NasaApiImage.swift
//  AsyncImageLoadingSwiftUI
//
//  Created by Alexander Römer on 06.12.19.
//  Copyright © 2019 Alexander Römer. All rights reserved.
//
import SwiftUI

class NasaApiImage: ObservableObject {
    @Published var dataHasLoaded   = false
    @Published var image: UIImage? = nil
}

extension NasaApiImage {
    
    func loadImageFromApi(urlString: String) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: parseJsonObject)
        task.resume()
    }
    
    private func parseJsonObject(data: Data?, urlResponse: URLResponse?, error: Error?) {
        guard error == nil else {
            print("\(error!)")
            return
        }
        
        guard let content = data else {
            print("No data")
            return
        }
        
        let json = try! JSONSerialization.jsonObject(with: content)
        let jsonmap = json as! [String : Any]
        let urlString = jsonmap["url"] as! String
        
        print("\(urlString)")
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: setImageFromData)
        task.resume()
    }
    
    private func setImageFromData(data: Data?, urlResponse: URLResponse?, error: Error?) {
        guard error == nil else {
            print("\(error!)")
            return
        }
        
        guard let content = data else {
            print("No data")
            return
        }
        
        DispatchQueue.main.async {
            self.image = UIImage(data: content)
            self.dataHasLoaded = true
        }
    }
}
