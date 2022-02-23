//
//  SceneDelegate.swift
//  connectivity
//
//  Created by Ivan Stajcer on 22.02.2022..
//

import UIKit
import WatchConnectivity

class SceneDelegate: UIResponder, UIWindowSceneDelegate, WCSessionDelegate {
    var window: UIWindow?
    let wcSession = WCSession.default
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("@session did complete with: acctivation state: ", activationState.rawValue)
        guard activationState == .activated else {
            print("Session is not activated.")
            return
        }
        print("Is paired: ", wcSession.isPaired)
        print("Is app installed: ", wcSession.isWatchAppInstalled)
        print("Is reachable: ", wcSession.isReachable)
        let message = ["data": ["aaaa","bbbb","cccc","dddd"]]
        do {
            try wcSession.updateApplicationContext(message)
            wcSession.sendMessage(message, replyHandler: nil, errorHandler: nil)
            print("Updated application context :D ")
        } catch {
            print("Error while updating application context :(")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("@session did becomee inactive: ", session)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("@session did deactivate: ", session)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Check if session is supported and activate it, oon iPad for ex dont support watches, so its not supported.
        if(WCSession.isSupported()) {
            wcSession.delegate = self
            wcSession.activate()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

