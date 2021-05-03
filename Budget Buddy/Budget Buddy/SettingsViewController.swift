//
//  SettingsViewController.swift
//  Budget Buddy
//
//  Created by Haimid Alrobaye on 4/28/21.
//

import UIKit
struct Section {
    let title: String
    let options: [SettingsOptionType]
}
enum SettingsOptionType {
    case switchcell(model: SettingsSwitchOption)
    case staticcell(model: SettingsOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
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
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
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
    }
    
    func configure() {
        models.append(Section(title: "Appearance", options: [
                                .switchcell(model: SettingsSwitchOption(title: "Dark Mode", icon: UIImage(systemName: "eyes"), iconBackgroundColor: .systemPink, handler: {
                                    
                                }, isOn: true)),
           
                                ]))
        models.append(Section(title: "General", options: [
            .staticcell(model: SettingsOption(title: "Edit Profile", icon: UIImage(systemName: "figure.wave"), iconBackgroundColor: .systemPink) {
                self.performSegue(withIdentifier: "LinkBank", sender: nil)
            }),
            .staticcell(model: SettingsOption(title: "Link Your Bank", icon: UIImage(systemName: "link.badge.plus"), iconBackgroundColor: .systemPink){
                
            }),
            .staticcell(model: SettingsOption(title: "Notifications", icon: UIImage(systemName: "iphone.radiowaves.left.and.right"), iconBackgroundColor: .systemPink){
                
            })
        ]))
        models.append(Section(title: "Information", options: [
                                .staticcell(model: SettingsOption(title: "Privacy", icon: UIImage(systemName: "person.icloud"), iconBackgroundColor: .systemPink) {
                
            }),
                                .staticcell(model: SettingsOption(title: "Security", icon: UIImage(systemName: "lock.icloud"), iconBackgroundColor: .systemPink){
                
            }),
                                .staticcell(model: SettingsOption(title: "Help", icon: UIImage(systemName: "arrow.up.message"), iconBackgroundColor: .systemPink){
                
            }),
                                .staticcell(model: SettingsOption(title: "About", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemPink){
                
            })
        ]))
        models.append(Section(title: "Account", options: [
                                .staticcell(model: SettingsOption(title: "Sign In Preferences", icon: UIImage(systemName: "key.icloud"), iconBackgroundColor: .systemPink){
                
            }),
                                .staticcell(model: SettingsOption(title: "Logout", icon: UIImage(systemName: "iphone.slash"), iconBackgroundColor: .systemPink){
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.setValue(false, forKey: "LoggedIn")
                                    
                                })
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
        switch model.self{
        case .staticcell(let model):
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
        case .switchcell(model: let model):
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else{
                
                return UITableViewCell()
            
            }
            cell.configure(with: model)
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticcell(let model):
            model.handler()
        case .switchcell(let model):
            model.handler()
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
}
