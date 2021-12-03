//
//  SettingTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/11/25.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var labelScale: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scale = UserDefaults.standard.value(forKey: "labelScale") as? Int {
            labelScale.selectedSegmentIndex = scale
        }
        
        //アプリバージョン
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionLabel.text = version
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let storyboard = UIStoryboard(name: "QuizXWeb", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "QuizXWeb")
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                let storyboard = UIStoryboard(name: "QuizXWeb", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "QuizXWeb")
                if let webVC = vc as? QuizXWebViewController {
                    webVC.accessURL = "https://twitter.com/QuizXix"
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.section == 2 {
            let storyboard = UIStoryboard(name: "QuizXWeb", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "QuizXWeb")
            if let webVC = vc as? QuizXWebViewController {
                webVC.accessURL = "https://quizx.net/privacy-policy/"
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func labelScaleSelected(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "labelScale")
    }
}
