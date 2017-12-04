//
//  VerificationViewController.swift
//  Refined Dictation
//
//  Created by Admin on 03/11/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
//import Social

class VerificationViewController: UIViewController, UITextViewDelegate {
    // Properties
    var usrFilterLib: CommonFilter?
    var recording: SpeechRecog?
    var filtering: SpeechFilter?
    var finalRes: FinalResult?
    var isFavourite = false
    
    @IBOutlet weak var DisplayFilteredTextField: UITextView!
    @IBOutlet weak var Outline: UIButton!
    @IBOutlet weak var FavouriteButton: UIButton!
    @IBOutlet weak var ConfirmButton: UIBarButtonItem!
    @IBOutlet weak var ShareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DisplayFilteredTextField.text = filtering?.filteredResult
        DisplayFilteredTextField.delegate = self
        //DisplayFilteredTextField.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        FavouriteButton.isHidden = true
        ShareButton.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions

    @IBAction func TapShareButton(_ sender: Any) {
        DisplayFilteredTextField.resignFirstResponder() //dismiss keyboard
        
        // set up activity view controller
        let textToShare = [ DisplayFilteredTextField.text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func TapFavouriteButton(_ sender: Any) {
        if(isFavourite){
            FavouriteButton.setImage(UIImage(named: "hollowheart"), for: UIControlState.normal)
            isFavourite = false
            RecentDictsAndFavs.unFav((finalRes!.finalResult, nil, false))
        }
        else{
            FavouriteButton.setImage(UIImage(named: "solidheart"), for: UIControlState.normal)
            isFavourite = true
            RecentDictsAndFavs.newFav((finalRes!.finalResult, nil, true))
        }
    }
    
    @IBAction func TapConfirmButton(_ sender: Any) {
        if(ConfirmButton.isEnabled == true){
            ConfirmButton.isEnabled = false
            DisplayFilteredTextField.resignFirstResponder()
            finalRes?.editedResult = DisplayFilteredTextField.text
            DisplayFilteredTextField.isEditable = false
            FavouriteButton.isHidden = false
            ShareButton.isHidden = false
            finalRes?.updateIfEdited()
        }
    }
    
    
    // MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView){
        ConfirmButton.isEnabled = true
        DisplayFilteredTextField.frame.size.height = 262
        Outline.frame.size.height = 266
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        DisplayFilteredTextField.frame.size.height = 445
        Outline.frame.size.height = 449
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
 
    // MARK: Navigation
     @IBAction func unwindToVerificationView(sender: UIStoryboardSegue) {}
 

}
