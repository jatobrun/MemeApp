//
//  MemeCollectionViewController.swift
//  MemeAppV1
//
//  Created by Jamil Torres on 21/3/21.
//

import UIKit

class MemeCollectionViewController: UIViewController {
    
    //Variables
    var memes:[Meme]! { 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
        
    }
    //Outlets
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var flowLayout:UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }

}

extension MemeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        if let cellImage = cell.imageView{
            cellImage.image = meme.memeImage
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(identifier: "memeDetailVC") as! MemeDetailViewController
        controller.image = memes[indexPath.row].memeImage
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
