//
//  ViewController.swift
//  MemeApp
//
//  Created by MACBOOK PRO on 10/31/22.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate, UITextFieldDelegate {
   
    @IBOutlet weak var TopToolBar: UIToolbar!
    @IBOutlet weak var BottomToolBar: UIToolbar!
    @IBOutlet weak var TopText: UITextField!
    @IBOutlet weak var BottomText: UITextField!
    @IBOutlet weak var ImagePickerView: UIImageView!
    
    @IBOutlet weak var CameraButton: UIButton!

    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var ActivityButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        TopText.text = "TOP"
        BottomText.text = "BOTTOM"
    
        TopText.defaultTextAttributes = memeTextAttributes
        BottomText.defaultTextAttributes = memeTextAttributes
        TopText.textAlignment = .center
        BottomText.textAlignment = .center

    }
   
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
        NSAttributedString.Key.strokeWidth: 3.0
    ]
    
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        

        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        CameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func CancelEditing(_ sender: Any) {
        ImagePickerView.image = nil
        TopText.text = "TOP"
        BottomText.text = "BOTTOM"
        ActivityButton.isEnabled = false
        dismiss(animated: false, completion: nil)
    }
    
    
    func PickAnImage (Source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = Source
        self.present(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func PickImageFromCamera(_ sender: Any) {
        PickAnImage(Source: .camera)
    }
    
   
    @IBAction func PickAnImageFromAlbum(_ sender: Any) {
        PickAnImage(Source: .photoLibrary)
    }
    
    @IBAction func ActvityControl(_ sender: Any) {
        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil )
        controller.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
                ImagePickerView.image = image
            }
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {

        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
        func keyboardWillHide(_ notification:Notification) {
      
         view.frame.origin.y = 0
     
     }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
   
    struct Meme {
        var TopText : String
        var BottomText : String
        var originalImage : UIImage
        var memedImage : UIImage
    }
    
    
   func save() {
        // Create the meme
       _ = Meme(TopText: TopText.text!, BottomText: BottomText.text!, originalImage: ImagePickerView.image!, memedImage: generateMemedImage())
      }
    
    
       func generateMemedImage() -> UIImage {
           /* toolbar
           topToolBar.isHidden = true
           bottomToolBar.isHidden = true
           */
           // Render view to an image
           UIGraphicsBeginImageContext(self.view.frame.size)
           view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
           let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()
           
           
           /* toolbar
           topToolBar.isHidden = false
           bottomToolBar.isHidden = false
           */

           return memedImage
       }
    

    
}
    
    
    


