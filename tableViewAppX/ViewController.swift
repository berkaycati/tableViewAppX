//
//  ViewController.swift
//  tableViewAppX
//
//  Created by Berkay on 25.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!  /// tableview için gerekli protokolleri yukarıya yazıp çektik.
    var namesOfList = [String]()                /// bir liste olacak ve listemiz string classından oluşacak dedik
    var namesOfImages = [UIImage]()             /// bir image listesi olacak ve bu liste UIimage classından oluşacak dedik
    var chosenName = ""                         /// üzerine tıklanan isim ne ise onu " " olarak tanımlanmış olsun dedik
    var chosenImage = UIImage()                 /// üzrerine tıklananla bağlantılı olacak image , UIImage sınıfından olsun dedik.
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        tableView.delegate = self               /// tableView'in kendisi VC ile bağlantılı olduğundan özelliklerini self şeklinde tanımladık
        tableView.dataSource = self             /// delegate ve dataSource protokollerini çekmiştik zaten. bunları selfledik.
        
                                                /// Liste tanımlaması
        namesOfList.append("eiffel")
        namesOfList.append("greatwall")
        namesOfList.append("liberty")
        namesOfList.append("pyramid")
                                                /// image isimlerinin sırasıyla doğru yazılması
        namesOfImages.append(UIImage(named: "eiffel.jpeg")!)        /// burada append derken UIimage'den bir şeyler lazım
        namesOfImages.append(UIImage(named: "greatwall.jpeg")!)     /// bundan dolayı appendin içine UIImage classını ekleyip
        namesOfImages.append(UIImage(named: "liberty.jpeg")!)       /// named diyip devam ediyoruz
        namesOfImages.append(UIImage(named: "pyramid.jpeg")!)
        
    }
    ///--------------------------------------------------------------------------------------------------

    /// tableView Protokollerini getirdikten sonra bize 2 tane kesin fonksiyon lazım oluyor. Biri numbersOfRowSection, diğeri cellForRowAt
    ///
    /// bu iki fonksiyondan numbersOfRowSection olan kaç tane row olacağını belli ederken,
    /// cell olan fonksiyon isminden anlaşılacağı gibi hücre tanımlamasın yapmamıza olanak sağlıyor
    ///
    /// buradaki hücre tanımlama mantığı şu şekilde işliyor;
    ///
    /// cell, elma, armut diye bir tanım oluşturup tableView'in Cell classına atama yapıyoruz ki bu tanımın aslında ne olduğunu bilelim.
    /// daha sonra içerik eklemek için farklı bir tanım oluşturup az önce oluşturduğumuz tanımın içerik default configure classına dahil ediyoruz.
    ///
    /// içeriğin yazısına da yukarıda oluşturduğumuz listenin string elemanlarını atıyoruz her bir row için sırasıyla listedeki isimler yazıyor olacak
    /// hücre olarak tanımladığımız tanımı içerik configuresini az önce tanımladığımız row elamınına atıyoruz
    /// ve ilk tanım olan hücreyi return ediyoruz.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = namesOfList[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesOfList.count /// burada da kaç tane string var ise say o kadar sayı döndür diyoruz
    }
    
    
    ///------------------------------------------------------------------------------
    /// burada "Did Select Row At" anlaşıldığı üzere seçilen row üzerinden işlem yapmaya yönelik bir fonksiyon
    /// ilk başta classın altında tanımladığımız seçilen rowdaki image ve name 'i işte burada kullanıyoruz
    /// çünkü chosen olayı burada gerçekleşiyor
    ///
    /// diyoruz ki; sen seçtiğin tıkladığın row için;
    ///
    /// chosenname'i listedeki row ne ise ona eşitle
    /// chosenImage'i backgroundta bekleyen image ne ise ona eşitle
    /// ardından tanımlanmış olan segue'nin identifier'ı ne ise oraya beni perform et, yani uygula yerine gerçekleştir.
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenName = namesOfList[indexPath.row]
        chosenImage = namesOfImages[indexPath.row]
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
   
    ///------------------------------------------------------------------------------
    ///
    /// burada segue öncesi hazırlama olayı prerape for segue,,
    /// burada eğer seguemizin identifier'ı tanımladığımız identifier ile eşleşiyorsa;
    /// hedefVC diye bir şey tanımlayıp, segue.destination as! diyerek gideceğimiz yeni VC'nin ID'sini yazıyoruz
    /// oranın içine girdikten sonra da gittiğimiz yeni VC'ye bağlı .swift uzantılı dosyada yaptığımız tanımalara ulaşıyoruz
    /// ulaşma methodu az önce tanımladığımız destinationVC üzeirnden "." koyup oradaki tanımları yani
    /// oradaki textLabel ve ImageView'in kendisini bu dosyada tanımlanan isime eşitlemek veriyi buradan oraya götürmek
    ///
    /// yani VERİ AKTARIMI

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! toSecondVC
            destinationVC.selectedName = chosenName
            destinationVC.selectedImage = chosenImage
        }
    }
    ///------------------------------------------------------------------------------
    ///
    /// Buradaki temel prensip ise VERİ SİLMEK, commit ile geldik
    ///
    /// self. diyip devam ettik VC'nin içinden alacağımız verileri sileceğimizden. VC'nin içinde kalacağımızı belirttik.
    ///
    /// .remove diyip indexPath.row klasik...
    /// silme işlemlerini gerçekleştirdikten sonra row'un kendisini de silmek için lazım olan
    ///
    /// deleteRows ki zaten gayet açık ve yine indexPath'in kendisi

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.namesOfList.remove(at: indexPath.row)
        self.namesOfImages.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
}

