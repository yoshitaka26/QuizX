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

    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
            
        default:
            return 0
        }
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
