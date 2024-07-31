//
//  TopViewController.swift
//  Translation_API_UIKit_Sample
//
//  Created by takahashi.shiko on 2024/07/15.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

final class TopViewController: UITableViewController {
    
    private enum RowType: Int, CaseIterable {
        case uikit
        case flutter
        
        func title() -> String {
            switch self {
            case .uikit:
                return "UIKit"
            case .flutter:
                return "Flutter (Add To App)"
            }
        }
    }
    
    private var flutterVC: FlutterViewController?
    private var shouldRefreshFlutterVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Translation API Demo"
        
        if let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine {
            flutterVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        }
    }
}

/// TableView DataSource and Delegate
extension TopViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = RowType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = rowType.title()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowType = RowType(rawValue: indexPath.row) else {
            return
        }
        
        switch rowType {
        case .uikit:
            let storyboard = UIStoryboard(name: "Translation", bundle: nil)
            guard let translationVC = storyboard.instantiateViewController(withIdentifier: "TranslationViewController") as? TranslationViewController else {
                return
            }
            
            navigationController?.pushViewController(translationVC, animated: true)
        case .flutter:
            guard let flutterVC else {
                return
            }
            
            if (shouldRefreshFlutterVC) {
                // refresh flutter screen
                flutterVC.pushRoute("/")
            }
            
            shouldRefreshFlutterVC = true
            navigationController?.pushViewController(flutterVC, animated: true)
        }
    }
}
