#!/bin/env ruby
# encoding: utf-8

DISTRICTS = [
  "Adalar",
  "Avcılar",
  "Bağcılar",
  "Bahçelievler",
  "Bakırköy",
  "Bayrampaşa",
  "Beşiktaş",
  "Beykoz",
  "Beyoğlu",
  "Büyükçekmece",
  "Çatalca",
  "Eminönü",
  "Esenler",
  "Esenyurt",
  "Eyüp",
  "Fatih",
  "Gaziosmanpaşa",
  "Güngören",
  "Kadıköy",
  "Kağıthane",
  "Kartal",
  "Küçükçekmece",
  "Maltepe",
  "Pendik",
  "Sarıyer",
  "Silivri",
  "Sultanbeyli",
  "Şile",
  "Şişli",
  "Tuzla",
  "Ümraniye",
  "Üsküdar",
  "Zeytinburnu"
]

NEIGHBORHOODS = 
[
  ["Adalar",	"Burgaz"],
  ["Adalar",	"Büyükada"],
  ["Adalar",	"Cami"],
  ["Adalar",	"Dağ"],
  ["Adalar",	"Heybeliada"],
  ["Adalar",	"Karanfil"],
  ["Adalar",	"Kınalıada"],
  ["Adalar",	"Kıyı"],
  ["Adalar",	"Maden"],
  ["Adalar",	"Merkez"],
  ["Adalar",	"Mesrutiyet"],
  ["Adalar",	"Nizam"],
  ["Adalar",	"Sedef Adası"],
  ["Adalar",	"Yalı"],
  ["Avcılar",	"Ambarlı"],
  ["Avcılar",	"Cihangir"],
  ["Avcılar",	"Denizköşkler"],
  ["Avcılar",	"Firuzköy"],
  ["Avcılar",	"Gümüşpala"],
  ["Avcılar",	"M.Kemal Paşa"],
  ["Avcılar",	"Merkez"],
  ["Avcılar",	"Tahtakale"],
  ["Avcılar",	"Üniversite"],
  ["Avcılar",	"Yeşilkent"],
  ["Bağcılar",	"Bağlar"],
  ["Bağcılar",	"Barbaros"],
  ["Bağcılar",	"Çınar"],
  ["Bağcılar",	"Demirkapı"],
  ["Bağcılar",	"Fatih Mah."],
  ["Bağcılar",	"Güneşli Bağlar"],
  ["Bağcılar",	"Güneşli Eston Kirazlıevler"],
  ["Bağcılar",	"Güneşli Evren"],
  ["Bağcılar",	"Güneşli Hürriyet"],
  ["Bağcılar",	"Haznedar"],
  ["Bağcılar",	"İnönü"],
  ["Bağcılar",	"Kirazlı Demirkapı"],
  ["Bağcılar",	"Kirazlı Fevzi Çakmak"],
  ["Bağcılar",	"Kirazlı Yeni Mah."],
  ["Bağcılar",	"Mahmutbey 100.Yıl"],
  ["Bağcılar",	"Mahmutbey Göztepe"],
  ["Bağcılar",	"Mahmutbey Kemalpaşa"],
  ["Bağcılar",	"Mahmutbey Pirireis"],
  ["Bağcılar",	"Merkez"],
  ["Bağcılar",	"Sancaktepe"],
  ["Bağcılar",	"Yavuz Selim"],
  ["Bağcılar",	"Yeni Bağcılar Fevzi Çakmak"],
  ["Bağcılar",	"Yeni Bağcılar K.Karabekir"],
  ["Bağcılar",	"Yenigün"],
  ["Bağcılar",	"Yıldıztepe"],
  ["Bahçelievler",	"Basın Sitesi"],
  ["Bahçelievler",	"Çalışlar"],
  ["Bahçelievler",	"Çobançeşme"],
  ["Bahçelievler",	"Deli Hüseyin Paşa"],
  ["Bahçelievler",	"Fevzi Çakmak"],
  ["Bahçelievler",	"Haznedar"],
  ["Bahçelievler",	"Hürriyet"],
  ["Bahçelievler",	"İstanbul Evleri"],
  ["Bahçelievler",	"Kocasinan Cumhuriyet"],
  ["Bahçelievler",	"Koza Evleri"],
  ["Bahçelievler",	"Merkez"],
  ["Bahçelievler",	"Siyavuşpaşa"],
  ["Bahçelievler",	"Soğanlı"],
  ["Bahçelievler",	"Şirinevler"],
  ["Bahçelievler",	"Talatpaşa"],
  ["Bahçelievler",	"Ünverdi"],
  ["Bahçelievler",	"Yayla"],
  ["Bahçelievler",	"Yenibosna"],
  ["Bahçelievler",	"Zafer"],
  ["Bakırköy",	"Adakale"],
  ["Bakırköy",	"Ataköy"],
  ["Bakırköy",	"Ataköy 1. Kısım"],
  ["Bakırköy",	"Ataköy 11. Kısım"],
  ["Bakırköy",	"Ataköy 2. Kısım"],
  ["Bakırköy",	"Ataköy 3. Kısım"],
  ["Bakırköy",	"Ataköy 4. Kısım"],
  ["Bakırköy",	"Ataköy 5. Kısım"],
  ["Bakırköy",	"Ataköy 7.8. Kısım"],
  ["Bakırköy",	"Ataköy 9.10. Kısım"],
  ["Bakırköy",	"Bahriye Üçok (7-8-9-10. Kısım)"],
  ["Bakırköy",	"Basınköy"],
  ["Bakırköy",	"Beşyol"],
  ["Bakırköy",	"Cevizlik"],
  ["Bakırköy",	"Çamlık"],
  ["Bakırköy",	"Çiroz"],
  ["Bakırköy",	"Ebuzziya Cad."],
  ["Bakırköy",	"Florya"],
  ["Bakırköy",	"Güngören Cad."],
  ["Bakırköy",	"Hatboyu"],
  ["Bakırköy",	"İlhan Biber (2-5-6. Kısım)"],
  ["Bakırköy",	"İncirli"],
  ["Bakırköy",	"İstanbul Cad."],
  ["Bakırköy",	"Kartaltepe"],
  ["Bakırköy",	"Merkez"],
  ["Bakırköy",	"Osmaniye"],
  ["Bakırköy",	"Özgürlük Meydanı"],
  ["Bakırköy",	"Rönepark"],
  ["Bakırköy",	"Sakızağacı"],
  ["Bakırköy",	"Sokullu"],
  ["Bakırköy",	"Söğütözü"],
  ["Bakırköy",	"Şekerevler"],
  ["Bakırköy",	"Şenlikköy"],
  ["Bakırköy",	"Şevketiye"],
  ["Bakırköy",	"Tandoğan"],
  ["Bakırköy",	"Turan Güneş Bulvarı"],
  ["Bakırköy",	"Yenimahalle"],
  ["Bakırköy",	"Yeşilköy"],
  ["Bakırköy",	"Yeşilyurt"],
  ["Bakırköy",	"Zeytinlik"],
  ["Bakırköy",	"Zuhuratbaba"],
  ["Bakırköy",	"Zümrütyuva"],
  ["Bayrampaşa",	"Altıntepsi"],
  ["Bayrampaşa",	"Beşyüzevler"],
  ["Bayrampaşa",	"Cevatpaşa"],
  ["Bayrampaşa",	"Esenler"],
  ["Bayrampaşa",	"İsmetpaşa"],
  ["Bayrampaşa",	"Kartaltepe"],
  ["Bayrampaşa",	"Kocatepe"],
  ["Bayrampaşa",	"Merkez"],
  ["Bayrampaşa",	"Murat Paşa"],
  ["Bayrampaşa",	"Orta Mahalle"],
  ["Bayrampaşa",	"Sağmalcılar"],
  ["Bayrampaşa",	"Terazidere"],
  ["Bayrampaşa",	"Vatan"],
  ["Bayrampaşa",	"Yenidoğan"],
  ["Bayrampaşa",	"Yıldırım Mah."],
  ["Beşiktaş",	"1. Levent"],
  ["Beşiktaş",	"2. Levent"],
  ["Beşiktaş",	"3. Levent"],
  ["Beşiktaş",	"4. Levent"],
  ["Beşiktaş",	"4. Levent Otoyolcular Sitesi"],
  ["Beşiktaş",	"4. Levent Petekler Sitesi"],
  ["Beşiktaş",	"Abbasağa"],
  ["Beşiktaş",	"Abdi İpekçi"],
  ["Beşiktaş",	"Akatlar"],
  ["Beşiktaş",	"Alkent Etiler"],
  ["Beşiktaş",	"Arnavutköy"],
  ["Beşiktaş",	"Balmumcu"],
  ["Beşiktaş",	"Bebek"],
  ["Beşiktaş",	"Büyükhanlı Sitesi"],
  ["Beşiktaş",	"Cihannüma"],
  ["Beşiktaş",	"Çırağan"],
  ["Beşiktaş",	"Darphane"],
  ["Beşiktaş",	"Dikilitaş"],
  ["Beşiktaş",	"Ertuğrul (Gayrettepe)"],
  ["Beşiktaş",	"Esentepe"],
  ["Beşiktaş",	"Etiler"],
  ["Beşiktaş",	"Ihlamur"],
  ["Beşiktaş",	"Konak"],
  ["Beşiktaş",	"Kuruçeşme"],
  ["Beşiktaş",	"Kültür"],
  ["Beşiktaş",	"Levazım"],
  ["Beşiktaş",	"Levent"],
  ["Beşiktaş",	"Mecidiye"],
  ["Beşiktaş",	"Merkez"],
  ["Beşiktaş",	"Metro City"],
  ["Beşiktaş",	"Muradiye"],
  ["Beşiktaş",	"Nispetiye"],
  ["Beşiktaş",	"Ortaköy"],
  ["Beşiktaş",	"Sarı Konaklar Sitesi"],
  ["Beşiktaş",	"Serencebey"],
  ["Beşiktaş",	"Sinanpaşa"],
  ["Beşiktaş",	"Topağacı"],
  ["Beşiktaş",	"Türkali"],
  ["Beşiktaş",	"Ulus"],
  ["Beşiktaş",	"Valideçeşme"],
  ["Beşiktaş",	"Vişnezade"],
  ["Beşiktaş",	"Yeni Levent"],
  ["Beşiktaş",	"Yıldız"],
  ["Beşiktaş",	"Zincirlikuyu"],
  ["Beykoz",	"Acarkent"],
  ["Beykoz",	"Anadolu Feneri"],
  ["Beykoz",	"Anadolu Hisarı"],
  ["Beykoz",	"Anadolu Kavağı"],
  ["Beykoz",	"Askeri Bölge"],
  ["Beykoz",	"Baklacı"],
  ["Beykoz",	"Beykoz Konakları"],
  ["Beykoz",	"Camlıbahçe"],
  ["Beykoz",	"Çavuşbaşı"],
  ["Beykoz",	"Çengeldere"],
  ["Beykoz",	"Çiftlik"],
  ["Beykoz",	"Çiğdem"],
  ["Beykoz",	"Çubuklu"],
  ["Beykoz",	"Göksu"],
  ["Beykoz",	"Göztepe"],
  ["Beykoz",	"Gümüşsuyu"],
  ["Beykoz",	"İncirköy"],
  ["Beykoz",	"Kanlıca"],
  ["Beykoz",	"Kavacık"],
  ["Beykoz",	"Merkez"],
  ["Beykoz",	"Ortaçeşme"],
  ["Beykoz",	"Paşabahçe"],
  ["Beykoz",	"Polenezköy"],
  ["Beykoz",	"Poyrazköy"],
  ["Beykoz",	"Riva"],
  ["Beykoz",	"Rüzgarlıbahçe"],
  ["Beykoz",	"Soğuksu"],
  ["Beykoz",	"Tokatköy"],
  ["Beykoz",	"Yakacık"],
  ["Beykoz",	"Yalıköy"],
  ["Beykoz",	"Yavuz Selim"],
  ["Beykoz",	"Yeni Mahalle"],
  ["Beyoğlu",	"Arap Cami"],
  ["Beyoğlu",	"Asmalı Mescit"],
  ["Beyoğlu",	"Bedrettin"],
  ["Beyoğlu",	"Bereketzade"],
  ["Beyoğlu",	"Bostan"],
  ["Beyoğlu",	"Bülbül"],
  ["Beyoğlu",	"Camikebir"],
  ["Beyoğlu",	"Cihangir"],
  ["Beyoğlu",	"Çatma Mescit"],
  ["Beyoğlu",	"Çukur"],
  ["Beyoğlu",	"Elmadağ"],
  ["Beyoğlu",	"Emekyemez"],
  ["Beyoğlu",	"Evliya Çelebi"],
  ["Beyoğlu",	"Faikpaşa"],
  ["Beyoğlu",	"Fetihtepe"],
  ["Beyoğlu",	"Fındıklı"],
  ["Beyoğlu",	"Firuzağa"],
  ["Beyoğlu",	"Galatasaray"],
  ["Beyoğlu",	"Gümüşsuyu"],
  ["Beyoğlu",	"Hacıahmet"],
  ["Beyoğlu",	"Hacımimi"],
  ["Beyoğlu",	"Halıcıoğlu"],
  ["Beyoğlu",	"Hasköy"],
  ["Beyoğlu",	"Hüseyinağa"],
  ["Beyoğlu",	"İstiklal"],
  ["Beyoğlu",	"Kabataş"],
  ["Beyoğlu",	"Kadı Mehmet Efendi"],
  ["Beyoğlu",	"Kalyoncu Kulluğu"],
  ["Beyoğlu",	"Kamankeş Kara Mustafa Paşa"],
  ["Beyoğlu",	"Kamer Hatun"],
  ["Beyoğlu",	"Kaptan Paşa"],
  ["Beyoğlu",	"Karaköy"],
  ["Beyoğlu",	"Kasımpaşa"],
  ["Beyoğlu",	"Katip Mustafa Çelebi"],
  ["Beyoğlu",	"Keçecipiri"],
  ["Beyoğlu",	"Kılıç Ali Paşa"],
  ["Beyoğlu",	"Kocatepe"],
  ["Beyoğlu",	"Kulaksız"],
  ["Beyoğlu",	"Kuloğlu"],
  ["Beyoğlu",	"Küçük Piyale"],
  ["Beyoğlu",	"Merkez"],
  ["Beyoğlu",	"Müeyyedzade"],
  ["Beyoğlu",	"Odakule"],
  ["Beyoğlu",	"Ömer Avni"],
  ["Beyoğlu",	"Örnektepe"],
  ["Beyoğlu",	"Piri Paşa"],
  ["Beyoğlu",	"Piyale Paşa"],
  ["Beyoğlu",	"Pürtelaş Hasan Efendi"],
  ["Beyoğlu",	"Sıra Selviler"],
  ["Beyoğlu",	"Sururi Mehmet Efendi"],
  ["Beyoğlu",	"Sütlüce"],
  ["Beyoğlu",	"Şahkulu"],
  ["Beyoğlu",	"Şehit Muhtar"],
  ["Beyoğlu",	"Taksim"],
  ["Beyoğlu",	"Tarlabaşı"],
  ["Beyoğlu",	"Tepebaşı"],
  ["Beyoğlu",	"Tomtom"],
  ["Beyoğlu",	"Tophane"],
  ["Beyoğlu",	"Tünel"],
  ["Beyoğlu",	"Yahya Kahya"],
  ["Beyoğlu",	"Yenişehir"],
  ["Büyükçekmece",	"Adakent"],
  ["Büyükçekmece",	"Adnan Kahveci"],
  ["Büyükçekmece",	"Ahmediye"],
  ["Büyükçekmece",	"Alkent 2000"],
  ["Büyükçekmece",	"Atatürk"],
  ["Büyükçekmece",	"Bahçelievler"],
  ["Büyükçekmece",	"Bahçeşehir"],
  ["Büyükçekmece",	"Basındoğa Sitesi"],
  ["Büyükçekmece",	"Batıköy"],
  ["Büyükçekmece",	"Beykent Emincan Yapı Koop."],
  ["Büyükçekmece",	"Beykent Lider Kent Konut."],
  ["Büyükçekmece",	"Beykent Yeşil Kent 1"],
  ["Büyükçekmece",	"Beykent Yeşil Kent 2"],
  ["Büyükçekmece",	"Beykent Yeşil Kent 3"],
  ["Büyükçekmece",	"Beylikdüzü"],
  ["Büyükçekmece",	"Bizimkent"],
  ["Büyükçekmece",	"Boğazköy"],
  ["Büyükçekmece",	"Büyükçekmece Konakları"],
  ["Büyükçekmece",	"Büyükşehir A Mahallesi"],
  ["Büyükçekmece",	"Büyükşehir B Mahallesi"],
  ["Büyükçekmece",	"Büyükşehir C Mahallesi"],
  ["Büyükçekmece",	"Cumhuriyet"],
  ["Büyükçekmece",	"Çakmaklı"],
  ["Büyükçekmece",	"Demirkan Sitesi"],
  ["Büyükçekmece",	"Dereağzı"],
  ["Büyükçekmece",	"Dizdariye"],
  ["Büyükçekmece",	"Emincan Sitesi"],
  ["Büyükçekmece",	"Esenkent"],
  ["Büyükçekmece",	"Eston Ardıçlı Evler"],
  ["Büyükçekmece",	"Fatih Mah."],
  ["Büyükçekmece",	"Gürpınar"],
  ["Büyükçekmece",	"Gürpınar Parkova Sitesi"],
  ["Büyükçekmece",	"Güzelce"],
  ["Büyükçekmece",	"Hadımköy"],
  ["Büyükçekmece",	"Haramidere"],
  ["Büyükçekmece",	"Hürriyet"],
  ["Büyükçekmece",	"İhlas Marmara Evleri 1. Kısım"],
  ["Büyükçekmece",	"İhlas Marmara Evleri 2. Kısım"],
  ["Büyükçekmece",	"İncirtepe"],
  ["Büyükçekmece",	"İnönü"],
  ["Büyükçekmece",	"Jetkent"],
  ["Büyükçekmece",	"Karaağaç"],
  ["Büyükçekmece",	"Kavaklı"],
  ["Büyükçekmece",	"Kıraç"],
  ["Büyükçekmece",	"Kumburgaz"],
  ["Büyükçekmece",	"Marmara"],
  ["Büyükçekmece",	"Mega Kent"],
  ["Büyükçekmece",	"Mehter Çeşme"],
  ["Büyükçekmece",	"Merkez"],
  ["Büyükçekmece",	"Migros Arkası"],
  ["Büyükçekmece",	"Mimaroba"],
  ["Büyükçekmece",	"Murat Çeşme"],
  ["Büyükçekmece",	"Namık Kemal"],
  ["Büyükçekmece",	"Ondokuz Mayıs"],
  ["Büyükçekmece",	"Örnek"],
  ["Büyükçekmece",	"Palmiye Evleri"],
  ["Büyükçekmece",	"Parlamenterler Sitesi"],
  ["Büyükçekmece",	"Pınartepe"],
  ["Büyükçekmece",	"Saadet Dere"],
  ["Büyükçekmece",	"Sahil"],
  ["Büyükçekmece",	"Sinanoba"],
  ["Büyükçekmece",	"Talatpaşa"],
  ["Büyükçekmece",	"TEVD Sağlık Sitesi"],
  ["Büyükçekmece",	"Türkoba"],
  ["Büyükçekmece",	"Ulus"],
  ["Büyükçekmece",	"Yakuplu"],
  ["Büyükçekmece",	"Yenikent"],
  ["Büyükçekmece",	"Yenimahalle"],
  ["Çatalca",	"Akalan"],
  ["Çatalca",	"Atatürk"],
  ["Çatalca",	"Bahsayış"],
  ["Çatalca",	"Cami"],
  ["Çatalca",	"Çakıl"],
  ["Çatalca",	"Çanakça"],
  ["Çatalca",	"Deliklikaya"],
  ["Çatalca",	"Dursunköy"],
  ["Çatalca",	"Durusu (Terkos)"],
  ["Çatalca",	"Elbasan"],
  ["Çatalca",	"Fatih"],
  ["Çatalca",	"Ferhatpaşa"],
  ["Çatalca",	"Gökçeali"],
  ["Çatalca",	"Hastane"],
  ["Çatalca",	"İhsaniye"],
  ["Çatalca",	"İnceğiz"],
  ["Çatalca",	"İstasyon"],
  ["Çatalca",	"İzzettin"],
  ["Çatalca",	"Kabakça"],
  ["Çatalca",	"Kestanelik"],
  ["Çatalca",	"Merkez"],
  ["Çatalca",	"Nakkaş"],
  ["Çatalca",	"Oklalı"],
  ["Çatalca",	"Orcunlu"],
  ["Çatalca",	"Ovayenice"],
  ["Çatalca",	"Ömerli"],
  ["Çatalca",	"Sazlıbosna"],
  ["Çatalca",	"Subaşı"],
  ["Çatalca",	"Yazlık"],
  ["Çatalca",	"Yeşilbayır"],
  ["Çatalca",	"Zafer"],
  ["Eminönü",	"Aksaray"],
  ["Eminönü",	"Alemdar"],
  ["Eminönü",	"Balabanağa"],
  ["Eminönü",	"Beyazıt"],
  ["Eminönü",	"Binbir Direk"],
  ["Eminönü",	"Cağaloğlu"],
  ["Eminönü",	"Cankurtaran"],
  ["Eminönü",	"Cerrahpaşa"],
  ["Eminönü",	"Çapa"],
  ["Eminönü",	"Çemberlitaş"],
  ["Eminönü",	"Demirtaş"],
  ["Eminönü",	"Emin Sinan"],
  ["Eminönü",	"Fındıklı"],
  ["Eminönü",	"Fındıkzade"],
  ["Eminönü",	"Gülhane"],
  ["Eminönü",	"Hacı Kadın"],
  ["Eminönü",	"Hobyar"],
  ["Eminönü",	"Hoca Gıyasettin"],
  ["Eminönü",	"Hocapaşa"],
  ["Eminönü",	"Kalenderhane"],
  ["Eminönü",	"Karaköy"],
  ["Eminönü",	"Katip Kasım"],
  ["Eminönü",	"Kemal Paşa"],
  ["Eminönü",	"Kumkapı"],
  ["Eminönü",	"Küçük Ayasofya"],
  ["Eminönü",	"Laleli"],
  ["Eminönü",	"Mercan"],
  ["Eminönü",	"Merkez"],
  ["Eminönü",	"Mesih Paşa"],
  ["Eminönü",	"Mimar Hayrettin"],
  ["Eminönü",	"Mimar Kemalettin"],
  ["Eminönü",	"Molla Fenari"],
  ["Eminönü",	"Molla Hüsrev"],
  ["Eminönü",	"Muhsine Hatun"],
  ["Eminönü",	"Nişanca"],
  ["Eminönü",	"Rüstem Paşa"],
  ["Eminönü",	"Samatya"],
  ["Eminönü",	"Saraçishak"],
  ["Eminönü",	"Sarıdemir"],
  ["Eminönü",	"Sirkeci"],
  ["Eminönü",	"Sultanahmet"],
  ["Eminönü",	"Sururi"],
  ["Eminönü",	"Süleymaniye"],
  ["Eminönü",	"Şehremini"],
  ["Eminönü",	"Şehsuvar Bey"],
  ["Eminönü",	"Şehzabaşı"],
  ["Eminönü",	"Şişhane"],
  ["Eminönü",	"Tahtakale"],
  ["Eminönü",	"Taya Hatun"],
  ["Eminönü",	"Vefa"],
  ["Eminönü",	"Yavuz Sinan"],
  ["Eminönü",	"Yenikapı"],
  ["Esenler",	"Askeri Bölge"],
  ["Esenler",	"Başakşehir"],
  ["Esenler",	"Başakşehir 1. Etap"],
  ["Esenler",	"Başakşehir 2. Etap"],
  ["Esenler",	"Başakşehir 4. Etap"],
  ["Esenler",	"Birlik Mah."],
  ["Esenler",	"Davutpaşa"],
  ["Esenler",	"Fatih Mah."],
  ["Esenler",	"Fevzi Çakmak"],
  ["Esenler",	"Habibler"],
  ["Esenler",	"Havaalanı"],
  ["Esenler",	"Karabayır Mah."],
  ["Esenler",	"Kazım Karabekir"],
  ["Esenler",	"Kemer"],
  ["Esenler",	"Menderes"],
  ["Esenler",	"Merkez"],
  ["Esenler",	"Mimar Sinan"],
  ["Esenler",	"Namık Kemal"],
  ["Esenler",	"Nine Hatun"],
  ["Esenler",	"Oruç Reis"],
  ["Esenler",	"Turgut Reis"],
  ["Esenler",	"Yavuz Selim"],
  ["Esenyurt",	"Esenkent"],
  ["Esenyurt",	"Merkez"],
  ["Esenyurt",	"Şelale Evleri"],
  ["Eyüp",	"Akşemsettin"],
  ["Eyüp",	"Alibeyköy"],
  ["Eyüp",	"Burgaz Evleri"],
  ["Eyüp",	"Çırçır"],
  ["Eyüp",	"Defterdar"],
  ["Eyüp",	"Düğmeciler"],
  ["Eyüp",	"Emniyettepe"],
  ["Eyüp",	"Esentepe"],
  ["Eyüp",	"Güzeltepe (Askeri Bölge)"],
  ["Eyüp",	"İslambey"],
  ["Eyüp",	"Karadolap"],
  ["Eyüp",	"Kemer Country"],
  ["Eyüp",	"Kemerburgaz"],
  ["Eyüp",	"Merkez"],
  ["Eyüp",	"Mimar Sinan Paşa"],
  ["Eyüp",	"Mithat Paşa"],
  ["Eyüp",	"Nişancı Mustafa"],
  ["Eyüp",	"Rami Cuma"],
  ["Eyüp",	"Rami Yeni"],
  ["Eyüp",	"Sakarya"],
  ["Eyüp",	"Silahtar Ağa"],
  ["Eyüp",	"Topçular"],
  ["Eyüp",	"Yayla"],
  ["Eyüp",	"Yeşilpınar"],
  ["Fatih",	"Abdi Çelebi"],
  ["Fatih",	"Abdi Subaşı"],
  ["Fatih",	"Akdeniz"],
  ["Fatih",	"Aksaray"],
  ["Fatih",	"Ali Faki"],
  ["Fatih",	"Arabacı Beyazıt"],
  ["Fatih",	"Arpacı Emin"],
  ["Fatih",	"Atik Mustafa Paşa"],
  ["Fatih",	"Avcıbey"],
  ["Fatih",	"Baba Hasan Alemi"],
  ["Fatih",	"Balat"],
  ["Fatih",	"Balat Karabaş"],
  ["Fatih",	"Beyazıt Ağa"],
  ["Fatih",	"Beyceğiz"],
  ["Fatih",	"Cambaziye"],
  ["Fatih",	"Cibali"],
  ["Fatih",	"Çakır Ağa"],
  ["Fatih",	"Deniz Abdal"],
  ["Fatih",	"Derviş Ali"],
  ["Fatih",	"Edirnekapı"],
  ["Fatih",	"Ereğli"],
  ["Fatih",	"Fatma Sultan"],
  ["Fatih",	"Fener"],
  ["Fatih",	"Fevzipaşa"],
  ["Fatih",	"Fındıkzade"],
  ["Fatih",	"Gureba Hüseyin Ağa"],
  ["Fatih",	"Hacı Evhadettin"],
  ["Fatih",	"Halıcılar"],
  ["Fatih",	"Haliç"],
  ["Fatih",	"Hamami Muhittin"],
  ["Fatih",	"Haraccı Kara Mehmet"],
  ["Fatih",	"Hasan Halife"],
  ["Fatih",	"Hatice Sultan"],
  ["Fatih",	"Hatip Musluhittin"],
  ["Fatih",	"Haydar"],
  ["Fatih",	"Hızır Çavuş"],
  ["Fatih",	"Hoca Üveyz"],
  ["Fatih",	"Horhor"],
  ["Fatih",	"Hüsam Bey"],
  ["Fatih",	"İbrahim Çavuş"],
  ["Fatih",	"İmrahor"],
  ["Fatih",	"İnebey"],
  ["Fatih",	"İskender Paşa"],
  ["Fatih",	"Karadeniz Cad."],
  ["Fatih",	"Karagümrük"],
  ["Fatih",	"Karye-i Atik"],
  ["Fatih",	"Kasap Demirhun"],
  ["Fatih",	"Kasap İlyas"],
  ["Fatih",	"Kasım Gönani"],
  ["Fatih",	"Katip Musluhittin"],
  ["Fatih",	"Keçeci Karabaş"],
  ["Fatih",	"Keçi Hatun"],
  ["Fatih",	"Kırık Çeşme"],
  ["Fatih",	"Kırmasti"],
  ["Fatih",	"Kıztaşı"],
  ["Fatih",	"Koca Dede"],
  ["Fatih",	"Kocamustafapaşa"],
  ["Fatih",	"Kocasinan"],
  ["Fatih",	"Küçük Mustafa Paşa"],
  ["Fatih",	"Kürkçübaşı"],
  ["Fatih",	"Macar Kardeşler"],
  ["Fatih",	"Melek Hatun"],
  ["Fatih",	"Merkez"],
  ["Fatih",	"Mimar Sinan"],
  ["Fatih",	"Molla Aşkı"],
  ["Fatih",	"Molla Şeref"],
  ["Fatih",	"Muhtesip İskender"],
  ["Fatih",	"Murat Paşa"],
  ["Fatih",	"Müftü Ali"],
  ["Fatih",	"N.İbrahimpaşa Cad."],
  ["Fatih",	"Neslişah"],
  ["Fatih",	"Nevbahar"],
  ["Fatih",	"Ördek Kasap"],
  ["Fatih",	"Rami"],
  ["Fatih",	"Samatya"],
  ["Fatih",	"Sancaktar Hayrettin"],
  ["Fatih",	"Sarıgüzel"],
  ["Fatih",	"Seyit Ömer"],
  ["Fatih",	"Sinan Ağa"],
  ["Fatih",	"Sofular"],
  ["Fatih",	"Şeyh Resmi"],
  ["Fatih",	"Tevkii Cafer"],
  ["Fatih",	"Topkapı"],
  ["Fatih",	"Unkapanı"],
  ["Fatih",	"Uzun Yusuf"],
  ["Fatih",	"Veledi Karabaş"],
  ["Fatih",	"Yalı"],
  ["Fatih",	"Yavuz Selim"],
  ["Gaziosmanpaşa",	"Arnavutköy"],
  ["Gaziosmanpaşa",	"Bağlarbaşı"],
  ["Gaziosmanpaşa",	"Beşyüzevler"],
  ["Gaziosmanpaşa",	"Cebeci"],
  ["Gaziosmanpaşa",	"Cumhuriyet"],
  ["Gaziosmanpaşa",	"Çukurçeşme"],
  ["Gaziosmanpaşa",	"Ellinci Yıl"],
  ["Gaziosmanpaşa",	"Esentepe"],
  ["Gaziosmanpaşa",	"Fevzi Çakmak"],
  ["Gaziosmanpaşa",	"Gazi Mah."],
  ["Gaziosmanpaşa",	"Habibler"],
  ["Gaziosmanpaşa",	"Hürriyet"],
  ["Gaziosmanpaşa",	"İsmet Paşa"],
  ["Gaziosmanpaşa",	"Karayolları"],
  ["Gaziosmanpaşa",	"Karlıtepe"],
  ["Gaziosmanpaşa",	"Kazım Karabekir"],
  ["Gaziosmanpaşa",	"Küçükköy"],
  ["Gaziosmanpaşa",	"Merkez"],
  ["Gaziosmanpaşa",	"Pazariçi"],
  ["Gaziosmanpaşa",	"Sarıgöl"],
  ["Gaziosmanpaşa",	"Sultançiftliği"],
  ["Gaziosmanpaşa",	"Şemsipaşa"],
  ["Gaziosmanpaşa",	"Uğur Mumcu"],
  ["Gaziosmanpaşa",	"Yenidoğan"],
  ["Gaziosmanpaşa",	"Yıldız Tabya"],
  ["Gaziosmanpaşa",	"Zübeyde"],
  ["Güngören",	"Abdurrahman Nafiz Gürman"],
  ["Güngören",	"Akıncılar"],
  ["Güngören",	"Camlıkahve"],
  ["Güngören",	"Çifte Havuzlar"],
  ["Güngören",	"Genç Osman"],
  ["Güngören",	"Güneştepe"],
  ["Güngören",	"Güven Mah."],
  ["Güngören",	"Haznedar"],
  ["Güngören",	"İnönü Cad."],
  ["Güngören",	"Mareşal Çakmak"],
  ["Güngören",	"Mehmet Nezihi Özmen"],
  ["Güngören",	"Merkez"],
  ["Güngören",	"Merter"],
  ["Güngören",	"Sanayi"],
  ["Güngören",	"Tozkoparan"],
  ["Güngören",	"Üçyüzlü"],
  ["Kadıköy",	"Alt Bostancı"],
  ["Kadıköy",	"Altıyol"],
  ["Kadıköy",	"Ataşehir"],
  ["Kadıköy",	"Atatürk"],
  ["Kadıköy",	"Ayşekadın"],
  ["Kadıköy",	"Bahariye"],
  ["Kadıköy",	"Barbaros"],
  ["Kadıköy",	"Bostancı"],
  ["Kadıköy",	"Caddebostan"],
  ["Kadıköy",	"Caferağa"],
  ["Kadıköy",	"Çatalçeşme"],
  ["Kadıköy",	"Çiftehavuzlar"],
  ["Kadıköy",	"Dalyan"],
  ["Kadıköy",	"Dumlupınar"],
  ["Kadıköy",	"Eğitim"],
  ["Kadıköy",	"Erenköy"],
  ["Kadıköy",	"Fenerbahçe"],
  ["Kadıköy",	"Feneryolu"],
  ["Kadıköy",	"Fikirtepe"],
  ["Kadıköy",	"Göztepe"],
  ["Kadıköy",	"Halitağa"],
  ["Kadıköy",	"Hasanpaşa"],
  ["Kadıköy",	"Haydarpaşa"],
  ["Kadıköy",	"Hilal Konakları"],
  ["Kadıköy",	"İbrahimağa"],
  ["Kadıköy",	"İçerenköy"],
  ["Kadıköy",	"İnönü"],
  ["Kadıköy",	"Kalamış"],
  ["Kadıköy",	"Kayışdağı"],
  ["Kadıköy",	"Kızıltoprak"],
  ["Kadıköy",	"Koşuyolu"],
  ["Kadıköy",	"Kozyatağı"],
  ["Kadıköy",	"Kuşdili"],
  ["Kadıköy",	"Kuyubaşı"],
  ["Kadıköy",	"Küçükbakkalköy"],
  ["Kadıköy",	"Merdivenköy"],
  ["Kadıköy",	"Merkez"],
  ["Kadıköy",	"Misakı Milli"],
  ["Kadıköy",	"Moda"],
  ["Kadıköy",	"Ondokuz Mayıs"],
  ["Kadıköy",	"Osman Ağa"],
  ["Kadıköy",	"Rasim Paşa"],
  ["Kadıköy",	"Rıhtım"],
  ["Kadıköy",	"Sahra-i Cedid"],
  ["Kadıköy",	"Selamiçeşme"],
  ["Kadıköy",	"Söğütlüçeşme"],
  ["Kadıköy",	"Suadiye"],
  ["Kadıköy",	"Şaşkınbakkal"],
  ["Kadıköy",	"Şenesenevler"],
  ["Kadıköy",	"Üst Bostancı"],
  ["Kadıköy",	"Yeldeğirmeni"],
  ["Kadıköy",	"Yeni Sahra"],
  ["Kadıköy",	"Ziverbey"],
  ["Kadıköy",	"Zühtü Paşa"],
  ["Kağıthane",	"Başak Konutları"],
  ["Kağıthane",	"Cendere"],
  ["Kağıthane",	"Çağlayan"],
  ["Kağıthane",	"Çeliktepe"],
  ["Kağıthane",	"Emniyet Evleri"],
  ["Kağıthane",	"Gültepe"],
  ["Kağıthane",	"Gürsel"],
  ["Kağıthane",	"Harmantepe"],
  ["Kağıthane",	"Hürriyet"],
  ["Kağıthane",	"Merkez"],
  ["Kağıthane",	"Ortabayır"],
  ["Kağıthane",	"Sadabat Evleri"],
  ["Kağıthane",	"Sanayi"],
  ["Kağıthane",	"Seyrantepe"],
  ["Kağıthane",	"Şirintepe"],
  ["Kağıthane",	"Talatpaşa"],
  ["Kağıthane",	"Telsizler"],
  ["Kağıthane",	"Yahya Kemal"],
  ["Kağıthane",	"Yeşilce"],
  ["Kartal",	"Cevizli"],
  ["Kartal",	"Cumhuriyet"],
  ["Kartal",	"Çarşı"],
  ["Kartal",	"Çavuşoğlu"],
  ["Kartal",	"Dragos"],
  ["Kartal",	"Esentepe"],
  ["Kartal",	"Gümüşpınar"],
  ["Kartal",	"Hürriyet"],
  ["Kartal",	"Karlıktepe"],
  ["Kartal",	"Kordonboyu"],
  ["Kartal",	"Merkez"],
  ["Kartal",	"Orhantepe"],
  ["Kartal",	"Ortabayır"],
  ["Kartal",	"Paşaköy"],
  ["Kartal",	"Pendik"],
  ["Kartal",	"Petrol İş"],
  ["Kartal",	"Rahmanlar"],
  ["Kartal",	"Samandıra"],
  ["Kartal",	"Soğanlık"],
  ["Kartal",	"Topselvi"],
  ["Kartal",	"Uğur Mumcu"],
  ["Kartal",	"Yakacık"],
  ["Kartal",	"Yalı"],
  ["Kartal",	"Yeni Mahalle"],
  ["Kartal",	"Yukarı Mahalle"],
  ["Küçükçekmece",	"Askeri Bölge"],
  ["Küçükçekmece",	"Atatürk"],
  ["Küçükçekmece",	"Beşyol"],
  ["Küçükçekmece",	"Cennet"],
  ["Küçükçekmece",	"Cumhuriyet"],
  ["Küçükçekmece",	"Esenler 1. Etap"],
  ["Küçükçekmece",	"Esenler 2. Etap"],
  ["Küçükçekmece",	"Fatih"],
  ["Küçükçekmece",	"Fevzi Çakmak"],
  ["Küçükçekmece",	"Gültepe"],
  ["Küçükçekmece",	"Halkalı Altınşehir"],
  ["Küçükçekmece",	"Halkalı İstasyon"],
  ["Küçükçekmece",	"Halkalı Toplu Konutlar"],
  ["Küçükçekmece",	"İkitelli"],
  ["Küçükçekmece",	"Kanarya"],
  ["Küçükçekmece",	"Kartaltepe"],
  ["Küçükçekmece",	"Kayabaşı"],
  ["Küçükçekmece",	"Kemalpaşa"],
  ["Küçükçekmece",	"Mehmet Akif"],
  ["Küçükçekmece",	"Merkez"],
  ["Küçükçekmece",	"Org. San. Böl."],
  ["Küçükçekmece",	"Sefaköy"],
  ["Küçükçekmece",	"Soyak Olympiakent"],
  ["Küçükçekmece",	"Söğütlü Çeşme"],
  ["Küçükçekmece",	"Şamlar"],
  ["Küçükçekmece",	"Tevfik Fikret"],
  ["Küçükçekmece",	"Yeni Mahalle"],
  ["Küçükçekmece",	"Yeşilova"],
  ["Küçükçekmece",	"Ziya Gökalp"],
  ["Maltepe",	"Adatepe"],
  ["Maltepe",	"Altayçeşme"],
  ["Maltepe",	"Altıntepe"],
  ["Maltepe",	"Askeri Bölge"],
  ["Maltepe",	"Aydınevler"],
  ["Maltepe",	"Bağlarbaşı"],
  ["Maltepe",	"Başıbüyük"],
  ["Maltepe",	"Büyükbakkalköy"],
  ["Maltepe",	"Cevizli"],
  ["Maltepe",	"Çınar"],
  ["Maltepe",	"Dragos"],
  ["Maltepe",	"Esenkent"],
  ["Maltepe",	"Ferhatpaşa"],
  ["Maltepe",	"Feyzullah"],
  ["Maltepe",	"Fındıklı"],
  ["Maltepe",	"Girne"],
  ["Maltepe",	"Gülensu"],
  ["Maltepe",	"Gülsuyu"],
  ["Maltepe",	"İdealtepe"],
  ["Maltepe",	"Küçükyalı"],
  ["Maltepe",	"Merkez"],
  ["Maltepe",	"Süreyya Plajı"],
  ["Maltepe",	"Yalı"],
  ["Maltepe",	"Zümrütevler"],
  ["Pendik",	"Ahmet Yesevi"],
  ["Pendik",	"Aydos Evleri"],
  ["Pendik",	"Bahçelievler"],
  ["Pendik",	"Batı"],
  ["Pendik",	"Çamçeşme"],
  ["Pendik",	"Çınardere"],
  ["Pendik",	"Doğu"],
  ["Pendik",	"Dolayoba Sos. Konut."],
  ["Pendik",	"Dolayoba Taşlıbayır Konut."],
  ["Pendik",	"Dumlupınar"],
  ["Pendik",	"Ertuğrulgazi"],
  ["Pendik",	"Esenyalı"],
  ["Pendik",	"Fatih"],
  ["Pendik",	"Fevzi Çakmak"],
  ["Pendik",	"Güllübağlar"],
  ["Pendik",	"Güzel Yalı"],
  ["Pendik",	"Harmandere"],
  ["Pendik",	"Kavakpınar"],
  ["Pendik",	"Kaynarca"],
  ["Pendik",	"Kurtdoğmuş Köyü"],
  ["Pendik",	"Kurtköy"],
  ["Pendik",	"Merkez"],
  ["Pendik",	"Orhangazi"],
  ["Pendik",	"Orta Mahalle"],
  ["Pendik",	"Ömerli"],
  ["Pendik",	"Ramazanoğlu"],
  ["Pendik",	"Sapan Bağları"],
  ["Pendik",	"Sülüntepe"],
  ["Pendik",	"Şeyhli Hilal Konutları"],
  ["Pendik",	"Uydukent"],
  ["Pendik",	"Veli Baba"],
  ["Pendik",	"Yayalar"],
  ["Pendik",	"Yeni Mahalle"],
  ["Pendik",	"Yeşilbağlar"],
  ["Sarıyer",	"Askeri Bölge"],
  ["Sarıyer",	"Atlantis Konutları"],
  ["Sarıyer",	"Bahçeköy"],
  ["Sarıyer",	"Baltalimanı"],
  ["Sarıyer",	"Büyükdere"],
  ["Sarıyer",	"Cumhuriyet"],
  ["Sarıyer",	"Çamlıtepe"],
  ["Sarıyer",	"Çayırbaşı"],
  ["Sarıyer",	"Dağevleri"],
  ["Sarıyer",	"Darüşşafaka"],
  ["Sarıyer",	"Demirciköy"],
  ["Sarıyer",	"Derbent"],
  ["Sarıyer",	"Emirgan"],
  ["Sarıyer",	"Fatih Sultan Mehmet"],
  ["Sarıyer",	"Ferahevler"],
  ["Sarıyer",	"Garipçe"],
  ["Sarıyer",	"Gazeteciler Sitesi"],
  ["Sarıyer",	"Hisarüstü"],
  ["Sarıyer",	"İstinye"],
  ["Sarıyer",	"İstinye Boğaziçi Evleri"],
  ["Sarıyer",	"Kilyos"],
  ["Sarıyer",	"Kireçburnu"],
  ["Sarıyer",	"Kocataş"],
  ["Sarıyer",	"Kocatepe"],
  ["Sarıyer",	"Koru Evleri"],
  ["Sarıyer",	"Maden"],
  ["Sarıyer",	"Merkez"],
  ["Sarıyer",	"P.T.T. Evleri"],
  ["Sarıyer",	"Pınar Mah."],
  ["Sarıyer",	"Poligon"],
  ["Sarıyer",	"Reşitpaşa"],
  ["Sarıyer",	"Rumeli Feneri"],
  ["Sarıyer",	"Rumeli Hisarı"],
  ["Sarıyer",	"Rumeli Kavağı"],
  ["Sarıyer",	"Simpaş Konutları"],
  ["Sarıyer",	"Tarabya"],
  ["Sarıyer",	"Uskumruköy"],
  ["Sarıyer",	"Yeniköy"],
  ["Sarıyer",	"Yenimahalle"],
  ["Sarıyer",	"Yonca Evleri"],
  ["Sarıyer",	"Zekeriyaköy"],
  ["Sarıyer",	"Zekeriyaköy Konutları"],
  ["Sarıyer",	"Zümrütevler"],
  ["Silivri",	"Büyük Sinekli Köyü"],
  ["Silivri",	"Değirmenköy"],
  ["Silivri",	"Gümüşyaka"],
  ["Silivri",	"Kınalı"],
  ["Silivri",	"Merkez"],
  ["Silivri",	"Ortaköy"],
  ["Sultanbeyli",	"Fatih"],
  ["Sultanbeyli",	"Gazi"],
  ["Sultanbeyli",	"Mehmet Akif"],
  ["Sultanbeyli",	"Merkez"],
  ["Sultanbeyli",	"Turgutreis"],
  ["Sultanbeyli",	"Tüyap Beylik Düzü"],
  ["Şile",	"Ağlayankaya"],
  ["Şile",	"Ağva"],
  ["Şile",	"Ahmetli Köyü"],
  ["Şile",	"Akçakese Köyü"],
  ["Şile",	"Balibey"],
  ["Şile",	"İmrenli"],
  ["Şile",	"Kumbaba"],
  ["Şile",	"Merkez"],
  ["Şile",	"Ulupelit Köyü"],
  ["Şile",	"Yeşilvadi"],
  ["Şişli",	"Ayazağa"],
  ["Şişli",	"Bozkurt"],
  ["Şişli",	"Cumhuriyet"],
  ["Şişli",	"Çağlayan"],
  ["Şişli",	"Çifte Cevizler"],
  ["Şişli",	"Duatepe"],
  ["Şişli",	"Elmadağ"],
  ["Şişli",	"Esentepe"],
  ["Şişli",	"Feriköy"],
  ["Şişli",	"Fulya"],
  ["Şişli",	"Gayrettepe"],
  ["Şişli",	"Gülbağ"],
  ["Şişli",	"Gülbahar"],
  ["Şişli",	"Halaskargazi"],
  ["Şişli",	"Halide Edip Adıvar"],
  ["Şişli",	"Halil Rıfat Paşa"],
  ["Şişli",	"Harbiye"],
  ["Şişli",	"Huzur"],
  ["Şişli",	"İnönü"],
  ["Şişli",	"İzzet Paşa"],
  ["Şişli",	"Kaptan Paşa"],
  ["Şişli",	"Kurtuluş"],
  ["Şişli",	"Kuştepe"],
  ["Şişli",	"Maçka"],
  ["Şişli",	"Mahmut Şevket"],
  ["Şişli",	"Maslak"],
  ["Şişli",	"Mecidiyeköy"],
  ["Şişli",	"Mecidiyeköy Marmara Sitesi"],
  ["Şişli",	"Mecidiyeköy Profilo"],
  ["Şişli",	"Merkez"],
  ["Şişli",	"Mesa Maslak Evleri"],
  ["Şişli",	"Meşrutiyet"],
  ["Şişli",	"Nişantaşı"],
  ["Şişli",	"Okmeydanı"],
  ["Şişli",	"Ondokuz Mayıs"],
  ["Şişli",	"Osmanbey"],
  ["Şişli",	"Pangaltı"],
  ["Şişli",	"Paşa"],
  ["Şişli",	"Seyrantepe"],
  ["Şişli",	"Teşvikiye"],
  ["Şişli",	"Topağacı"],
  ["Şişli",	"Yayla"],
  ["Şişli",	"Zincirlikuyu"],
  ["Tuzla",	"Aydınlı"],
  ["Tuzla",	"Aydıntepe"],
  ["Tuzla",	"Bayramoğlu"],
  ["Tuzla",	"Cami"],
  ["Tuzla",	"Çamlıbel"],
  ["Tuzla",	"Evliya Çelebi"],
  ["Tuzla",	"İçmeler"],
  ["Tuzla",	"İstasyon"],
  ["Tuzla",	"Merkez"],
  ["Tuzla",	"Mimarsinan"],
  ["Tuzla",	"Postahane"],
  ["Tuzla",	"Postane"],
  ["Tuzla",	"Şifa"],
  ["Tuzla",	"Tepeören"],
  ["Tuzla",	"Üçmeşeler"],
  ["Tuzla",	"Yayla"],
  ["Ümraniye",	"Alemdağ"],
  ["Ümraniye",	"Alemdar"],
  ["Ümraniye",	"Aqua City"],
  ["Ümraniye",	"Aqua Manors"],
  ["Ümraniye",	"Aşağı Dudullu"],
  ["Ümraniye",	"Atakent"],
  ["Ümraniye",	"Atatürk"],
  ["Ümraniye",	"Çakmak"],
  ["Ümraniye",	"Çekmeköy"],
  ["Ümraniye",	"Dudullu"],
  ["Ümraniye",	"Ekşioğlu Beşyıldız"],
  ["Ümraniye",	"Esenşehir"],
  ["Ümraniye",	"Hekimbaşı"],
  ["Ümraniye",	"Ihlamurkuyu"],
  ["Ümraniye",	"İnkilap"],
  ["Ümraniye",	"İstiklal"],
  ["Ümraniye",	"Kazım Karabekir"],
  ["Ümraniye",	"Merkez"],
  ["Ümraniye",	"Mustafa Kemal"],
  ["Ümraniye",	"Namık Kemal"],
  ["Ümraniye",	"Ömerli"],
  ["Ümraniye",	"Polonezköy"],
  ["Ümraniye",	"Reşadiye"],
  ["Ümraniye",	"Sarıgazi"],
  ["Ümraniye",	"Soyak Yenişehir"],
  ["Ümraniye",	"Taşdelen"],
  ["Ümraniye",	"Tepeüstü"],
  ["Ümraniye",	"Y.Çamlıca"],
  ["Ümraniye",	"Yukarı Dudullu"],
  ["Üsküdar",	"Abdullahağa"],
  ["Üsküdar",	"Acıbadem"],
  ["Üsküdar",	"Ahçıbaşı"],
  ["Üsküdar",	"Ahmet Çelebi"],
  ["Üsküdar",	"Altunizade"],
  ["Üsküdar",	"Arakiyeci Hacı Cafer"],
  ["Üsküdar",	"Arakiyeci Hacı Mehmet"],
  ["Üsküdar",	"Ayazma"],
  ["Üsküdar",	"Bağlarbaşı"],
  ["Üsküdar",	"Bahçelievler"],
  ["Üsküdar",	"Barbaros"],
  ["Üsküdar",	"Beylerbeyi"],
  ["Üsküdar",	"Bulgurlu"],
  ["Üsküdar",	"Burhaniye"],
  ["Üsküdar",	"Cumhuriyet"],
  ["Üsküdar",	"Çamlıca"],
  ["Üsküdar",	"Çamlıktepe"],
  ["Üsküdar",	"Çengelköy"],
  ["Üsküdar",	"Emek"],
  ["Üsküdar",	"Emniyet"],
  ["Üsküdar",	"Esatpaşa"],
  ["Üsküdar",	"Ferah"],
  ["Üsküdar",	"Fetih"],
  ["Üsküdar",	"Fıstıkağacı"],
  ["Üsküdar",	"Gülfem Hatun"],
  ["Üsküdar",	"Güzeltepe"],
  ["Üsküdar",	"Hacı Hesna Hatun"],
  ["Üsküdar",	"Harem"],
  ["Üsküdar",	"Havuzbaşı"],
  ["Üsküdar",	"Hayrettin Çavuş"],
  ["Üsküdar",	"İcadiye"],
  ["Üsküdar",	"İhsaniye"],
  ["Üsküdar",	"İmrahor Salacak"],
  ["Üsküdar",	"İnkilap"],
  ["Üsküdar",	"Kandilli"],
  ["Üsküdar",	"Kepçedede"],
  ["Üsküdar",	"Kısıklı"],
  ["Üsküdar",	"Kirazlıtepe"],
  ["Üsküdar",	"Kuleli"],
  ["Üsküdar",	"Kuzguncuk"],
  ["Üsküdar",	"Küçüksu"],
  ["Üsküdar",	"Küplüce"],
  ["Üsküdar",	"Libadiye"],
  ["Üsküdar",	"Murat Reis"],
  ["Üsküdar",	"Nakkaştepe"],
  ["Üsküdar",	"Örnektepe"],
  ["Üsküdar",	"Pazarbaşı"],
  ["Üsküdar",	"Rumimehmet Paşa"],
  ["Üsküdar",	"Selami Ali"],
  ["Üsküdar",	"Selimiye"],
  ["Üsküdar",	"Selman Ağa"],
  ["Üsküdar",	"Solak Sinan"],
  ["Üsküdar",	"Sultantepe"],
  ["Üsküdar",	"Tabaklar"],
  ["Üsküdar",	"Tavasi Hasan Ağa"],
  ["Üsküdar",	"Tembel Hacı Mehmet"],
  ["Üsküdar",	"Toygar Hamza"],
  ["Üsküdar",	"Ünalan"],
  ["Üsküdar",	"Valide-i Atik"],
  ["Üsküdar",	"Vaniköy"],
  ["Üsküdar",	"Yavuztürk"],
  ["Zeytinburnu",	"Beştelsiz"],
  ["Zeytinburnu",	"Çırpıcı"],
  ["Zeytinburnu",	"Deniz Abdal"],
  ["Zeytinburnu",	"Gökalp"],
  ["Zeytinburnu",	"Hatboyu"],
  ["Zeytinburnu",	"Kazlıçeşme"],
  ["Zeytinburnu",	"Maltepe"],
  ["Zeytinburnu",	"Merkez"],
  ["Zeytinburnu",	"Merkez Efendi"],
  ["Zeytinburnu",	"Nuripaşa"],
  ["Zeytinburnu",	"Seyitnizam"],
  ["Zeytinburnu",	"Sümer"],
  ["Zeytinburnu",	"Telsiz"],
  ["Zeytinburnu",	"Topçular"],
  ["Zeytinburnu",	"Veliefendi"],
  ["Zeytinburnu",	"Yeni Doğan"],
  ["Zeytinburnu",	"Yeşiltepe"],
  ["Zeytinburnu",	"Zeytinburnu Olivium"]
]

VALID_DOMAINS = ["@ku.edu.tr"]