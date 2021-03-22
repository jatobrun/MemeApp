//
//  ViewController.swift
//  MemeAppV1
//
//  Created by Jamil Torres on 17/3/21.
//

import UIKit

class MemeEditViewController: UIViewController, UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // Variables
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -5
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUptextField(textField: bottomText, text: "BOTTOM")
        setUptextField(textField: topText, text: "TOP")
        
        shareButton.isEnabled = false
        cancelButton.isEnabled = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagePickerView.contentMode = .scaleAspectFit
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func galleryButtonAction(_ sender: Any) {
        presentPickerViewController(source: .photoLibrary)
        
    }
    
    @IBAction func photoButtonAction(_ sender: Any) {
        presentPickerViewController(source: .camera)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                print("Cancel the activity view")
                return
            }
            self.save()
        }
        present(controller, animated: true, completion: nil)
    }
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func save(){
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memeImage: generateMemedImage())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("Image save")
        appDelegate.memes.append(meme)
        
        
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    @objc func keyboardWillShow(_ notification:Notification) {

        view.frame.origin.y -= getKeyboardHeight(notification)
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    func generateMemedImage() -> UIImage {
        
        hideNavBarAndToolBar(isHide: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideNavBarAndToolBar(isHide: false)
        return memedImage
    }
    func hideNavBarAndToolBar(isHide: Bool){
        navBar.isHidden = isHide
        toolBar.isHidden = isHide
    }

    func setUptextField(textField:UITextField!, text: String!){
        textField.text = text
        textField.textAlignment = .center
        textField.defaultTextAttributes = memeTextAttributes
        textField.autocapitalizationType = .allCharacters
        textField.delegate = self
    }
    func presentPickerViewController(source: UIImagePickerController.SourceType){
        let controller = UIImagePickerController()
        controller.sourceType = source
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
}
extension MemeEditViewController:UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Hola")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePickerView.image = image
        }
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
}

extension MemeEditViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.text {
        case "BOTTOM":
            textField.text = ""
        case "TOP":
            textField.text = ""
        default:
            print("Error")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
