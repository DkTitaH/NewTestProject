//
//  AppDelegate.swift
//  TestTechnology
//
//  Created by iphonovv on 23.07.2020.
//  Copyright © 2020 iphonovv. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let urlBuilder = URLBuilder()
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let requestService = APIService(session: session, urlBuilder: urlBuilder)
        let networkService = NetworkService()
        let coordinator = AppCoordinator(requestService: requestService, networkService: networkService, isHiddenNavigatioBar: false)
        window.rootViewController = coordinator
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

