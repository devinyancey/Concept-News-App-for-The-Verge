//
//  DetailViewController.swift
//  ConceptGameNewsApp
//
//  Created by Devin Yancey on 6/16/17.
//  Copyright © 2017 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    var image : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerImage.image = image
    }
}
