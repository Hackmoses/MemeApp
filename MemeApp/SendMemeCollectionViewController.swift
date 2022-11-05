//
//  SendMemeCollectionViewController.swift
//  MemeApp
//
//  Created by MACBOOK PRO on 11/5/22.
//


import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

                let space:CGFloat = 3.0
                let dimension = (view.frame.size.width - (2 * space)) / 3.0
                return CGSize(width: dimension, height: dimension)
            }

            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 3
            }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 3
            }

            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

              if collectionView.numberOfItems(inSection: section) == 1 {

                   let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

                  return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width)

              }

              return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

          }
    }
}
