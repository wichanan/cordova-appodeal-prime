class APInterstitial: APBase, AppodealInterstitialDelegate {
    var originalHeight: CGFloat!
    var view: UIView {
        return self.plugin.viewController.view
    }
    
    func show() {
        Appodeal.showAd(.interstitial, rootViewController: self.plugin.viewController)
        Appodeal.setAutocache(false, types:.interstitial)
        Appodeal.setInterstitialDelegate(self)
        if (originalHeight == nil) {
            originalHeight = plugin.webView.frame.height
        }
    }
    
    // Method called if interstitial mediation failed
    func interstitialDidFailToLoadAd() {
        NSLog("interstitial did fail to load ad")
        plugin.emit(eventType: APEvents.interstitialLoadFail)
    }
    
    // Method called if interstitial mediation was success, but ready ad network can't show ad or
    // ad presentation was to frequently according your placement settings
    func interstitialDidFailToPresent() {
        NSLog("interstitial did fail to present")
        plugin.emit(eventType: APEvents.interstitialShowFailed)
    }
    
    // Method called when interstitial will display on screen
    func interstitialWillPresent() {
        NSLog("interstitial will display")
        plugin.emit(eventType: APEvents.interstitialWillDisplay)
    }
    
    // Method called after interstitial leave screeen
    func interstitialDidDismiss() {
        plugin.webView.frame = CGRect(
            x: plugin.webView.bounds.origin.x,
            y: plugin.webView.bounds.origin.y,
            width: plugin.webView.bounds.width,
            height: originalHeight)
        NSLog("interstitial did dismiss")
        plugin.emit(eventType: APEvents.interstitialClose)
    }
    
    // Method called when user tap on interstitial
    func interstitialDidClick() {
        NSLog("interstitial did click")
        plugin.emit(eventType: APEvents.interstitialClick)
    }
    
    // Method called when interstitial did expire and could not be shown
    func interstitialDidExpired(){
        NSLog("interstitial did expire")
        plugin.emit(eventType: APEvents.interstitialExpired)
    }
}
