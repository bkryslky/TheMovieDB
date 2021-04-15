//
//  Identifiable.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation
import UIKit

protocol Identifiable {
  static var identifier: String {get}
}

extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}

extension UIView:Identifiable{}

extension UITableViewCell: Identifiable {}

extension UICollectionViewCell: Identifiable {}

extension UICollectionReusableView: Identifiable {}

extension UIViewController: Identifiable {}

extension UITableView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UITableViewCell {
    register(UINib(nibName: T.identifier, bundle: Bundle.main), forCellReuseIdentifier: T.identifier)
  }
}

extension UICollectionView {
  func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
  
  func register<T>(type: T.Type) where T: UICollectionViewCell {
    register(UINib(nibName: T.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: T.identifier)
  }
  
  func registerSupplementaryView<T>(_: T.Type, ofKind kind: String)  where T: UICollectionReusableView {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
  }
  
  func registerSupplementaryViewFromNib<T>(_: T.Type, ofKind kind: String) where T: UICollectionReusableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.identifier, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
  }

  func dequeueSupplementaryView<T>(ofKind kind: String, `for` indexPath: IndexPath) -> T where T: UICollectionReusableView {
    guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Could not dequeue supplementary view of kind: \(kind) with identifier: \(T.identifier)")
    }
    return view
  }
}

extension UIStoryboard {
  func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
    guard let viewController = instantiateViewController(withIdentifier: type.identifier) as? T else {
      fatalError()
    }
    return viewController
  }
}

extension UIViewController {
  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T.init(nibName: T.identifier, bundle: nil)
    }
    
    return instantiateFromNib()
  }
    func loading(status:Bool) {
        if status{
            IndicatorView.sharedInstance.showIndicator()
        }else{
            IndicatorView.sharedInstance.hideIndicator()
        }
    }
}
