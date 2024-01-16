//
//  ViewController.swift
//  demoPayment
//
//  Created by Jeanpier Araujo on 18/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clvProducts  : UICollectionView!
    @IBOutlet weak var lblPrice     : UILabel!
    @IBOutlet weak var btnPay       : UIButton!

    var products        = [Product]()
    var selectProduct   : Product?
    var currentVisibleItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProducts()
        self.clvProducts.isPagingEnabled = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        if targetContentOffset.pointee.x == 0.0 {
            let product = self.products[0]
            self.updateData(product)
        } else {
            let product = self.products[1]
            self.updateData(product)
        }
    }
    
    @IBAction private func tabBtnPay(_ sender: Any) {
        let orderId = self.selectProduct?.orderId ?? ""
        let price   = "\(self.selectProduct?.price ?? 0)00"
        self.goToPaymentFlow(Int(price) ?? 0, orderId: orderId)
    }
    
    private func getProducts() {
        self.products = ProductData().getProducts()
        self.updateData(self.products.first!)
        self.clvProducts.reloadData()
    }
    
    private func updateData(_ product: Product) {
        self.selectProduct = product
        self.lblPrice.text = "S/\(product.price ?? 0)"
    }
    
    private func goToPaymentFlow(_ amount: Int, orderId: String) {
        LyraManager().buildWith(amount: amount, currency: LyraKeys.cureency, orderId: orderId, in: self) { token in
            self.showAlert("SUCCESS :D THANK YOU FOR IZIPAY")
            print("\n\nToken: \(token)\n\n")
        } andWithError: { errrorMessage in
            self.showAlert(errrorMessage)
        }
    }
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductsCollectionViewCell
        let product : Product
        product = self.products[indexPath.row]
        
        cell?.lblTitulo.text    = product.name
        cell?.lblPrecio.text    = "S/\(product.price ?? 0)"
        cell?.imgProducto.image = UIImage(named: product.image ?? "")
        
        return cell ?? UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns : CGFloat = 1
        let paddingLeft     : CGFloat = 12
        let paddingRight    : CGFloat = 12
        let spaceCell       : CGFloat = 12
        
        let totalSpaceCell  = spaceCell * (numberOfColumns - 1)
        let availableWidth  = collectionView.frame.width - totalSpaceCell - paddingLeft - paddingRight
        let cellWidth       = availableWidth / numberOfColumns
        let cellHeight      = cellWidth * 1.5
        
        let newSize = CGSize(width: cellWidth, height: cellHeight)
        return newSize
    }
}

// CollectionViewCell
class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgProducto  : UIImageView!
    @IBOutlet weak var lblTitulo    : UILabel!
    @IBOutlet weak var lblPrecio    : UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.contentView.layer.cornerRadius = 20
        self.layer.shadowRadius     = 4
        self.layer.shadowOpacity    = 0.4
        self.layer.shadowColor      = UIColor.black.cgColor
        self.layer.shadowOffset     = .zero
        self.layer.masksToBounds    = false
    }
    
}

