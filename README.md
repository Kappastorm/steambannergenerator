#Sadly this project is abandoned has potential security vulnerabilities

# Steam banner oluşturucu
Steam'deki güncel durumunuzu bir badge halinde png dosyasına dönüştürüp, bu resmi *her durumunuz değiştiğinde güncelleyen* bir ruby programı.

### Gerekli Şeyler
Bilgisayarınızda ImageMagick veya GraphicsMagick'in, kullandığınız Ruby versiyonuyla aynı bit versiyonuna sahip bir dağıtımı bulunmalı.
Gemfile'da bulunan gemler bilgisayarınızda bulunmalı.
Steam Web API anahtarı'nız olmalı.
API anahtarını [Steam developer sayfasından](https://steamcommunity.com/dev/registerkey) elde edebilirsiniz.
ImageMagick'in bilgisayarınızda bulunduğundan emin olmak için:
```
$ convert -version
Version: ImageMagick 6.8.9-7 Q16 x86_64 2014-09-11 http://www.imagemagick.org
Copyright: Copyright (C) 1999-2014 ImageMagick Studio LLC
Features: DPC Modules
Delegates: bzlib fftw freetype jng jpeg lcms ltdl lzma png tiff xml zlib
```

GraphicsMagick'in bilgisayarınızda bulunduğundan emin olmak için:
```
$ gm version
GraphicsMagick 1.3.26 2017-07-04 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2017 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
```

### Kurulum
Gerekli gemleri kurmak için öncelikle terminalinize:
```
gem install bundler
```
yazınız. Böylece Gemfile'daki gem listesini daha kolay bir biçimde indirebileceksiniz.

Gemfile'daki gemleri bundler ile kurmak için bu kütüphaneyi klonladığınız klasörde bir terminal açın ve şu kodu yazın:
```
bundle install
```
ImageMagick'i indirmek için [buraya](https://www.imagemagick.org/script/download.php),
GraphicsMagick'i indirmek için [buraya](http://www.graphicsmagick.org/download.html) tıklayınız
**Q8 olan dağıtımlardan Ruby versiyonunuza uygun olan dağıtımı seçtiğinizden emin olun.**

"config.yml"'nin içinde "api_key" kısmına api key'inizi yapıştırın. 
## Nasıl kullanılır?
Çok kolay, main.rb'yi çalıştırdığınız anda zaten size Steam64 ID'nizi veya Özel steam url'nizin sonunda yer alan ID'nizi isteyecek.
Onlara da şöyle erişebilirsiniz;
Steam masaüstü uygulaması için:
-Steam profilinize girin
-Sağ tıklayıp "Sayfa Bağlantısını Kopyala"'ya tıklayın
Steam web için:
-Steam profilinize girin
-Adres barındaki bağlantıyı kopyalayın
Kopyaladığınız bağlantı iki şekilde olacaktır:
```
-http://steamcommunity.com/id/kappastormerino
-http://steamcommunity.com/profiles/76561198065222558
```
Eğer bağlantı 1. gibiyse id/'den sonraki yazıyı, 2. gibiyse profiles/'dan sonrakı sayıyı main.rb'de giriniz.
Program *steamid'niz*.png şeklinde bir resim oluşturacak ve açık kaldığı sürece bunu güncelleyecektir.
### Hatalar
#### Türkçe karakterler gözükmüyor
GraphicsMagick'de bu problemi ben de yaşadım, eğer ImageMagick'i doğru bir biçimde kurmayı başarırsanız Türkçe karakterler doğru gözükecektir.
Alternatif olarak config.yml'nin içinde "no_turkish_characters'ı "True" olarak ayarlarsanız, türkçe karakterler kullanılamyacaktır.
#### ImageMagick/GraphicsMagick not installed
ImageMagick veya GraphicsMagick'den birisini doğru bir biçimde kuramadığınızı ifade eder.
Öncelikle kurmaya çalıştığınız dağıtımın ruby versiyonuzun bit'iyle ayni bit değerinde olduğuna emin olun.
Yine çalışmazsa; ImageMagick kurduysanız GraphicsMagick'i, GraphicsMagick kurduysanız ImageMagick'i kurmayı deneyin.
#### The specified profile could not be found. (SteamCondenserError)
Hatalı steam id girdiğinizi gösterir. Girdiğiniz id'yi kontrol edip tekrar deneyin.
### Örnekler

![online](/examples/online.png?raw=true)
![away](/examples/away.png?raw=true)
![busy](/examples/busy.png?raw=true)
![ingame](/examples/ingame.png?raw=true)
![lookingtoplay](/examples/lookingtoplay.png?raw=true)
![lookingtotrade](/examples/lookingtotrade.png?raw=true)
![offline](/examples/offline.png?raw=true)
###### License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
