//
//  MemeDetailController.swift
//  MemeApp
//
//  Created by MACBOOK PRO on 11/5/22.
//

import Foundation
import UIKit


class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    
    
    @IBOutlet weak var memedImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(false, animated: true)
        self.memedImage.image = self.meme.memedImage
    }
    
    
}

