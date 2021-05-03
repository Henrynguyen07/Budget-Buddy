//
//  SettingsViewController.swift
//  Budget Buddy
//
//  Created by Haimid Alrobaye on 4/28/21.
//

import UIKit
struct Section {
    let title: String
    let options: [SettingsOption]
}
struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame =  view.bounds
        // Do any additional setup after loading the view.
    }
    
    func configure(){
        models.append(Section(title: "General", options: [
            SettingsOption(title: "Edit Profile", icon: UIImage(systemName: "figure.wave"), iconBackgroundColor: .systemPink) {
                self.performSegue(withIdentifier: "LinkBank", sender: nil)
            },
            SettingsOption(title: "Link Your Bank", icon: UIImage(systemName: "link.badge.plus"), iconBackgroundColor: .systemPink){
                
            },
            SettingsOption(title: "Notifications", icon: UIImage(systemName: "iphone.radiowaves.left.and.right"), iconBackgroundColor: .systemPink){
                
            }
        ]))
        models.append(Section(title: "Information", options: [
            SettingsOption(title: "Privacy", icon: UIImage(systemName: "person.icloud"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "Security", icon: UIImage(systemName: "lock.icloud"), iconBackgroundColor: .systemPink){
                
            },
            SettingsOption(title: "Help", icon: UIImage(systemName: "arrow.up.message"), iconBackgroundColor: .systemPink){
                
            },
            SettingsOption(title: "About", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemPink){
                
            }
        ]))
        models.append(Section(title: "Account", options: [
            SettingsOption(title: "Sign In Preferences", icon: UIImage(systemName: "key.icloud"), iconBackgroundColor: .systemPink){
                
            },
        SettingsOption(title: "Logout", icon: UIImage(systemName: "iphone.slash"), iconBackgroundColor: .systemPink){
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.setValue(false, forKey: "LoggedIn")
                                    
                                }
        ]))
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = models[section]
        return model.title
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    @IBAction func darkMode(_ sender: Any) {
        super.viewDidLoad()
        if self.traitCollection.userInterfaceStyle == .light {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
