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
        
        setUpTextField(TopText, text: "TOP")
        setUpTextField(BottomText, text: "BOTTOM")
        
    }
    
    func setUpTextField(_ textField: UITextField, text: String) {
        textField.text = text
        textField.defaultTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor.black,
            .strokeWidth: -3.0
        ]
        textField.textAlignment = .center
        textField.delegate = self
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        CameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
       
    }
    
    
    @IBAction func CancelEditing(_ sender: Any) {
        ImagePickerView.image = nil
        TopText.text = "TOP"
        BottomText.text = "BOTTOM"
        ActivityButton.isEnabled = false
        dismiss(animated: false, completion: nil)
    }
    
    
    func pickAnImage (Source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = Source
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func PickImageFromCamera(_ sender: Any) {
        pickAnImage(Source: .camera)
    }
    
    
    @IBAction func PickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(Source: .photoLibrary)
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
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
   
    
    
    func save() {
        // Create the meme
        _ = Meme(TopText: TopText.text!, BottomText: BottomText.text!, originalImage: ImagePickerView.image!, memedImage: generateMemedImage())
    }
    
    func toolBarVisability(hidden: Bool)
        {
            self.TopToolBar.isHidden = hidden
            self.BottomToolBar.isHidden = hidden
        }
    
    func generateMemedImage() -> UIImage {
        
        toolBarVisability(hidden: true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        toolBarVisability(hidden: false)
        
        return memedImage
    }
    
    
    
}





