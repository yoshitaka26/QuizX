//
//  SettingTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/11/25.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    @IBOutlet weak var nameLabel: UITableViewCell!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultsの情報を画面にセットする
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            nameLabel.textLabel?.text = name
        }
        
        //アプリバージョン
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionLabel.text = version
        }
        
        // UserDefaultsの変更を監視する
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    @objc func userDefaultsDidChange(_ notification: Notification) {
        // UserDefaultsの変更があったので画面の情報を更新する
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            nameLabel.textLabel?.text = name
        }
    }
    
    deinit {
        // UserDefaultsの変更の監視を解除する
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
    
    
}
