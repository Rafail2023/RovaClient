# Gerekli kütüphaneler
import os
import sys
import webbrowser
import random
import time
import requests
from pystyle import Write, Colors, Anime, Center, Colorate

# Yönlendirilecek ana uygulamanın (main2) linki
MAIN_APP_URL = "https://raw.githubusercontent.com/Rafail2023/RovaClient/refs/heads/main/main2"

# --- SPONSOR BİLGİLERİ ---
# Buradaki listeyi kendine göre düzenleyebilirsin.
SPONSOR_LISTESI = [
    {
        "isim": "Sponsor Sunucu",
        "bilgi": "Bu Sponsorumuz size ucuza ve kaliteli bir şekilde VDS/VPS hizmeti sunar.",
        "url": "https://www.google.com" # Sponsorun web sitesi veya Discord linki
    },
    {
        "isim": "Grafik Tasarım",
        "bilgi": "Her türlü oyun ve Discord sunucusu için profesyonel tasarımlar.",
        "url": "https://www.youtube.com"
    },
    {
        "isim": "Rova Community",
        "bilgi": "Oyun turnuvaları ve etkinlikler düzenleyen resmi topluluğumuz.",
        "url": "https://discord.com"
    }
]
# -----------------------------------------------------------------------------------

def show_sponsor_ad():
    """Rastgele bir sponsor seçer, yeni tasarıma göre reklamı gösterir ve ana uygulamaya geçer."""
    os.system('cls')
    
    secilen_sponsor = random.choice(SPONSOR_LISTESI)
    webbrowser.open(secilen_sponsor["url"])
    
    # 1. Adım: RGB Sponsor İsmi
    Anime.Fade(Center.Center(secilen_sponsor["isim"]), Colors.red_to_yellow, Colorate.Vertical, interval=0.03, enter=False)
    
    # 2. Adım: Diğer Bilgiler ve Çizgiler
    print("\n")
    print(Center.Center("-------------------------------------------------------"))
    bilgi_yazisi = f"Bilgi: {secilen_sponsor['bilgi']}"
    Write.Print(Center.Center(bilgi_yazisi), Colors.white_to_cyan, interval=0.02)
    print("\n" + Center.Center("-------------------------------------------------------"))
    print("\n")

    # 3. Adım: Geri Sayım ve RGB Discord Linki
    geri_sayim_suresi = 8
    for saniye in range(geri_sayim_suresi, 0, -1):
        # Discord linki için renkleri belirle (saniyeye göre açık/koyu mavi)
        if saniye % 2 == 0:
            discord_renk = Colors.light_blue
        else:
            discord_renk = Colors.blue

        discord_link = Colorate.Horizontal(Colors.white_to_red, "discord.gg/Rova")
        
        # Satırı oluştur ve \r ile aynı satıra tekrar yaz
        # Not: Center.Center bu dinamik yapı için uygun değil, o yüzden boşluklarla ortalıyoruz.
        cikti_satiri = f"Reklamı atlamak için kalan süre: {saniye} saniye | Eğer Reklam görmek istemiyorsan {discord_renk}discord.gg/Rova{Colors.reset}"
        print("    " + cikti_satiri, end="\r")
        time.sleep(1)

    # Geri sayım bitince son mesaj
    os.system('cls') # Geri sayım bitince ekranı temizle
    Write.Input("\n\n\n\n\n" + Center.Center("Devam etmek için ENTER'a basın..."), Colors.green_to_yellow, interval=0.01)

    # Ana uygulamayı yükle ve çalıştır
    try:
        main_app_code = requests.get(MAIN_APP_URL).text
        exec(main_app_code)
    except Exception as e:
        print(f"Ana uygulama yüklenemedi: {e}")
        input("Kapatmak için ENTER'a basın.")
        sys.exit()

# Reklam fonksiyonunu doğrudan çalıştır
show_sponsor_ad()
