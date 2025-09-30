import os
import sys
import webbrowser
import time
import requests
from pystyle import Colors
import msvcrt
import math

# ---------------------------- AYARLAR BÖLÜMÜ ----------------------------

# --- GENEL AYARLAR ---
REKLAM_ACIK = True
LINK_ACIK = False
ENTER_GEREKLI = True

# --- RENK AYARLARI ---
CIZGI_RENGI = Colors.white
BILGI_YAZISI_RENGI = Colors.cyan
ENTER_PROMPT_RENGI_1 = Colors.green
ENTER_PROMPT_RENGI_2 = Colors.red
RESET_RENGI = Colors.reset

# --- ANİMASYON AYARLARI ---
ANIMASYON_BASLANGIC_RENGI = "#FFFF00"  # Sarı
ANIMASYON_BITIS_RENGI = "#00FF00"      # Yeşil
ANIMASYON_HIZI = 0.5

# --- YERLEŞİM AYARLARI ---
DİKEY_BOSLUK = "\n" * 5
UST_CIZGI_BOSLUK = " " * 25
ASCII_ART_BOSLUK = " " * 25
BILGI_YAZISI_BOSLUK = " " * 15
ALT_CIZGI_BOSLUK = " " * 25
# DÜZELTME: Eksik olan değişken buraya eklendi.
GERI_SAYIM_BOSLUK = " " * 10
ENTER_PROMPT_BOSLUK = " " * 35

# --- METİN AYARLARI ---
REKLAM_BILGI_1 = "      BİLGİ: Discord sunucumuza gelerek bu kısma kendi reklamınızı yapabilirsiniz."
REKLAM_BILGI_2 = ""
REKLAM_ASCII_ART = """
        ██████╗ ███████╗██╗  ██╗██╗      █████╗ ███╗   ███╗
        ██╔══██╗██╔════╝██║ ██╔╝██║     ██╔══██╗████╗ ████║
        ██████╔╝█████╗  █████╔╝ ██║     ███████║██╔████╔██║
        ██╔══██╗██╔══╝  ██╔═██╗ ██║     ██╔══██║██║╚██╔╝██║
        ██║  ██║███████╗██║  ██╗███████╗██║  ██║██║ ╚═╝ ██║
        ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
"""
UST_CIZGI = "----------------------------------------------------------------------"
ALT_CIZGI = "----------------------------------------------------------------------"
REKLAM_URL = "https://discord.gg/rova"
MAIN_APP_URL = "https://raw.githubusercontent.com/Rafail2023/RovaClient/refs/heads/main/main2"

# ---------------------------- KOD BÖLÜMÜ (BURAYI DEĞİŞTİRME) ----------------------------

def hex_to_rgb(hex_code):
    hex_code = hex_code.lstrip('#')
    return tuple(int(hex_code[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_ansi(r, g, b):
    return f'\x1b[38;2;{r};{g};{b}m'

def run_main_app():
    try:
        os.system('cls')
        main_app_code = requests.get(MAIN_APP_URL).text
        exec(main_app_code)
    except Exception as e:
        print(f"Ana uygulama yüklenemedi: {e}")
        input("Kapatmak için ENTER'a basın.")
        sys.exit()

def draw_screen(ascii_content, alt_metin=""):
    """Ekranı statik ve dinamik içerikle çizer."""
    os.system('cls')
    print(DİKEY_BOSLUK)
    print(f"{CIZGI_RENGI}{UST_CIZGI_BOSLUK}{UST_CIZGI}{RESET_RENGI}\n")
    print(ascii_content)
    print("")
    if REKLAM_BILGI_1: print(f"{BILGI_YAZISI_RENGI}{BILGI_YAZISI_BOSLUK}{REKLAM_BILGI_1}{RESET_RENGI}")
    if REKLAM_BILGI_2: print(f"{BILGI_YAZISI_RENGI}{BILGI_YAZISI_BOSLUK}{REKLAM_BILGI_2}{RESET_RENGI}")
    print("")
    print(f"{CIZGI_RENGI}{ALT_CIZGI_BOSLUK}{ALT_CIZGI}{RESET_RENGI}\n\n")
    if alt_metin: print(alt_metin)

def show_ad():
    if LINK_ACIK: webbrowser.open(REKLAM_URL)
    
    start_r, start_g, start_b = hex_to_rgb(ANIMASYON_BASLANGIC_RENGI)
    end_r, end_g, end_b = hex_to_rgb(ANIMASYON_BITIS_RENGI)
    padded_art_lines = [f"{ASCII_ART_BOSLUK}{line}" for line in REKLAM_ASCII_ART.strip('\n').split('\n')]
    animasyon_sayaci = 0

    # Geri sayım döngüsü
    for saniye in range(10, 0, -1):
        # Her saniye animasyon için renk hesapla
        t = (math.sin(animasyon_sayaci * ANIMASYON_HIZI) + 1) / 2
        r = int(start_r + (end_r - start_r) * t)
        g = int(start_g + (end_g - start_g) * t)
        b = int(start_b + (end_b - start_b) * t)
        current_color_ansi = rgb_to_ansi(r, g, b)
        
        colored_art = "\n".join(f"{current_color_ansi}{line}{RESET_RENGI}" for line in padded_art_lines)
        cikti_satiri = f"Reklamı geçmenize {saniye}s kaldı. Reklamsız bir deneyim için premium alabilirsiniz: discord.gg/rova"
        draw_screen(colored_art, f"{GERI_SAYIM_BOSLUK}{cikti_satiri}")
        
        time.sleep(1)
        animasyon_sayaci += 1

    if ENTER_GEREKLI:
        prompt_part1 = f"       {ENTER_PROMPT_RENGI_1}Enter'e{RESET_RENGI}"
        prompt_part2 = f"{ENTER_PROMPT_RENGI_2} Basarak Reklamı Geçin{RESET_RENGI}"
        prompt_metni = f"{ENTER_PROMPT_BOSLUK}{prompt_part1}{prompt_part2}"
        
        # Animasyonun devam ettiği Enter bekleme döngüsü
        while True:
            if msvcrt.kbhit():
                if msvcrt.getch() == b'\r':
                    break
            
            t = (math.sin(animasyon_sayaci * ANIMASYON_HIZI) + 1) / 2
            r = int(start_r + (end_r - start_r) * t)
            g = int(start_g + (end_g - start_g) * t)
            b = int(start_b + (end_b - start_b) * t)
            current_color_ansi = rgb_to_ansi(r, g, b)
            
            colored_art = "\n".join(f"{current_color_ansi}{line}{RESET_RENGI}" for line in padded_art_lines)
            draw_screen(colored_art, prompt_metni)
            
            animasyon_sayaci += 1
            time.sleep(0.05)
        run_main_app()
    else:
        run_main_app()

# --- ANA ÇALIŞTIRMA MANTIĞI ---
if REKLAM_ACIK:
    show_ad()
else:
    os.system('cls')
    print("Reklamlar kapalı, ana menü yükleniyor...")
    time.sleep(1)
    run_main_app()
