//
//  SplashViewController.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    var splashView = SplashView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = .white
        
        checkInternetConnection()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Check Internet Connection
    func checkInternetConnection() {
        Connectivity.isConnectedToInternet() ? remoteConfigFetch() : showConnectionAlertView(title: "Warning", message: "Please check your internet", okClicked: {
            self.checkInternetConnection()
        })
    }
    
    //Firebase
    func remoteConfigFetch() {
        if FirebaseValues.sharedInstance.fetchComplete {
            getAppLabelFromFirebase()
        }
        FirebaseValues.sharedInstance.loadingDoneCallback = getAppLabelFromFirebase
    }
    func getAppLabelFromFirebase() {
        
        let text = FirebaseValues.sharedInstance.string(forKey: .appLabelText)
        
        splashView.loodosLabel.text = text
        self.view = splashView
        
        createTimer()
    }
    //End Firebase
    
    
    
    var timer = Timer()
    
    func createTimer() {
       timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(pushToMainViewWithAnimation), userInfo: nil, repeats: false)
    }
    
    
    @objc func pushToMainViewWithAnimation() {
        let mainVC = MainViewController()
        let navController = UINavigationController(rootViewController: mainVC)
        
        
        let snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true))!
        navController.view.addSubview(snapshot);
        
        UIApplication.shared.keyWindow?.rootViewController = navController;
        UIView.transition(with: snapshot, duration: 2 , options: .transitionCrossDissolve, animations: {
            snapshot.layer.opacity = 0;
        }, completion: { (status) in
            snapshot.removeFromSuperview()
        })
    }
}
