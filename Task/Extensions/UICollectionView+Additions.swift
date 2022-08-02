//
//  UICollectionView+Additions.swift
//  Task
//
//  Created by LALITHA KONDA on 01/08/22.
//

import Foundation
import UIKit

public protocol ClassNameProtocol{
    static var className: String { get }
    var className: String { get }
}
public extension ClassNameProtocol{
    static var className: String{
        return String(describing: self)
    }
    var className: String{
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol{}

extension UICollectionView{
    func register<T: UICollectionViewCell>(cellType: T.Type){
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }
    func dequeReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T{
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    func registerHeaderFooter<T: UICollectionReusableView>(HeaderFooterType: T.Type) {
        let className = HeaderFooterType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    func registerFooter<T: UICollectionReusableView>(HeaderFooterType: T.Type) {
        let className = HeaderFooterType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
}
