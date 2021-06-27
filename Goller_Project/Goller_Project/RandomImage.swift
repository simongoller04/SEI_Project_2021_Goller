//
//  RandomImage.swift
//  Goller_Project
//
//  Created by Simon Goller on 26.06.21.
//

import UIKit

class RandomImage: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    let dispatchGroup = DispatchGroup()
    var url = URL(string: "https://source.unsplash.com/random/400x400")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadIndicator.color = .black
        loadIndicator.startAnimating()
        
        dispatchGroup.notify(queue: .main) {
            self.loadImage()
            self.loadIndicator.stopAnimating()
        }
    }
    
    func loadImage() {
        dispatchGroup.enter()
        
        let data = try? Data(contentsOf: url!)
        ImageView.image = UIImage(data: data!)
        
        dispatchGroup.leave()
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        loadIndicator.startAnimating()
        
        dispatchGroup.notify(queue: .main) {
            self.loadImage()
            self.loadIndicator.stopAnimating()
        }
    }
}
