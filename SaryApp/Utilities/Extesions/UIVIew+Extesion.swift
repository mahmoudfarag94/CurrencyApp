//
//  View+Extension.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation
import UIKit
import Kingfisher
import Toast_Swift
import ProgressHUD
extension UICollectionView{
    
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle:Bundle? = nil){
        let className = String(describing: cellType.self)
        let nib = UINib(nibName: className, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath)->T{
        let className = String(describing: type.self)
        return self.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T
    }
}

extension UICollectionViewCell {
    func transformToLarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func transformToStandard() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
    }
    
}

extension UITableView{
    func registerCell<T: UITableViewCell>(type: T.Type, bundle: Bundle? = nil){
        let className = String(describing: type.self)
        let nib = UINib(nibName: className, bundle: nil)
        self.register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellType: T.Type ,for indexPath: IndexPath)-> UITableViewCell{
        let className = String(describing: cellType.self)
        return self.dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
    
    
    class func instanceFromNib(nibName: String) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension UIView{
    
    func addShadow(color: UIColor = .white, offest: CGSize = .zero){
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3
        self.layer.shadowColor = color.cgColor
    }
    
    @IBInspectable
    var circulate: Bool{
        set{
            self.layer.cornerRadius = self.frame.height/2
        }
        get{
            return self.circulate
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var minTopMaxBottomRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMaxYCorner]
        }
    }
    
    @IBInspectable
    var maxTopMinBottomRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMaxYCorner]
        }
    }
    
    @IBInspectable
    var topCorner :CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        }
    }
    
    @IBInspectable
    var leftCorner :CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMinXMinYCorner , .layerMinXMaxYCorner]
        }
    }
    
    @IBInspectable
    var rightCorner :CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMinYCorner , .layerMaxXMaxYCorner]
        }
    }
    
   
}

extension UIImageView {
    
    func setImage(with urlString: String, placeholder: UIImage? = nil){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: urlString), placeholder: placeholder ?? UIImage(named: "icon"))
    }
}

//MARK:- UIViewController
protocol Refreshable where Self: UIViewController {}
extension Refreshable {
    
    func Loading(){
        print("Loading")
        ProgressHUD.show()
    }
    
    func stopLoading(){
        print("stopLoading")
        ProgressHUD.dismiss()
    }
}

extension UIViewController: Refreshable{
    
    
    func showAlert( title: String? , message: String , okBtnTitle: String? , cancelBtnTitle: String? , okBtnAction: (()->())? ,  cancelBtnAction: (()->())?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //default titles for buttons if not passed
        let okTitle = okBtnTitle ?? NSLocalizedString("ok", comment: "")
        let cancelTitle = cancelBtnTitle ?? NSLocalizedString("cancel", comment: "")
        
        //alert ok button with default title and action
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action) in
            okBtnAction?()
        }))
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: cancelBtnAction)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func HandleError(error: BaseError, handler: (()->())? = nil) {
        switch error {
        case .validation(let msg):
            var style = ToastStyle()
            style.backgroundColor = .darkGray
            style.titleColor =  .white
            ToastManager.shared.style = style
            ToastManager.shared.isTapToDismissEnabled = true
            self.view.makeToast(msg, duration: 3.0, position: .center)
        default:
            let alertController = UIAlertController(title: error.getErrorType().replacingOccurrences(of: "*", with: ""), message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .default) { (action) in
                handler?()
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
       
}
//MARK: - NavigationBar.

extension UINavigationBar{
    class func setNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor =  .white
        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: syste]
        
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.lightGray]
            navBarAppearance.backgroundColor = .lightGray
            navBarAppearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
            UINavigationBar.appearance().standardAppearance = navBarAppearance
        }
    }
}



class Utilities{
    
    static let shared = Utilities()
    private init(){}
    
    func addQueryParam (params: [String: Any], serviceName: WebServices) ->String{
        var queryItems: [URLQueryItem] = []
        for item in params {
            queryItems.append(URLQueryItem(name: item.key, value: String(describing: item.value)))
        }
        var urlComps = URLComponents(string: "\(serviceName)")!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        print("the result is ->>>> " , result.absoluteString)
        let service = result.absoluteString.replacingOccurrences(of: serviceName.getEndPoint(), with: "")
        print("😎😎😎😎 serviceName :  \(service) 😎😎😎😎")
        return service
    }
    
    func getDictionaryFromCodable<T: Codable>(req:T) ->[String:Any]?{
       let jsonEncoder = JSONEncoder()
       if #available(iOS 13.0, *) {
           jsonEncoder.outputFormatting = .withoutEscapingSlashes
       } else {
           jsonEncoder.outputFormatting = .prettyPrinted
           
       }
       let data = try! jsonEncoder.encode(req)
        print("decoded Model==------------ ",String(data:data, encoding : .utf8)!)
       return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
   }
    
    func getTopController (controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController)-> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return getTopController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return getTopController(controller: presented)
        }
        return controller
    }
    
    func formateDate(str: String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: str){
            dateFormatter.dateFormat = "d MMM yyyy"
            let str = dateFormatter.string(from: date)
            return str
        }else {
            return str
        }
    }
}
//MARK: - UIImageView.
extension UIImageView{
    
    func setImage(urlString: String , holder: UIImage? = nil){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: urlString), placeholder: holder ?? UIImage(named: ""))
    }
}
