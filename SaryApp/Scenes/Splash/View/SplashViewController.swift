//
//  SplashViewController.swift
//  RobinAcademy
//
//  Created by Mahmoud Farag on 10/4/22.
//

import UIKit


class SplashViewController: UIViewController {
    
    @IBOutlet weak var animatedImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigateToHome()
    }
    
    func navigateToHome(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            NavigationManager.navigateHomeScreen()
        })
    }
}
