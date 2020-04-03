//
//  ViewController.swift
//  find_shop
//
//  Created by Yuya Aoki on 2020/03/23.
//  Copyright © 2020 Yuya Aoki. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate{
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    //　↓大阪駅付近の緯度経度
    var lat: Double = 34.7024
    var lon: Double = 135.4959
    //エラーが起きた際にメッセージを表示するラベル
    @IBOutlet weak var Error_title: UILabel!
    //Top_ViewControllerから代入される変数
    var selected_shop : String = ""
    var selected_distance : Int = 0
    func shop_list(shop : String){
        let urlString : String =  shop.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        selected_shop = urlString
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //公式ドキュメントより　大阪駅（現在地）にカメラを当てる
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        //最背面でマップを表示
        self.view.sendSubviewToBack(mapView)
        //現在地を表示
        mapView.isMyLocationEnabled = true
        //下記に記載　selected_shopとselected_distanceの値を決めます。
        decide_shop()
        //店が選択されていない場合必ずHTTP通信が失敗するようにする
        if(selected_shop==""){
            selected_shop = "%%&"
        }
        //ヤフーローカルサーチAPI
       let url="https://map.yahooapis.jp/search/local/V1/localSearch?cid=d8a23e9e64a4c817227ab09858bc1330&lat=" + String(lat)+"&lon="+String(lon)+"&dist="+String(selected_distance)+"&query="+selected_shop+"&appid=dj00aiZpPXlhZnRwSWY4TE8wbiZzPWNvbnN1bWVyc2VjcmV0Jng9NDU-&output=json&results=100"
        print(url)
        //Http通信を行います
        AF.request(url).responseJSON{ response in
            switch response.result{
            case .success(let value):
            let get_json = JSON(value)
            let get_feature = get_json["Feature"]
            for (_,subJson):(String, JSON) in get_feature {
                print(subJson["Name"])
                print(subJson["Property"]["Address"])
                print(subJson["Geometry"]["Coordinates"])
                //ここから店名住所を取り出します。
                let name = subJson["Name"].stringValue
                let address = subJson["Property"]["Address"].stringValue
                let coordinates = subJson["Geometry"]["Coordinates"].stringValue
                let array = coordinates.split(separator: ",")
                let real_ido = Double(array[1])
                let real_keido = Double(array[0])
                //取り出した緯度経度をマーカーにセットします。
                let position = CLLocationCoordinate2D(latitude: real_ido!, longitude: real_keido!)
                let marker = GMSMarker(position: position)
                marker.title = name
                marker.snippet = address
                marker.map = mapView
            }
           case .failure(_):
            //失敗した際にラベルにエラーメッセージを表示する。
            self.Error_title.text = "Error is occured.perhaps you didn't select any shop."
            self.Error_title.backgroundColor = UIColor.green
            }
    }
    }
    // 位置情報を取得・更新するたびに呼ばれる　シミュレータ上では動作しません
//     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            if let myLastLocation = locations.first {
//                lat = myLastLocation.coordinate.latitude
//                lon = myLastLocation.coordinate.longitude
//            }
//        }
    //選択した店
    func decide_shop(){
        if(selected_shop == "スターバックス"){
            shop_list(shop: "スターバックス")
        }
        else if(selected_shop == "コンビニ"){
            shop_list(shop: "コンビニ")
        }
        else if(selected_shop == "ガソリンスタンド"){
            shop_list(shop: "ガソリンスタンド")
        }
        else if(selected_shop == "バー"){
            shop_list(shop: "バー")
        }
        else if(selected_shop == "ラーメン"){
            shop_list(shop: "ラーメン")
        }
        else if(selected_shop == "タリーズコーヒー"){
            shop_list(shop: "タリーズコーヒー")
        }
    
        if(selected_distance == 0){
            selected_distance = 2
        }
        else if(selected_distance == 1){
                  selected_distance = 5
        }
        else if(selected_distance == 2){
                  selected_distance = 8
        }
        else if(selected_distance == 3){
                selected_distance = 10
        }
        else if(selected_distance == 4){
                  selected_distance = 20
        }
    }
   
}

