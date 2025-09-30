# Gerekli kütüphaneler (Bu script kendi kendine çalışacağı için importlar burada da olmalı)
import os
import sys
import webbrowser
import random
import time
import requests
from pystyle import Write, Colors, Anime, Center, Colorate

# Yönlendirilecek ana uygulamanın (main2) linki
MAIN_APP_URL = "https://raw.githubusercontent.com/Rafail2023/RovaClient/refs/heads/main/main2"

# -----------------------------------------------------------------------------------
# --- SPONSOR BİLGİLERİ ---
# Buradaki listeyi kendine göre düzenleyebilirsin.
SPONSOR_LISTESI = [
    {
        "isim": "Sponsor 1 Ismi",
        "bilgi": "Bu sponsor, en kaliteli oyun sunucularını sağlar.",
        "url": "https://www.google.com" # Sponsorun web sitesi veya Discord linki
    },
    {
        "isim": "Sponsor 2 Ismi",
        "bilgi": "Oyun içi tasarımlar ve grafikler için en iyi adres.",
        "url": "https://www.youtube.com"
    },
    {
        "isim": "Sponsor 3 Ismi",
        "bilgi": "Turnuvalar ve etkinlikler düzenleyen bir topluluk.",
        "url": "https://discord.com"
    }
]
# -----------------------------------------------------------------------------------

def show_sponsor_ad():
    """Rastgele bir sponsor seçer, reklamı gösterir ve ana uygulamaya geçer."""
    os.system('cls')
    
    # Listeden rastgele bir sponsor seç
    secilen_sponsor = random.choice(SPONSOR_LISTESI)
    
    # Sponsorun linkini tarayıcıda aç
    webbrowser.open(secilen_sponsor["url"])
    
    # Sponsorun ismini yeşil-sarı animasyonla yazdır
    Anime.Fade(Center.Center(secilen_sponsor["isim"]), Colors.green_to_yellow, Colorate.Vertical, interval=0.03, enter=False)
    
    # Diğer bilgileri ekrana yazdır
    print("\n")
    print(Center.Center("------------------------------"))
    print("\n")
    Write.Print(Center.Center(secilen_sponsor["bilgi"]), Colors.white_to_cyan, interval=0.02)
    print("\n\n")
    Write.Print(Center.Center("Reklamı görmemek için ROVA+ satın alabilir ve başka özelliklere de erişebilirsiniz."), Colors.yellow_to_red, interval=0.01)
    print("\n")
    
    # 8 saniye bekle
    time.sleep(8)
    
    # ENTER'a basılmasını bekle
    Write.Input("Devam etmek için ENTER'a basın...", Colors.white_to_red, interval=0.01)
    
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
