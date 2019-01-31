//
//  NetworkManager.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class NetworkManager {
    private var imageCache = NSCache<NSString, UIImage>()
    static var shared = NetworkManager()
    private init() {}
    
    func dowloadHeadlinesArticles(completion: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: Constants.topHeadlines) else { return }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil,
                data != nil,
                let res = response as? HTTPURLResponse,
                res.statusCode == 200 else { return }
            var arrToReturn = [Article]()
            do {
                let topHeadlines = try JSONDecoder().decode(SearchResults.self, from: data!)
                guard let articles = topHeadlines.articles else { return }
                arrToReturn = articles
            } catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(arrToReturn)
            }
        }
        dataTask.resume()
    }
    
    func dowloadSearchedArticles(withKeyword keyword: String, completion: @escaping ([Article]?) -> Void) {
        var tempSearchedArray = [Article]()


        let searchUrlString = Constants.searchQueryHeaders.replacingOccurrences(of: Constants.searchTag, with: keyword)
        guard let url = URL(string: searchUrlString) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let searchedResult = try JSONDecoder().decode(SearchResults.self, from: data)
                guard let articles = searchedResult.articles else { return }
                tempSearchedArray = articles
            } catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(tempSearchedArray)
            }
        }
        dataTask.resume()

    }
    
    func downloadImage(withUrl imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrl) else { return }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil,
                    data != nil,
                    let res = response as? HTTPURLResponse,
                    res.statusCode == 200 else {
                        DispatchQueue.main.async {
                            completion(UIImage(named: Constants.downloadFailureImageName))
                        }
                        return }
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}

extension NetworkManager {
    private struct Constants {
        static let tagResourseString = "https://newsapi.org"
        static let keyAPIString = "b59bc1f13f884301a259ebc4a7c68af2"
        
        static let tagCountry = "country="
        static let searchTag = "#searchTag"
        //Sourses
        static let topHeadlines = "\(Constants.tagResourseString)/v2/top-headlines?\(Constants.tagCountry)ru&apiKey=\(Constants.keyAPIString)"
        static let searchQueryEverithing = "\(Constants.tagResourseString)/v2/everything?q=\(Constants.searchTag)&apiKey=\(Constants.keyAPIString)"
        static let searchQueryHeaders = "\(Constants.tagResourseString)/v2/top-headlines?q=\(Constants.searchTag)&apiKey=\(Constants.keyAPIString)"
        
        static let downloadFailureImageName = "ImagePlaseholder"
    }
}
