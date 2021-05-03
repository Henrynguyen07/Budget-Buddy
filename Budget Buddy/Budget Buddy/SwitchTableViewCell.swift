//
//  SwitchTableViewCell.swift
//  Budget Buddy
//
//  Created by Jose Lopez on 5/3/21.
//

import UIKit
 
class SwitchTableViewCell: UITableViewCell {
 
  static let identifier = "SwitchTableViewCell"
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds =  true
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let myswitch: UISwitch = {
        let myswitch = UISwitch()
    myswitch.onTintColor = .systemBlue
    return myswitch
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(myswitch)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        let imageSize: CGFloat  = size/1.5
        iconImageView.frame = CGRect(x: (size-imageSize)/2, y: (size-imageSize)/2, width: imageSize, height: imageSize)
        myswitch.sizeToFit()
        myswitch.frame = CGRect(x: (contentView.frame.size.width - myswitch.frame.size.width - 20), y: (contentView.frame.size.height - myswitch.frame.size.height)/2, width: myswitch.frame.size.width, height: myswitch.frame.size.height)
        label.frame = CGRect(x: 25 + iconContainer.frame.size.width, y: 0, width: contentView.frame.size.width - 20 - iconContainer.frame.size.width, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        myswitch.isOn = false
       
    }
    
    public func configure(with model: SettingsSwitchOption){
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        myswitch.isOn = model.isOn
    }
}
