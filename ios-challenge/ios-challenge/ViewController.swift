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

var refresher : UIRefreshControl!

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var articlesTV: UITableView!
    
    var articles =  [Article]()
//    var exercise = iosEx()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        articlesTV.rowHeight = UITableViewAutomaticDimension
        fetchJSON ()
        
        articlesTV.delegate = self
        articlesTV.dataSource = self
        
        articlesTV.estimatedRowHeight = 50
        articlesTV.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = articlesTV.dequeueReusableCell(withIdentifier: "cell")
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = articles[indexPath.row].title
        cell.detailTextLabel?.text = articles[indexPath.row].content
        cell.imageView?.downloadedFrom(link: articles[indexPath.row].image_url)
        cell.textLabel?.numberOfLines = 0
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

