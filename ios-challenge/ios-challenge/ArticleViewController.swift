//
//  ArticleViewController.swift
//  ios-challenge
//
//  Created by Ali Hamdi on 30/04/2018.
//  Copyright © 2018 Ali Hamdi. All rights reserved.
//

import UIKit

/* an extension from https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
 that let download images from the web
 */

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class ArticleViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
//    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var art: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.numberOfLines = 0
        
        titleView.text = art?.title
        textView.text = art?.content
        let urlString = (art?.image_url)!
        let url = URL(string: urlString)
        imageView.downloadedFrom(url: url!)
        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
