
import UIKit
import StoreKit
import SwiftyStoreKit

/// 内购管理
public struct ZSwiftStoreKit {
    
    private var productIds: [String] = [String]()
    private var products: [SKProduct] = [SKProduct]()
    public static var shared = ZSwiftStoreKit()
    
    public static func configProductIds(key: String, ids: [Int]) {
        ids.forEach { (id) in
            ZSwiftStoreKit.shared.productIds.append(key + String(id))
        }
    }
    public static func completeTransactions(completion: (() -> Void)? = nil) {
        SwiftyStoreKit.completeTransactions(atomically: true, completion: { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    let downloads = purchase.transaction.downloads
                    if !downloads.isEmpty {
                        SwiftyStoreKit.start(downloads)
                    } else if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred: break
                @unknown default: break
                }
            }
            completion?()
        })
        SwiftyStoreKit.updatedDownloadsHandler = { downloads in
            let contentURLs = downloads.compactMap { $0.contentURL }
            if contentURLs.count == downloads.count {
                SwiftyStoreKit.finishTransaction(downloads[0].transaction)
            }
        }
    }
    public static func retrieveProducts(completion: (() -> Void)?) {
        var sets = Set<String>()
        ZSwiftStoreKit.shared.productIds.forEach({ pid in sets.insert(pid) })
        SwiftyStoreKit.retrieveProductsInfo(sets, completion: { result in
            result.retrievedProducts.forEach { (product) in
                ZSwiftStoreKit.shared.products.append(product)
            }
            completion?()
        })
    }
    public static func purchaseProduct(productId: String, completion: ((_ productId: String?) -> Void)?) {
        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                completion?(purchase.productId)
            case .error(let error):
                completion?(nil)
            }
        }
    }
}
