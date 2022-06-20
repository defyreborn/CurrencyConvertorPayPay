//
//  TableView+Extension.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/20/22.
import Foundation
import UIKit

extension UITableViewCell {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}

extension UITableView {
    
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
    
    func updateFooterViewHeight() {
        if let footer = self.tableFooterView {
            let newSize = footer.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            footer.frame.size.height = newSize.height
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorStyle = .none
    }
    
    func registerAndGet<T:UITableViewCell>(cell identifier:T.Type) -> T?{
        let cellID = String(describing: identifier)
        
        if let cell = self.dequeueReusableCell(withIdentifier: cellID) as? T {
            return cell
        } else {
            //regiser
            self.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
            return self.dequeueReusableCell(withIdentifier: cellID) as? T
            
        }
    }
    
    func register<T:UITableViewCell>(cell identifier:T.Type) {
        let cellID = String(describing: identifier)
        self.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    func getCell<T:UITableViewCell>(identifier:T.Type) -> T?{
        let cellID = String(describing: identifier)
        guard let cell = self.dequeueReusableCell(withIdentifier: cellID) as? T else {
            print("cell not exist")
            return nil
        }
        return cell
    }
    
    //Top -> Bottom
    func reloadWithTopToBottomAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -(tableViewHeight + 50))
        }
        for cell in cells {
            UIView.animate(withDuration: 1, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .transitionFlipFromBottom, animations: {
                cell.transform = CGAffineTransform.identity
                
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    //Bottom -> Top
    func reloadWithBottomToTopAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .transitionFlipFromBottom, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    //Right -> Left
    func reloadWithAnimationRightToLeft() {
        self.reloadData()
        let tableViewWidth = self.bounds.size.width
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    //Left -> Right
    func reloadWithAnimationLeftToRight() {
        self.reloadData()
        let tableViewWidth = self.bounds.size.width
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: -tableViewWidth, y: 0)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    func setupEmptyMessage(message: String){
        guard let emptyLabel = self.backgroundView as? UILabel else{
            self.layoutIfNeeded()
            let label = UILabel.init(frame: self.bounds)
            label.textAlignment = .center
            label.text = message
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 15)
            self.backgroundView = label
            return
        }
        emptyLabel.text = message
    }
    
}
