//
//  Structs.swift
//  ConceptGameNewsApp
//
//  Created by Devin Yancey on 6/15/17.
//  Copyright © 2017 Devin Yancey. All rights reserved.
//

import Foundation

struct Article{
    var author : String?
    var title : String?
    var description : String?
    var urlToArticleString : String?
    var imageURLString : String?
    var publishedTime : String?
    var isVideo : Bool = false
}
