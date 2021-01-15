//
//  ViewController.swift
//  PSEiOS
//
//  Created by Yongwoo Marco on 2021/01/11.
//

import UIKit
import MapKit
import CoreLocation

//class ViewController: UIViewController, UIWebViewDelegate {
//
//    var push_url = ""
//    var presentWindow : UIWindow?
//
//    @IBOutlet weak var mainWebView: UIWebView!
//    @IBOutlet weak var subWebView: UIWebView!
//
//    @IBOutlet weak var webViewIndicator: UIActivityIndicatorView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        webViewIndicator.isHidden = true
//        mainWebView.delegate = self
//
//
//        //var webViewUrl = "http://m.ganggo.org/auto_login.php"
//        //webViewUrl = webViewUrl + "?device_id=\(uuid!)&os=ios"
//
//        let uuid = UIDevice.current.identifierForVendor
//
//        let push_url1 = ResString.push_url
//
//        if(push_url1 == ""){
//            print("11")
//            let url = ResString.autoLoginUrl + "?app_version="+ResString.appVersion+"&device_id=\(uuid!)&os=ios"
//
//            print("\npush_url1 == null url = \(url)")
//
//            mainWebView?.loadRequest(URLRequest(url: URL(string: url)!))
//            ResString.push_url = ""
//        }else{
//            print("22")
//            let url = ResString.autoLoginUrl + "?app_version="+ResString.appVersion+"&device_id=\(uuid!)&os=ios&push_url=\(push_url1)"
//
//            print("viewDidLoad url = \(url)")
//
//            mainWebView?.loadRequest(URLRequest(url: URL(string: url)!))
//            ResString.push_url = ""
//        }
//        print("33")
//    }
//
//
//    // 웹뷰가 로드 될때(페이지 시작) URL주소를 가져와서 주소가 웹뷰 주소(내부)인지 외부 URL 주소인지 확인하는 부분
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//
//        print("shareUrl1 = \(request.url!)")
//
//        var urlStr      = String(describing: request.url!)
//        var threeUrl = urlStr.substring(to: urlStr.index(urlStr.startIndex, offsetBy: 3))
//
//        print(threeUrl)
//
//        // 이동할려는 링크가 app://으로 시작할 경우 외부링크로 인식하고 app://을 http://로 변경한 다음 safari브라우저를 오픈시켜서 해당 URL로 이동시킨다.
//        if(threeUrl == "app"){
//            urlStr = urlStr.replacingOccurrences(of: "app://", with: "http://")
//            print("urlStr = \(urlStr)");
//            var shareUrl = UIApplication.shared.openURL(URL(string : urlStr)!) // 기본 브라우저로 오픈
//        }
//
//
//        NSLog(String(describing: request))
//        return true
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//        print("viewDidAppear")
//    }
//
//    func pushLoad(pushurl : String){
//        print("pushLoad()")
//        print("\(pushurl)")
//
//        let uuid = UIDevice.current.identifierForVendor
//
//        let url = ResString.autoLoginUrl + "?app_version="+ResString.appVersion+"&device_id=\(uuid!)&os=ios&push_url=\(pushurl)"
//        print("pushLoad() url = \(url)")
//
//        //var escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        //print("pushLoad() url2 = \(escapedString)")
//
//        mainWebView.loadRequest(URLRequest(url: URL(string: url)!))
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    func webViewDidStartLoad(_ : UIWebView){
//        webViewIndicator.isHidden = false
//        webViewIndicator.startAnimating()
//
//    }
//    func webViewDidFinishLoad(_ : UIWebView){
//        webViewIndicator.isHidden = true
//        webViewIndicator.stopAnimating()
//    }
//}
