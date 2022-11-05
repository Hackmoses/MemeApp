//
//  SendMemeTableViewController.swift
//  MemeApp
//
//  Created by MACBOOK PRO on 11/5/22.
//

import Foundation
import UIKit


class MemeTableViewCell: UITableViewCell {
    
    /*@IBOutlet weak var memeTitleLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
     
     */
}

class SentMemeTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = (meme.TopText + "..." + meme.BottomText)
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
