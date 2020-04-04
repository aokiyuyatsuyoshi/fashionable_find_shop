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
    var locationManager: CLLocationManager!
    var mapView: GMSMapView!
    //　緯度経度を初期化
    //エラーが起きた際にメッセージを表示するラベル
    @IBOutlet weak var Error_title: UILabel!
    //選択された店を表示
    @IBOutlet weak var shop_label: UILabel!
    //選択された距離を表示
    @IBOutlet weak var select_distance_label: UILabel!
    //店名の入った配列
    var shop_array = ["スターバックス","コンビニ","ガソリンスタンド","バー","ラーメン","タリーズコーヒー"]
    //距離の入った配列
    var distance_array = [2,5,8,10,20]
    //Top_ViewControllerから代入される変数
    var selected_shop : String = ""
    //全画面のpickerが選択した列番号
    var picker_selected_distance : Int = 0
    //上記の配列から距離を代入する
    var selected_distance : Int = 0
    //https://qiita.com/wadaaaan/items/0de9bc4ee40c8fbf38f1参考
    func shop_list(shop : String){
        let urlString : String =  shop.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        selected_shop = urlString
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        
        if status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
               }
        //下記に記載　selected_shopとselected_distanceの値を決めます。
        decide_shop()
        //店が選択されていない場合必ずHTTP通信が失敗するようにする
        if(selected_shop==""){
            selected_shop = "%%&"
        }
   
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if (status == .authorizedWhenInUse) {
               locationManager.requestWhenInUseAuthorization()
           }
       }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            //公式ドキュメントより　現在の位置にカメラを合わせる
            let yourlocation = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 13.0)
            let mapView = GMSMapView.map(withFrame: view.frame, camera: yourlocation)
            view.addSubview(mapView)
            //最背面でマップを表示
            self.view.sendSubviewToBack(mapView)
            //現在位置にアイコンを表示
            mapView.isMyLocationEnabled = true
            //ヤフーローカルサーチAPI
                let url="https://map.yahooapis.jp/search/local/V1/localSearch?cid=d8a23e9e64a4c817227ab09858bc1330&lat=" + String(latitude)+"&lon="+String(longitude)+"&dist="+String(selected_distance)+"&query="+selected_shop+"&appid=dj00aiZpPXlhZnRwSWY4TE8wbiZzPWNvbnN1bWVyc2VjcmV0Jng9NDU-&output=json&results=100"
                               print(url)
                               //Http通信を行います
                               AF.request(url).responseJSON{ response in
                                   switch response.result{
                                   case .success(let value):
                                   let get_json = JSON(value)
                                   let get_feature = get_json["Feature"]
                                   for (_,subJson):(String, JSON) in get_feature {
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
                                   self.select_distance_label.text = "Error!"
                                   self.shop_label.text = "Error!"
                                   }
                           }
        }
        
    }
    //選択した店
    func decide_shop(){
        //店を設定
        var i : Int = 0
        while i < shop_array.count{
            if(selected_shop == shop_array[i]){
                shop_list(shop: shop_array[i])
                shop_label.text = "shop:" + shop_array[i]
            }
            i = i + 1
        }
        //距離を設定
        var j : Int = 0
        while j < distance_array.count{
            if(picker_selected_distance == j){
                selected_distance = distance_array[j]
                print("disane")
                print(selected_distance)
                select_distance_label.text = "distance:" + String(distance_array[j]) + "km"
            }
            j = j + 1
        }
    }
   
}

