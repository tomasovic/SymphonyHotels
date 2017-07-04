//
//  AppDelegate.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SymphonyHotels")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: Private API
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let _ = UserDefaults.standard.value(forKey: TOKEN) {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeTableViewController")
            let navigationController = UINavigationController(rootViewController: homeViewController)
            window?.rootViewController = navigationController
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
}

