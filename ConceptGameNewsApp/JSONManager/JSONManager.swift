//
//  JSONManager.swift
//  ConceptGameNewsApp
//
//  Created by Devin Yancey on 6/15/17.
//  Copyright © 2017 Devin Yancey. All rights reserved.
//

import Foundation
import Alamofire
typealias ArrayOfJSON = [[String:Any]]
class JSONManager{
    class func getArtiticles(urlstring: String, completion:  @escaping([Article]?) ->()){
        //nil check in case the url is nil but should not happen in this case
        Alamofire.request(URL(string: urlstring)!).responseJSON { (response) in
            guard let json = response.result.value as? [String:Any] else{
                completion(nil)
                return
            }
            
            guard let articles = json["articles"] as? ArrayOfJSON else{
                completion(nil)
                return
            }
            
            completion(parseResponse(articles: articles))
            
        }
    }
    
    private class func parseResponse(articles: ArrayOfJSON) -> [Article]{
        var array : [Article] = []
        for article in articles{
            var art = Article()
            art.author = article["author"] as? String
            art.description = article["description"] as? String
            art.imageURLString = article["urlToImage"] as? String
            art.urlToArticleString = article["url"] as? String
            art.title = article["title"] as? String
            art.publishedTime = article["publishedAt"] as? String
            array.append(art)
        }
        return array
    }
    
}
