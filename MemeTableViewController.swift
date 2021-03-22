//
//  MemeTableViewController.swift
//  MemeAppV1
//
//  Created by Jamil Torres on 21/3/21.
//

import UIKit

class MemeTableViewController: UIViewController {
    //Variables
    var memes:[Meme]!{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}
extension MemeTableViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "MemeTableViewCell")
        let meme = memes[indexPath.row]
        if let cellImage = cell.imageView{
            cellImage.image = meme.memeImage
        }
        if let cellText = cell.textLabel{
            cellText.text = "\(meme.topText!) ... \(meme.bottomText!)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(identifier: "memeDetailVC") as! MemeDetailViewController
        controller.image = memes[indexPath.row].memeImage
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
