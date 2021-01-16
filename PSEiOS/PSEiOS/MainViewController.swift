//
//  MainViewController.swift
//  PSEiOS
//
//  Created by Yongwoo Marco on 2021/01/15.
//

import WebKit
import UIKit

class MainViewController: UIViewController {
 
    @IBOutlet var moodooWebView: WKWebView!
    @IBOutlet var moodooActivityIndcator: UIActivityIndicatorView!
    
    // url의 인수를 통해 웹 페이지의 주소를 전달받아 웹페이지를 보여줌
    func loadWebPage(_ url: String) {
        // url에 공백이나 한글이 포함되었있을 경우, 에러가 발생하니 url을 인코딩
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let myUrl = URL(string: escapedString!)
        let myRequest = URLRequest(url: myUrl!)
        moodooWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //myWebView.uiDelegate  = self
        loadWebPage(ResString.moodooURL) // 앱 실행 시 초기 홈페이지를 불러옴
    }
    

    // 웹 뷰가 시작될 때 인디케이터를 시작
    private func webViewDidStartLoad(_ webView: WKWebView) {
        moodooActivityIndcator.startAnimating()
        moodooActivityIndcator.isHidden = false
    }
    // 웹 뷰가 종료될 때 인디케이터를 종료
    private func webViewDidFinishLoad(_ webView: WKWebView) {
        moodooActivityIndcator.stopAnimating()
        moodooActivityIndcator.isHidden = true
    }
    
    //"http://" 문자열이 없을 경우 자동으로 삽입
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
//Mark : Page Controller
    @IBAction func touchBack(_ sender: Any) {
        moodooWebView.goBack()
    }
    @IBAction func touchForward(_ sender: Any) {
        moodooWebView.goForward()
    }
    @IBAction func touchHome(_ sender: Any) {
        moodooWebView.reloadFromOrigin()
    }
    @IBAction func touchRefresh(_ sender: Any) {
        moodooWebView.reload()
    }
}
 
