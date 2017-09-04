//
//  ViewController.swift
//  ConceptGameNewsApp
//
//  Created by Devin Yancey on 6/15/17.
//  Copyright © 2017 Devin Yancey. All rights reserved.
//

import UIKit
import AlamofireImage
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var articleArray : [Article] = []
    var originFrame = CGRect()
    var alphaBlur = UIView()
    let transition = PopAnimator()
    var selectedImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = "Polygon Top Stories"
        let navigationTitleFont = UIFont(name: "Avenir", size: 20)!
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "header"), for: .default)
        //navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        // Do any additional setup after loading the view, typically from a nib.
        JSONManager.getArtiticles(urlstring: StringLiterals.polygoneTopURLString) { (articles) in
            if articles != nil{
                self.articleArray = articles!
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //perform
        //present details view controller
        originFrame = (tableView.cellForRow(at: indexPath) as! ArticleCell).articleImage.bounds
        selectedImage = (tableView.cellForRow(at: indexPath) as! ArticleCell).articleImage
        //present details view controller
        let newsDetails = storyboard!.instantiateViewController(withIdentifier: "test") as! UINavigationController
        let detail = storyboard!.instantiateViewController(withIdentifier: "detailedView") as! DetailViewController
        detail.image = selectedImage.image
        newsDetails.setViewControllers([detail], animated: false)
        //herbDetails.herb = selectedHerb
        newsDetails.transitioningDelegate = self
        
        present(newsDetails, animated: true, completion: nil)
        /*
        let article = articleArray[indexPath.row]
        let detailView = view.instanceFromNib(name: "DetailedView") as! DetailView
        if let url = URL(string: article.urlToArticleString ?? ""){
            detailView.url = url
        }
        
        if let title = article.title{
            detailView.title.text = title
        }
        
        if let url = URL(string: article.imageURLString ?? ""){
            detailView.imgView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "blank"))
            detailView.layer.masksToBounds = true
        }
        
        if let description = article.description{
            detailView.descriptionLbl.text = description
        }
        
        if let author = article.author{
            detailView.author.text = "By: \(author)"
        }
        
        
        
        detailView.frame = CGRect(x: (view.frame.width/2) - ((view.frame.width * 0.8)/2), y: (view.frame.height/2) - ((view.frame.height * 0.6)/2), width: view.frame.width * 0.8, height: view.frame.height * 0.6)
        detailView.layer.cornerRadius = 5
        //addDetailScreen(detailView: detailView)
        applyBlurEffect(detailView: detailView)
 */
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad{
            if indexPath.row == 0 {
                return 375
            }
            if indexPath.row % 6 == 0{
                return 350
            }
            return 175
        }
        if indexPath.row == 0 {
            return 250
        }
        if indexPath.row % 6 == 0{
            return 225
        }
        return 100
    }
    
    private func applyBlurEffect(detailView: DetailView){
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(dismissDetailView))
        alphaBlur.addGestureRecognizer(tapGesture)
        alphaBlur.frame = view.bounds
        alphaBlur.alpha = 0.0
        blur.frame = alphaBlur.bounds
        alphaBlur.addSubview(blur)
        view.addSubview(alphaBlur)
        UIView.animate(withDuration: 0.2) {
            self.alphaBlur.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0.2, animations: { 
            self.alphaBlur.alpha = 1.0
        }) { (done) in
            self.addDetailScreen(detailView: detailView)
        }
    }
    
    private func addDetailScreen(detailView: DetailView){
        let endFrame = detailView.frame
        detailView.frame = CGRect(x: endFrame.origin.x, y: view.frame.height, width: endFrame.width, height: endFrame.height)
        alphaBlur.addSubview(detailView)
        UIView.animate(withDuration: 0.3) {
            detailView.frame = endFrame
        }
    }
    
    @objc private func dismissDetailView(_ sender: UITapGestureRecognizer){
        var detailView = DetailView()
        for subview in alphaBlur.subviews{
            if subview is DetailView{
                detailView = subview as! DetailView
            }
        }
        UIView.animate(withDuration: 0.3, animations: { 
            detailView.frame = CGRect(x: detailView.frame.origin.x, y: -detailView.frame.height, width: detailView.frame.width, height: detailView.frame.height)
        }) { (done) in
            UIView.animate(withDuration: 0.2, animations: { 
                self.alphaBlur.alpha = 0.0
            }, completion: { (done) in
                for subview in self.alphaBlur.subviews{
                    subview.removeFromSuperview()
                }
                self.alphaBlur.removeFromSuperview()
            })
        }
    }
 
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ArticleCell()
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "mainArticleCell", for: indexPath) as! ArticleCell
        }else if indexPath.row % 6 == 0{
            //change to accomadate for videos
            cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! ArticleCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        }
        
        //cell.publicationImage.af_setImage(withURL: publications[indexPath.row].url, placeholderImage: #imageLiteral(resourceName: "blank"))
        if let urlImage = articleArray[indexPath.row].imageURLString, let url = URL(string: urlImage){
            cell.articleImage.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "blank"))
        }
        
        if let titleDescription = articleArray[indexPath.row].title{
            cell.descriptionTitle.text = titleDescription
        }else{
            cell.descriptionTitle.text = ""
        }
        
        if let author = articleArray[indexPath.row].author{
            cell.author.text = "By: \(author)"
        }else{
            cell.author.text = ""
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController : DetailViewDelegate{
    func readMoreClicked(url: URL) {
        //let vc = UIViewController()
        
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = selectedImage.superview!.convert(selectedImage.frame, to: nil)
        
        transition.presenting = true
        //selectedImage!.isHidden = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

class ArticleCell : UITableViewCell{
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    
}
