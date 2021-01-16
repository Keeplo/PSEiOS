//
//  File.swift
//  PSEiOS
//
//  Created by Yongwoo Marco on 2021/01/15.
//

import UIKit
import WebKit

class CafeViewController: UIViewController {
    
    @IBOutlet var videoWebView: WKWebView!
    
    // url의 인수를 통해 웹 페이지의 주소를 전달받아 웹페이지를 보여줌
    func loadWebPage(_ url: String) {
        // url에 공백이나 한글이 포함되었있을 경우, 에러가 발생하니 url을 인코딩
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let myUrl = URL(string: escapedString!)
        let myRequest = URLRequest(url: myUrl!)
        videoWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //myWebView.uiDelegate  = self
        loadWebPage(ResString.cafeURL) // 앱 실행 시 초기 홈페이지를 불러옴
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
        videoWebView.goBack()
    }
    @IBAction func touchForward(_ sender: Any) {
        videoWebView.goForward()
    }
    @IBAction func touchHome(_ sender: Any) {
        loadWebPage(ResString.cafeURL)
    }
    @IBAction func touchRefresh(_ sender: Any) {
        videoWebView.reload()
    }
    
}
