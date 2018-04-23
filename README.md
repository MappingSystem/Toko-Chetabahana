<p align="center"> 
<a href="https://chetabahana.com/">
<img src="https://chetabahana.files.wordpress.com/2018/04/logoweb.png" alt="Chetabahana.com | Situs Belanja Jual-Beli Barang & Promo Aneka Produk Fashion, Busana Muslim, Bayi & Anak-anak, Kecantikan, Tas, Sepatu, Peralatan Rumah Tangga, Elektronik, Makanan & Minuman Kemasan, dll. Soon The E-Shop Market Leader Will Be Owned Here!"><br />
WE ARE GOING TO WIN THE MARKET!
</a><br /><br />
</p>


# Toko Chetabahana

:hand: Selamat datang di [Halaman Project](https://github.com/MarketLeader) untuk sesi [**Toko Chetabahana**](https://github.com/MarketLeader/Toko-Chetabahana).

Sesi ini adalah sesi penutup publikasi dari 
[**Tim Chetabahana**](https://github.com/chetabahana) diperuntukkan bagi yang sudah ikuti sesi sebelumnya yaitu: [_Cara Buka Toko Online WinMarket dan Optimasi Internal_](https://chetabahana.blogspot.com/) serta [_Cara Optimasi Eksternal Toko dengan Shop SEO_](https://chetabahana.wordpress.com/).

Di sesi ini kami akan publikasikan cara untuk meningkatkan [_Optimasi Penjualan_](https://support.google.com/adwords/answer/6167176) dari [Toko Online Chetabahana](https://chetabahana.com/) di [Google Search](https://developers.google.com/search/) dan [Google AdWords](https://adwords.google.com/) dengan [_teknik memilah dan menampilkan_](#struktur) produk unggulan secara dinamis.

## Pilosopi
Pilosopi sederhananya bisa dijabarkan sesuai urutan berikut ini:
- Jalankan [Iklan Shopping di AdWords](https://chetabahana.wordpress.com/google-shopping/) untuk dapat data [_produk yang di rekomendasikan_](https://support.google.com/merchants/answer/6288242) via [Google Merchant](https://support.google.com/merchants/answer/188493).  
- Kemudian dari [_peta situs toko_](https://chetabahana.com/sitemap.xml) kita saring [_daftar semua produk_](https://chetabahana.com/product?p=1&c=0&l=60) yang memenuhi kriteria via [Google AppEngine](https://cloud.google.com/appengine/).  
- Hasilnya kita masukkan ke [Google Merchant](https://www.google.com/retail/solutions/merchant-center/) sehingga [_tersimpan menjadi database_](https://support.google.com/merchants/answer/7052112) via [Google Content API](https://developers.google.com/shopping-content/v2/quickstart).  
- Dari database ini kita pilah lagi produk yang mempunyai hasil dan [_peluang terbaik_](https://support.google.com/merchants/answer/7228489?hl=id) via [Google AdWords API](https://developers.google.com/adwords/api/docs/guides/start).  
- Selanjutnya kita tampilkan sebagai produk unggulan di [_Situs Toko dari Google Sites_](http://toko.chetabahana.com/) via [Google Sites API](https://developers.google.com/google-apps/sites/docs/developers_guide).  

## Manfaat
Manfaat yang bisa diperoleh adalah sbb:
- Menampilkan produk unggulan secara dinamis sesuai [Trend](https://support.google.com/adwords/answer/6325039?hl=id) dan [Rekomendasi](https://support.google.com/adwords/answer/3448398) di [Google AdWords](https://adwords.google.com/).
- Tidak memerlukan database karena bisa [_akses dan pakai data_](https://developers.google.com/shopping-content/v2/making-requests) yg sudah dimasukkan di Google Merchant
- Tidak perlukan hosting berbayar karena [Google Site](http://sites.google.com/) adalah Free dan [AppEngine](https://cloud.google.com/appengine/) bisa [_dijalankan secara gratis_](https://stackoverflow.com/questions/18101642/appengine-limit-the-number-of-instances/26654430#26654430).
- Bisa [_Jalankan SEO_](https://support.google.com/webmasters/answer/7451184) untuk produk unggulan dari [Situs Toko](https://chetabahana.com/) via [Google Site](http://toko.chetabahana.com/) untuk berkompetisi di [Google Search](https://www.google.com/search?q=chetabahana)
- Meraih data terkini untuk [_Update Setelan AdWords Secara Otomatis_](https://developers.google.com/adwords/api/docs/guides/start) guna peroleh sales return yang paling optimal.  

## Proses
 Alur dari prosesnya diatur sbb:
- Proses ke-1: Pengelolaan hasil [_Optimasi Internal Toko_](https://developers.google.com/search/docs/guides/) sesuai dengan [_Publikasi Sesi yg Pertama_](https://chetabahana.blogspot.com/) via [Google Sites API](https://developers.google.com/google-apps/sites/docs/developers_guide).
- Proses ke-2: Pendataan hasil [_Optimasi Eksternal_](https://support.google.com/webmasters/answer/40349) sesuai dengan  [_Publikasi Sesi yg Kedua_](https://chetabahana.wordpress.com/) via [Google Content API](https://developers.google.com/shopping-content/v2/quickstart).
- Proses ke-3: Pendataan hasil [_Optimasi Promosi_](https://support.google.com/adwords/answer/3455573?hl=id) dari kinerja proses ke-1 dan -2 via [Google AdWords API](https://developers.google.com/adwords/api/docs/guides/start).
- Proses ke-4: Pengelolaan atas hasil [_Optimasi Penjualan_](https://support.google.com/adwords/answer/6167176) dari kinerja proses ke-3 via [Google AppEngine](https://cloud.google.com/appengine/).
<p align="center"> 
<a href="https://chetabahana.com/product?l=60&o=produk&group=387"><img src="https://user-images.githubusercontent.com/36441664/39117383-03b2a9a4-4711-11e8-9f72-1d1cb7d61634.png" alt="Analisis iklan aneka produk fashion, sepatu, makanan dll dari Toko Online Chetabahana dari Google AdWords"></a>Gambar-1: Analisis pangsa tayang aneka produk <a href=https://chetabahana.com>Toko Online Chetabahana</a> di Iklan Belanja dari Google AdWords
</p>

## Struktur
Struktur dari alur dijalankan dengan [_asas terbalik_](https://en.wikipedia.org/wiki/Algorithm) sbb:
```
Proses ke-4: Google AppEngine (Top_dir)
|-----README.md (yg sedang ada baca)
|-----Proses ke-3: Google-AdWords-API
      |----README.md
      |----Proses ke-2: Google-Content-API
           |----README.md
      |----Proses ke-1: Google-Sites-API
           |----README.md
```
- [Proses ke-1](https://github.com/MarketLeader/Google-Sites-API#google-sites-api): Mulai dari akses ke daftar produk, menyaring data sampai sunting untuk tampilkan produk.
- [Proses ke-2](https://github.com/MarketLeader/Google-Content-API#google-content-api): Mulai dari akses ke saran produk, memilah barang sampai input menjadi database produk.
- [Proses ke-3](https://github.com/MarketLeader/Google-AdWords-API#google-adwords-api): Mulai dari akses ke database produk, kinerja penjualan sampai optimasi setelan promosi.
- [Proses ke-4](#proses): Mengatur konfigurasi, penjadwalan, lalu-lintas data, dan analisa hasil dari semua proses.


## Repositori
Repositori ([_Repo_](https://help.github.com/articles/create-a-repo/)) untuk setiap proses ditempatkan sbb:
- Repo Proses ke-1: [MarketLeader/Google-Sites-API](https://github.com/MarketLeader/Google-Sites-API). Dokumentasinya [_disini_](https://github.com/MarketLeader/Google-Sites-API/wiki)
- Repo Proses ke-2: [MarketLeader/Google-Content-API](https://github.com/MarketLeader/Google-Content-API). Dokumentasinya [_disini_](https://github.com/MarketLeader/Google-Content-API/wiki)
- Repo Proses ke-3: [MarketLeader/Google-AdWords-API](https://github.com/MarketLeader/Google-AdWords-API). Dokumentasinya [_disini_](https://github.com/MarketLeader/Google-AdWords-API/wiki)
- Repo Proses ke-4: [MarketLeader/Toko-Chetabahana](https://github.com/MarketLeader/Toko-Chetabahana) (ini). Dokumentasinya [_disini_](https://github.com/MarketLeader/Toko-Chetabahana/wiki)

## License
Project ini dipublikasikan dengan lisensi berikut:  
[Apache License 2.0](https://github.com/MarketLeader/Toko-Chetabahana/blob/master/LICENSE)

## Pustaka
<p align="center"> 
<a href="https://chetabahana.com/#after_header1_3"><img src="https://user-images.githubusercontent.com/36441664/38942532-44c87736-4359-11e8-9ad4-56f7d2b68ced.png" alt="Alokasi Pustaka Online Chetabahana"></a>Gambar-2: Alokasi Pustaka Online <a href=https://chetabahana.com>Chetabahana</a>
</p>

Disarankan untuk disimak sebelum melangkah lebih jauh:  
- [Cara Buka Toko Online WinMarket dan Optimasi Internal](https://chetabahana.blogspot.com/)
- [Cara Optimasi Eksternal Toko dengan Shop SEO](https://chetabahana.wordpress.com/)
- [Channel Youtube Chetabahana](https://www.youtube.com/channel/UCZlPku9beXzdROCknYLuRNg?view_as=subscriber)
- [e-Books Chetabahana](https://www.scribd.com/user/401259110/Chetabahana)

## Penutup
Berikut ini beberapa catatan sebagai penutup:  
- Projek ini diprioriostaskan bagi peminat [e-Commerce di Indonesia](https://www.youtube.com/watch?v=dd__L8Jh2c4&t=25s) 🇮🇩
- Status masih pengembangan dan pengetesan implementasi
- Syarat untuk bergabung silahkan [Daftar ID WinMarket](https://www.winmarket.id/?b=01647234)
- Tim WinMarket welcome untuk bergabung.

Terimakasih atas kunjungannya.  
Met menyimak.. :pray:  

SALAM Sukses!  
:copyright: [**Tim Chetabahana**](https://github.com/chetabahana)  
[![profile for Chetabahana on Stack Exchange, a network of free, community-driven Q&amp;A sites](https://stackexchange.com/users/flair/5054985.png)](https://stackoverflow.com/users/4058484/chetabahana?tab=profile)   
