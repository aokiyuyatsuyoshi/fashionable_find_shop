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
    //　↑大阪駅付近の緯度経度
    //Top_ViewControllerから代入される変数
    var selected_shop : String = ""
    var selected_distance : Int = 0

    override func viewDidLoad() {
//        super.viewDidLoad()
        //公式ドキュメントより　大阪駅（現在地）にカメラを当てる
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        //現在地を表示
        mapView.isMyLocationEnabled = true
        //下記に記載　selected_shopとselected_distanceの値を決めます。
        decide_shop()
        //ヤフーローカルサーチAPI
       let url="https://map.yahooapis.jp/search/local/V1/localSearch?cid=d8a23e9e64a4c817227ab09858bc1330&lat=" + String(lat)+"&lon="+String(lon)+"&dist="+String(selected_distance)+"&query="+selected_shop+"&appid=dj00aiZpPXlhZnRwSWY4TE8wbiZzPWNvbnN1bWVyc2VjcmV0Jng9NDU-&output=json"
    
        //Http通信を行います
        AF.request(url).responseJSON{ response in
            switch response.result{
            case .success(let value):

            let get_json = JSON(value)
            let get_feature = get_json["Feature"]
            // If json is .Dictionary
            for (_,subJson):(String, JSON) in get_feature {
               // Do something you want
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
            print("error is occured")
            }
    }
    }
    // 位置情報を取得・更新するたびに呼ばれる
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let location = locations.first
           let latitude =  location?.coordinate.latitude
           let longitude = location?.coordinate.longitude
           print("latitude: \(latitude!)\n longitude: \(longitude!)")
       }
    //選択した店
    func decide_shop(){
        if(selected_shop == "スターバックス"){
                  selected_shop="%E3%82%B9%E3%82%BF%E3%83%BC%E3%83%90%E3%83%83%E3%82%AF%E3%82%B9"
        }
        else if(selected_shop == "コンビニ"){
            selected_shop="%E3%82%B3%E3%83%B3%E3%83%93%E3%83%8B"
        }
        else if(selected_shop == "ガソリンスタンド"){
                   selected_shop="%E3%82%AC%E3%82%BD%E3%83%AA%E3%83%B3%E3%82%B9%E3%82%BF%E3%83%B3%E3%83%89"
        }
        else if(selected_shop == "バー"){
                    selected_shop = "Bar"
        }
        else if(selected_shop == "ラーメン"){
                                 selected_shop = "%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%B3"
        }
        else if(selected_shop == "タリーズコーヒー"){
                                 selected_shop = "%E3%82%BF%E3%83%AA%E3%83%BC%E3%82%BA%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC"
        }
        
        if(selected_distance == 0){
            selected_distance = 2
        }
        if(selected_distance == 1){
                  selected_distance = 5
        }
        if(selected_distance == 2){
                  selected_distance = 8
        }
        if(selected_distance == 3){
                selected_distance = 10
        }
        if(selected_distance == 4){
                  selected_distance = 20
        }
        
        
    }
   
}

