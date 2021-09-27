//
//  ChatManager.swift
//  Example
//
//  Created by Rahardyan Bisma on 19/05/20.
//  Copyright © 2020 qiscus. All rights reserved.
//

import Foundation
import UIKit
import QiscusMultichannelWidget
import QiscusCore
import Localize_Swift

enum ChatTransitionType {
    case push(animated: Bool)
    case present(animated: Bool, completion: (() -> Void)? = nil)
}

final class ChatManager {
    static let shared: ChatManager = ChatManager()
    lazy var qiscusWidget: QiscusMultichannelWidget = {
       return QiscusMultichannelWidget(appID: "hat-ppxmocchbbcbhopzk")
    }()
    
    func setUser(id: String, displayName: String, avatarUrl: String = "", userProperties :  [[String:Any]]? = nil) {
        qiscusWidget.setUser(id: id, displayName: displayName, avatarUrl: avatarUrl, userProperties: userProperties)
    }
    
    func getUser() ->QAccount?{
        return qiscusWidget.getUser()
    }
    
    func signOut() {
        qiscusWidget.clearUser()
    }
    
    func isLoggedIn() -> Bool {
        return qiscusWidget.isLoggedIn()
    }
    
    func startChat(from viewController: UIViewController, extras: String = "", transition: ChatTransitionType = .push(animated: true)) {
        
        qiscusWidget.initiateChat()
            .setRoomTitle(title: "TITLE".localized())
            .setRoomSubTitle(enableSubtitle: RoomSubtitle.enable, subTitle: "SUBTITLE".localized())
            .startChat { (chatViewController) in
                viewController.navigationController?.setViewControllers([viewController, chatViewController], animated: true)
        }
        
    }
    
    func register(deviceToken: Data?) {
        if let deviceToken = deviceToken {
            var tokenString: String = ""
            for i in 0..<deviceToken.count {
                tokenString += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
            }
            print("token = \(tokenString)")
            //isDevelopment = true : for development or running from XCode
            //isDevelopment = false : release mode TestFlight or appStore
            
            self.qiscusWidget.register(deviceToken: tokenString, isDevelopment : false, onSuccess: { (response) in
                print("Multichannel widget success to register device token")
            }) { (error) in
                print("Multichannel widget failed to register device token")
            }
        }
    }
    
    
    func userTapNotification(userInfo : [AnyHashable : Any]) {
        self.qiscusWidget.handleNotification(userInfo: userInfo, removePreviousNotif: true)
//        .startChat(withRoomId: <#T##String#>, callback: <#T##(UIViewController) -> Void#>)
    }
}
