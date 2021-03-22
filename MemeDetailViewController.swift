//
//  MemeDetailViewController.swift
//  MemeAppV1
//
//  Created by Jamil Torres on 21/3/21.
//

import UIKit

class MemeDetailViewController: UIViewController {
    //Outlets
    @IBOutlet weak var imageView:UIImageView!
    //Variables
    var image:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        imageView.image = image
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
