//
//  ViewController.swift
//  MemeApp
//
//  Created by MACBOOK PRO on 10/31/22.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var TopText: UITextField!
  
    
    @IBOutlet weak var BottomText: UITextField!
    
    
    @IBOutlet weak var ImagePickerView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TopText.text = "TOP"
        BottomText.text = "BOTTOM"
        TopText.textAlignment = .center
        BottomText.textAlignment = .center
       
    }
    
    func PickAnImage (Source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = Source
        self.present(imagePicker, animated: true, completion: nil)
    }
   
    /* --From Camera
    @IBAction func PickAnImageFromCamera(_ sender: Any) {
        PickAnImage(Source: .camera)
    }
    */
    
    @IBAction func PickAnImageFromAlbum(_ sender: Any) {
        PickAnImage(Source: .photoLibrary)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
                ImagePickerView.image = image
            }
    }
    
    
    /*override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    */
}

