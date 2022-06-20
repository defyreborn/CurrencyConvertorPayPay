//
//  BaseViewController.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/15/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func prepareView() {

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        //Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        //Swipe Gesture
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

//        Bundle.setLanguage("en")
        
        //Right to Left
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
        //Left to Right
//        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }
    
    
    func showAlert(withMessage message: String?, preferredStyle: UIAlertController.Style = .alert, withActions actions: UIAlertAction...) {
        let alert = UIAlertController(title: AppName, message: message, preferredStyle: preferredStyle)
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
