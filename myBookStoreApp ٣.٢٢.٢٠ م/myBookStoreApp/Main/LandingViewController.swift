//
//  LandingViewController.swift
//  myBookStoreApp
//
//  Created by Dua'a ageel on 23/05/1443 AH.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var changeLanguge: UISegmentedControl!
    {
        didSet {
        if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
            switch lang {
            case "ar":
                changeLanguge.selectedSegmentIndex = 1
            case "en":
                
                changeLanguge.selectedSegmentIndex = 0
            
            default:
                let localLang =  Locale.current.languageCode
                 if localLang == "en" {
                     changeLanguge.selectedSegmentIndex = 0
                     
                 } else {
                     changeLanguge.selectedSegmentIndex = 1
                 }
              
            }
        
        }else {
            let localLang =  Locale.current.languageCode
            UserDefaults.standard.setValue([localLang], forKey: "AppleLanguages")
             if localLang == "en" {
                 changeLanguge.selectedSegmentIndex = 0
             } else {
                 changeLanguge.selectedSegmentIndex = 1
             }
        }
    }
    }
    
    
    @IBOutlet weak var startButton: UIButton!
    
    {
        didSet {
            startButton.setTitle(NSLocalizedString("start", tableName: "Localizable", comment: ""), for: .normal)
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeLanguageAction(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
            if lang == "ar"{
               
             
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }else{
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                
            }
        }
    
    }
    

}


extension String {
    var localized: String {

        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
        
       
    }
}
