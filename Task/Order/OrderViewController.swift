//
//  ViewController.swift
//  Task
//
//  Created by LALITHA KONDA on 01/08/22.
//

import UIKit
import CoreLocation
import Contacts

class OrderViewController: UIViewController {
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var crossBtn: UIButton!
    private var locationManager:CLLocationManager?
    
    lazy var isSearchEnabled: Bool = false
    lazy var restaurents: [String] = ["Paradise","Mithaiwala","Madhuri","Casual Dining","Fast Casual","Ghost Restaurant","Fast Food","Food Truck","Cafe","Buffet Style","Alpha Biryani","Alpha Chicken","Odia","Aloha Pizza"]
   lazy var filteredRestaurents: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup_UI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getUserLocation()
    }
    
    @IBAction func searchFieldBegin(_ sender: UITextField) {
        self.isSearchEnabled = true
        self.crossBtn.isHidden = !isSearchEnabled
        self.filteredRestaurents = self.restaurents
        self.collectionView.collectionViewLayout = searchCompositionalLayout()
        self.collectionView.reloadData()
    }
    
   
    
    @IBAction func searchFieldValueChanged(_ sender: UITextField) {
        filterContentForSearchText(sender.text ?? "")
    }
    @IBAction func crossBtnAction(_ sender: UIButton) {
        isSearchEnabled = false
        self.crossBtn.isHidden = !isSearchEnabled
        self.searchField.resignFirstResponder()
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        self.collectionView.reloadData()
    }
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filteredRestaurents.removeAll()
        filteredRestaurents = restaurents.filter { thing in
            return "\(thing.lowercased())".contains(searchText.lowercased())
        }
        if searchText.isEmpty{
            self.filteredRestaurents = restaurents
        }
        collectionView.reloadData()
    }
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
    
    private func setup_UI(){
        self.collectionView.registerHeaderFooter(HeaderFooterType: TitleHeader.self)
        self.collectionView.registerFooter(HeaderFooterType: Footer.self )
        self.collectionView.register(cellType: CategoryCell.self)
        self.collectionView.register(cellType: OfferCell.self)
        self.collectionView.register(cellType: OrderCell.self)
        self.collectionView.register(cellType: BannerCell.self)
        self.collectionView.register(cellType: MakeCell.self)
        self.collectionView.register(cellType: RestaurentCell.self)
        self.collectionView.register(cellType: SearchAccountCell.self)
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        self.crossBtn.isHidden = !isSearchEnabled
        self.searchField.delegate = self
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.categoryLayoutSection()
            case 1: return self.bannerLayoutSection()
            case 2: return self.offerLayoutSection()
            case 3: return self.orderLayoutSection()
            case 4: return self.makeLayoutSection()
            default: return self.restaurentLayoutSection()
            }
        }
    }
    
    private func searchCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.searchLayoutSection()
            default: return self.restaurentLayoutSection()
            }
        }
    }
    
    private func searchLayoutSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
      
        return section
    }
    private func categoryLayoutSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(480), heightDimension: .absolute(32))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func bannerLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(52))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 12)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func offerLayoutSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .absolute(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    private func orderLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 8
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(170))

        let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.54), heightDimension: .estimated(170))
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [leadingGroup, trailingGroup])
        nestedGroup.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 6)
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        section.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
        return section
    }
    
    private func makeLayoutSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(124))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 6, bottom: 4, trailing: 6)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top), NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        ]
        return section
    }
    private func restaurentLayoutSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(280))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 4, leading: 6, bottom: 4, trailing: 6)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 4, leading: 12, bottom: 4, trailing: 12)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
       // section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

//MARK: - UICollectionViewDataSource Methods
extension OrderViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isSearchEnabled ? 1 : 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return isSearchEnabled ? self.filteredRestaurents.count : 6
        case 1:
            return 1
        case 2:
            return 5
        case 3:
            return 5
        case 4:
            return 8
        case 5:
            return 8
        default:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            if isSearchEnabled{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchAccountCell.className, for: indexPath) as! SearchAccountCell
                cell.restaurentNameLbl.text = self.filteredRestaurents[indexPath.row]
                return cell
            }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.className, for: indexPath) as! CategoryCell
           
            return cell
            }
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.className, for: indexPath) as! BannerCell
           
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferCell.className, for: indexPath) as! OfferCell
            
            return cell
        
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCell.className, for: indexPath) as! OrderCell
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeCell.className, for: indexPath) as! MakeCell
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurentCell.className, for: indexPath) as! RestaurentCell
            cell.offerView.isHidden = indexPath.row % 2 == 0
            cell.extraOffView.isHidden = indexPath.row % 3 == 0
        return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeader.className, for: indexPath) as! TitleHeader
            switch indexPath.section{
            case 3:
                header.titleLbl.text = "Order again"
            case 4:
                header.titleLbl.text = "Eat what makes you happy"
                header.verifyBtnOL.isHidden = true
            case 5:
                header.titleLbl.text = "899 restaurents around you"
                header.verifyBtnOL.isHidden = true
            default:
                break
            }
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Footer.className, for: indexPath)
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
}


@IBDesignable
class DashedLineView : UIView {
    @IBInspectable var perDashLength: CGFloat = 2.0
    @IBInspectable var spaceBetweenDash: CGFloat = 2.0
    @IBInspectable var dashColor: UIColor = UIColor.lightGray


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let  path = UIBezierPath()
        if height > width {
            let  p0 = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            path.addLine(to: p1)
            path.lineWidth = width

        } else {
            let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            path.addLine(to: p1)
            path.lineWidth = height
        }

        let  dashes: [ CGFloat ] = [ perDashLength, spaceBetweenDash ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }

    private var width : CGFloat {
        return self.bounds.width
    }

    private var height : CGFloat {
        return self.bounds.height
    }
}


extension OrderViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)")
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: nil) { (clPlacemark: [CLPlacemark]?, error: Error?) in
                guard let place = clPlacemark?.first else {
                    print("No placemark from Apple: \(String(describing: error))")
                    return
                }
                
                let postalAddressFormatter = CNPostalAddressFormatter()
                postalAddressFormatter.style = .mailingAddress
                var addressString: String?
                if let postalAddress = place.postalAddress {
                    addressString = postalAddressFormatter.string(from: postalAddress)
                    print(addressString ?? "")
                    self.locationNameLbl.text = addressString ?? ""
                }
            }
        }
    }
}

extension OrderViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
