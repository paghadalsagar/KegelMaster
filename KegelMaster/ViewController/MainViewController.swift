//
//  MainViewController.swift
//  KegelMaster
//
//  Created by iMac on 08/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit
import Appodeal
import StoreKit

class MainViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource,SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK:- Outlet
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet var collectionViewHeaderTitle: UICollectionView!
    @IBOutlet weak var viewMainLevelList: UIView!
    @IBOutlet weak var scrollviewPage: UIScrollView!
    @IBOutlet weak var imageviewHeaderBG: UIImageView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- Variable
    fileprivate var arrTopTitles = [[String:String]]()
    fileprivate var arrSelectedTopTitles = [[String:String]]()
    let gradientLayer:CAGradientLayer = CAGradientLayer()
    
    fileprivate var arrLevelData:[ExerciseListViaDay] = [ExerciseListViaDay]()
    
    fileprivate var arrPagination:[UIView] = [UIView]();
    fileprivate var slide1: LevelList = LevelList()
    fileprivate var slide2: LevelList = LevelList()
    fileprivate var slide3: LevelList = LevelList()
    fileprivate var slide4: LevelList = LevelList()
    fileprivate var slide5: LevelList = LevelList()
    fileprivate var slide6: LevelList = LevelList()
    fileprivate var slide7: LevelList = LevelList()
    
    let nativeCellName  = "kASNativeCell"
    private let adCache: NSMapTable <NSIndexPath, APDNativeAd> = NSMapTable.strongToStrongObjects()
    
    lazy var nativeAdQueue : APDNativeAdQueue = {
        return APDNativeAdQueue(sdk: nil,
                                settings: self.nativeAdSettings,
                                delegate: self,
                                autocache: true)
    }()
    
    var nativeAdSettings: APDNativeAdSettings! {
        get {
            let instance = APDNativeAdSettings()
            instance.adViewClass = NativeView.self
            return instance;
        }
    }
    
    let headerViewMaxHeight: CGFloat = 200
    let headerViewMinHeight: CGFloat = 50
    
    var productsRequest = SKProductsRequest()
    var iapProducts = [SKProduct]()
    
    //MARK:- UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        arrTopTitles = getMenuList()
        collectionViewHeaderTitle.register(UINib(nibName: CELL_IDENTIFIRE_MENU_HEADER, bundle: nil), forCellWithReuseIdentifier: CELL_IDENTIFIRE_MENU_HEADER)
        collectionViewHeaderTitle.delegate = self
        collectionViewHeaderTitle.dataSource = self
        arrSelectedTopTitles = [arrTopTitles[0]]
        
        arrPagination = createSlides()
        self.setupSlideScrollView(slides: arrPagination)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradintColor()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefault.getIsINTERNET() && !UserDefault.getIsPurchase(){
           nativeAdQueue.loadAd()
        }
        
        slide1.tableviewLevelList.delegate = self
        slide1.tableviewLevelList.dataSource = self
        slide1.tableviewLevelList.reloadData()
        
        slide2.tableviewLevelList.delegate = self
        slide2.tableviewLevelList.dataSource = self
        slide2.tableviewLevelList.reloadData()
        
        slide3.tableviewLevelList.delegate = self
        slide3.tableviewLevelList.dataSource = self
        slide3.tableviewLevelList.reloadData()
        
        slide4.tableviewLevelList.delegate = self
        slide4.tableviewLevelList.dataSource = self
        slide4.tableviewLevelList.reloadData()
        
        slide5.tableviewLevelList.delegate = self
        slide5.tableviewLevelList.dataSource = self
        slide5.tableviewLevelList.reloadData()
        
        slide6.tableviewLevelList.delegate = self
        slide6.tableviewLevelList.dataSource = self
        slide6.tableviewLevelList.reloadData()
        
        slide7.tableviewLevelList.delegate = self
        slide7.tableviewLevelList.dataSource = self
        slide7.tableviewLevelList.reloadData()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //MARK:- Other Methods
    func createSlides() -> [UIView] {
        slide1 = Bundle.main.loadNibNamed("LevelList", owner: self, options: nil)?.first as! LevelList
        slide2 = Bundle.main.loadNibNamed("LevelList", owner: self, options: nil)?.first as! LevelList
        slide3 = Bundle.main.loadNibNamed("LevelList", owner: self, options: nil)?.first as! LevelList
        slide4 = Bundle.main.loadNibNamed("LevelList", owner: self, options: nil)?.first as! LevelList
        slide5 = Bundle.main.loadNibNamed("LevelList", owner: self, options: nil)?.first as! LevelList
        slide6 = Bundle.main.loadNibNamed("LevelList", owner: self, options: nil)?.first as! LevelList
        slide7 = Bundle.main.loadNibNamed("LevelList", owner: self, options: nil)?.first as! LevelList
        return [slide1,slide2,slide3,slide4,slide5,slide6,slide7]
    }
    
    func setupSlideScrollView(slides : [UIView]) {
        viewMainLevelList.layoutIfNeeded()
        scrollviewPage.isPagingEnabled = true
        scrollviewPage.isDirectionalLockEnabled = true
        scrollviewPage.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: viewMainLevelList.bounds.height)
        scrollviewPage.contentSize = CGSize(width: self.view.bounds.width * CGFloat(slides.count), height: viewMainLevelList.bounds.height)
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: self.view.bounds.width * CGFloat(i), y: 0, width: self.view.bounds.width, height: viewMainLevelList.bounds.height)
            scrollviewPage.addSubview(slides[i])
        }
    }
    
    func setDataFromDB(stLevel:String){
        self.arrLevelData.removeAll()
        let query = "SELECT * FROM EXR_PLANS WHERE ExerciseLevel = '\(stLevel)'"
        let arrData = SqlLiteManger().getData(query: query)
        for dataLevel in arrData{
            arrLevelData.append(ExerciseListViaDay.init(fromDictionary: dataLevel as! [String : Any]))
        }
        
        if UserDefault.getIsINTERNET() && !UserDefault.getIsPurchase(){
            self.arrLevelData.insert(ExerciseListViaDay.init(fromDictionary: [String : Any]()), at: 3)
            self.arrLevelData.insert(ExerciseListViaDay.init(fromDictionary: [String : Any]()), at: 7)
        }

        if stLevel == "1"{
            slide1.tableviewLevelList.reloadData()
        }else if stLevel == "2"{
            slide2.tableviewLevelList.reloadData()
        }else if stLevel == "3"{
            slide3.tableviewLevelList.reloadData()
        }else if stLevel == "4"{
            slide4.tableviewLevelList.reloadData()
        }else if stLevel == "5"{
            slide5.tableviewLevelList.reloadData()
        }else if stLevel == "6"{
            slide6.tableviewLevelList.reloadData()
        }else if stLevel == "7"{
            slide7.tableviewLevelList.reloadData()
        }
    }
    
    func setGradintColor(){
        for dictData in arrSelectedTopTitles{
            let selectedID: String = dictData[KEY_ID]!
            if selectedID == "0"{
                imageviewHeaderBG.image = UIImage(named: "img1")
                viewHeader.backgroundColor = color_Level1
                self.setDataFromDB(stLevel: "1")
            }else if selectedID == "1"{
                imageviewHeaderBG.image = UIImage(named: "img2")
                viewHeader.backgroundColor = color_Level2
                self.setDataFromDB(stLevel: "2")
            }else if selectedID == "2"{
                imageviewHeaderBG.image = UIImage(named: "img3")
                viewHeader.backgroundColor = color_Level3
                self.setDataFromDB(stLevel: "3")
            }else if selectedID == "3"{
                imageviewHeaderBG.image = UIImage(named: "img4")
                viewHeader.backgroundColor = color_Level4
                self.setDataFromDB(stLevel: "4")
            }else if selectedID == "4"{
                imageviewHeaderBG.image = UIImage(named: "img5")
                viewHeader.backgroundColor = color_Level5
                self.setDataFromDB(stLevel: "5")
            }else if selectedID == "5"{
                imageviewHeaderBG.image = UIImage(named: "img6")
                viewHeader.backgroundColor = color_Level6
                self.setDataFromDB(stLevel: "6")
            }else if selectedID == "6"{
                imageviewHeaderBG.image = UIImage(named: "img7")
                viewHeader.backgroundColor = color_Level7
                self.setDataFromDB(stLevel: "7")
            }
        }
    }
    
    func presentNative(onView view: UIView,
                       fromIndex index: NSIndexPath) {
        // Get ad from cache
        if let nativeAd = adCache.object(forKey: index) {
            nativeAd.show(on: view, controller: self)
            return
        }
        
        guard let nativeAd = nativeAdQueue.getNativeAds(ofCount: 1).first else { return }
        // Cache ads for correct viewability tracking
        adCache.setObject(nativeAd, forKey: index)
        nativeAd.show(on: view, controller: self)
    }
    

    func fetchAvailableProducts() {
        guard let identifier = productIdentifiers as? Set<String> else { return }
        productsRequest = SKProductsRequest(productIdentifiers: identifier)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    //MARK:- scrollview Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = headerViewHeightConstraint.constant - y
        
        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
        }else if newHeaderViewHeight < headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
        }else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
        }
        
        if headerViewHeightConstraint.constant == 50{
            self.imageviewHeaderBG.isHidden = true
        }else{
            self.imageviewHeaderBG.isHidden = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isEqual(scrollviewPage){
            arrSelectedTopTitles = [[String:String]]()
            let pageWidth: Float = Float(scrollviewPage.frame.width)
            let pageNo: Float = roundf(Float(scrollviewPage.contentOffset.x) / pageWidth)
            let currentPage = Int(pageNo)
            arrSelectedTopTitles.append(arrTopTitles[currentPage])
            collectionViewHeaderTitle.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally , animated: true)
            collectionViewHeaderTitle.reloadItems(at: collectionViewHeaderTitle.indexPathsForVisibleItems)
            self.setGradintColor()
        }
    }
    
    //MARK: - collectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTopTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MenuHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIRE_MENU_HEADER , for: indexPath) as! MenuHeaderCell
        let dict = arrTopTitles[indexPath.row]
        
        if !arrTopTitles.isEmpty {
            cell.lblTitle.text = "\(NSLocalizedString("LEVEL", comment: ""))\(dict[KEY_TITLE]!)"
        }
        
        let keyID: String = dict[KEY_ID]!
        for dictSel in arrSelectedTopTitles {
            let selectedID: String = dictSel[KEY_ID]!
            if selectedID == keyID {
                cell.viewTitleBottom.isHidden = false
            }
            else {
                cell.viewTitleBottom.isHidden = true
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if UserDefault.getIsPurchase(){
            self.setLeaveData(indexPath.row)
        }else{
            if indexPath.row > 2{
                self.fetchAvailableProducts()
            }else{
                self.setLeaveData(indexPath.row)
            }
        }
    }
    
    func setLeaveData(_ selectedIndex: Int){
        arrSelectedTopTitles = [[String:String]]()
        var dict = [String:String]()
        
        dict = arrTopTitles[selectedIndex]
        arrSelectedTopTitles.append(dict)
        
        collectionViewHeaderTitle.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally , animated: true)
        collectionViewHeaderTitle.reloadItems(at: collectionViewHeaderTitle.indexPathsForVisibleItems)
        
        let xOrigin: CGFloat = CGFloat(selectedIndex) * self.view.bounds.width
        scrollviewPage.setContentOffset(CGPoint(x:xOrigin, y: 0), animated: true)
        
        self.setGradintColor()
    }
     
    //MARK:- CollectionViewDelegateFlowLayout Method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = 45;
        return CGSize(width: 80, height: height)
    }
    
    //MARK:- UItableview Method
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLevelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataOfLevel = arrLevelData[indexPath.row]
        if dataOfLevel.iD != nil{
            var cell = DayListCell()
            if let c = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE_DAY_LIST) { cell = c as! DayListCell }
            else { cell = Bundle.main.loadNibNamed(CELL_IDENTIFIRE_DAY_LIST, owner: self, options: nil)?[0] as! DayListCell }
            var selectedLevelColor: UIColor = color_Level1
            for dictSel in arrSelectedTopTitles {
                let selectedID: String = dictSel[KEY_ID]!
                if selectedID == "0"{ //Level1
                    selectedLevelColor = color_Level1
                }else if selectedID == "1"{ //Level2
                    selectedLevelColor = color_Level2
                }else if selectedID == "2"{ //Level3
                    selectedLevelColor = color_Level3
                }else if selectedID == "3"{ //Level4
                    selectedLevelColor = color_Level4
                }else if selectedID == "4"{ //Level5
                    selectedLevelColor = color_Level5
                }else if selectedID == "5"{ //Level6
                    selectedLevelColor = color_Level6
                }else if selectedID == "6"{ //Level7
                    selectedLevelColor = color_Level7
                }
            }
            let dataOfLevel = arrLevelData[indexPath.row]
            cell.lblExerciseTime.text = "\(dataOfLevel.exerciseTime ?? "")"
            if dataOfLevel.exerciseIsRest ?? "" == "false"{
                cell.imageviewRightArrow.image = UIImage(named: "Icn_Right_Arrow")
                cell.imageRightArrow.image = cell.imageRightArrow.image?.withRenderingMode(.alwaysTemplate)
                cell.imageRightArrow.tintColor = selectedLevelColor
            }else{
                cell.imageRightArrow.image = cell.imageRightArrow.image?.withRenderingMode(.alwaysOriginal)
                cell.imageviewRightArrow.image = UIImage(named: "icn_Rest_Day")
                cell.lblExerciseTime.text = "\(NSLocalizedString("\(dataOfLevel.exerciseTime ?? "")", comment:""))"
            }
            cell.lblDayName.text = "\(NSLocalizedString("Day", comment:"")) \(dataOfLevel.dayName ?? "")"
            
            
            cell.setProgressAndColor(color: selectedLevelColor, progress: CGFloat((Float(dataOfLevel.exrDayDonePercentage ?? "0.0") ?? 0.0) / 100))
            return cell
        }else{
            let cell = UITableViewCell(style: .default, reuseIdentifier: nativeCellName)
            presentNative(onView: cell.contentView, fromIndex: indexPath as NSIndexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataOfLevel = arrLevelData[indexPath.row]
        if dataOfLevel.exerciseIsRest ?? "" == "false"{
            guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "ExercisesListViewController") as? ExercisesListViewController else { return  }
            VC.selectedExercise = arrLevelData[indexPath.row]
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    //MARK:- UITableview DELEGATE
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataOfLevel = arrLevelData[indexPath.row]
        if dataOfLevel.iD == nil{
            return 260
        }else{
            return DAYLISTCELL_HEIGHT
        }
        
    }
    //MARK:- SKProductsRequestDelegate
     func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
         if response.products.count > 0 {
             iapProducts = response.products
             print(response.invalidProductIdentifiers)
            if !iapProducts.isEmpty{
                 print(iapProducts)
                DispatchQueue.main.async {
                    guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController") as? SubscriptionViewController else { return  }
                    VC.subscriptionList = self.iapProducts
                    VC.modalPresentationStyle = .fullScreen
                    self.present(VC, animated: true, completion: nil)
                }
               
             }
         }
     }
    
     func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
     }
}

extension MainViewController : APDNativeAdQueueDelegate {
    func adQueueAdIsAvailable(_ adQueue: APDNativeAdQueue, ofCount count: UInt) {
        for dictData in arrSelectedTopTitles{
            let stLevel: String = dictData[KEY_ID]!
            if stLevel == "0"{
                slide1.tableviewLevelList.reloadData()
            }else if stLevel == "1"{
                slide2.tableviewLevelList.reloadData()
            }else if stLevel == "2"{
                slide3.tableviewLevelList.reloadData()
            }else if stLevel == "3"{
                slide4.tableviewLevelList.reloadData()
            }else if stLevel == "4"{
                slide5.tableviewLevelList.reloadData()
            }else if stLevel == "5"{
                slide6.tableviewLevelList.reloadData()
            }else if stLevel == "6"{
                slide7.tableviewLevelList.reloadData()
            }
        }
    }
    
    func adQueue(_ adQueue: APDNativeAdQueue, failedWithError error: Error) {
        print("error ==== \(error.localizedDescription)")
    }
}

private extension APDNativeAd {
    func show(on superview: UIView, controller: UIViewController) {
        getViewFor(controller).map {
            superview.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leftAnchor.constraint(equalTo: superview.leftAnchor),
                $0.rightAnchor.constraint(equalTo: superview.rightAnchor),
                $0.topAnchor.constraint(equalTo: superview.topAnchor),
                $0.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
        }
    }
}

