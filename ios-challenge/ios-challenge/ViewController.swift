//
//  ViewController.swift
//  ios-challenge
//
//  Created by Ali Hamdi on 28/04/2018.
//  Copyright © 2018 Ali Hamdi. All rights reserved.
//

import UIKit

struct iosEx: Decodable{
    let title: String
    let articles: [Article]
}
struct Article: Decodable{
    let title: String
    let content: String
    let image_url: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var articlesTV: UITableView!
    
    var articles =  [Article]()
//    var exercise = iosEx()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJSON ()
        articlesTV.rowHeight = UITableViewAutomaticDimension
       
        
        articlesTV.delegate = self
        articlesTV.dataSource = self
        
//        articlesTV.estimatedRowHeight = 50
//        articlesTV.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // -1 for the empty cell, hence: I should check for how many cells are empty and subtract it.
        return articles.count - 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = articlesTV.dequeueReusableCell(withIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.titleLbl.text = articles[indexPath.row].title
        cell.contentLbl.text = articles[indexPath.row].content
        cell.imageView?.downloadedFrom(link: articles[indexPath.row].image_url)
        cell.titleLbl.numberOfLines = 0
        cell.contentLbl.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "IOS"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleViewController{
            destination.art = articles[(articlesTV.indexPathForSelectedRow?.row)!]
        }
    }    
    
    // function to download the JSON request.
    
    func fetchJSON(){
        let json_url = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
        guard let url  = URL(string: json_url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else{ return }
            if error == nil{
                do{
                    let content = try JSONDecoder().decode(iosEx.self, from: data)
                    self.articles = content.articles
                    DispatchQueue.main.async {
                        self.articlesTV.reloadData()
                    }
                }catch {
                    print("JSON Error!")
                }
            }
        }.resume()
    
    }
    
    

}

