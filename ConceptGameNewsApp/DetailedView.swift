//
//  DetailedView.swift
//  ConceptGameNewsApp
//
//  Created by Devin Yancey on 6/16/17.
//  Copyright © 2017 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewDelegate:class {
    func readMoreClicked(url: URL)
}
class DetailView : UIView{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var author: UILabel!
    var url : URL?
    var view: UIView!
    weak var delegate : DetailViewDelegate?
    @IBAction func readMoreClicked(_ sender: Any) {
        if url != nil{
            delegate?.readMoreClicked(url: url!)
        }
    }
    func initWithArticile(frame: CGRect, imgURLString: String, title: String, description: String, author: String){
        
        
    }
 
}
