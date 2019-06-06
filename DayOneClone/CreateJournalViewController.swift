//
//  CreateJournalViewController.swift
//  DayOneClone
//
//  Created by Ricardo Hui on 5/6/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit

class CreateJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var narBar: UINavigationBar!
    
    @IBOutlet var journalTextView: UITextView!
    
    @IBOutlet var setDateButton: UIButton!
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var datePicker: UIDatePicker!
    
    var date = Date()
    var imagePicker = UIImagePickerController()
    var images: [UIImage] = []
    var startWithCamera = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        narBar.barTintColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // 4cc1fc
        narBar.tintColor = .white
        narBar.isTranslucent = false
        narBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide)
            , name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow)
            , name: UIResponder.keyboardWillShowNotification, object: nil)
        
        imagePicker.delegate = self
    }
    
    @objc func keyboardWillHide(notification: Notification){
        print("keyboardWillHide")
        changeKeyboardHeight(notification: notification)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        print("keyboardWillShow")
        changeKeyboardHeight(notification: notification)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            images.append(chosenImage)
            
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
            imageView.image = chosenImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true) {
                //annimation
            }
        }
    }
    
    func changeKeyboardHeight(notification: Notification){
        print("changeKeyboardHeight")
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            print("keyboardFrame found")
            let keyHeight = keyboardFrame.cgRectValue.height
            bottomConstraint.constant  =  -keyHeight - 10
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDate()
    }

    override func viewDidAppear(_ animated: Bool) {
        if startWithCamera {
            startWithCamera = false
            cameraTapped("")
        }
    }
    func updateDate(){
        let formatter  = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        narBar.topItem?.title = formatter.string(from: date)
    }
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
    }
    
    
    @IBAction func setDateTapped(_ sender: Any) {
        journalTextView.isHidden  = false
        datePicker.isHidden  = true
        setDateButton.isHidden = true
        date = datePicker.date
        updateDate()
    }
    
    
    
    @IBAction func calendarTapped(_ sender: Any) {
        journalTextView.isHidden  = true
        datePicker.isHidden  = false
        setDateButton.isHidden = false
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
}
