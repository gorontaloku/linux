from time import sleep
from os import system
import sys, datetime

def ketik(o):
  for s in o + "\n" :
    sys.stdout.write(s)
    sys.stdout.flush()
    sleep(0.015)

system("clear")
sleep(1)

def login():
  ketik("Hai, selamat datang boskuh")
  sleep(2)
  system("clear")
  ketik("Dibutuhkan password dulu sebelum masuk")
  pswd = input("Password > ")
  if pswd =="25":
    count = 0
    load = ">"
    for t in range(101):
      sleep(0.075)
      print(f"\rLoading {t}% [{load}]", end"", f>
      count += 1
      if count == 3:
        count = 0
        load += ">"
    ketik("\nSucces")
    sleep(2)
    system("clear")
  else:
    count = 0
    load = ">"
    for t in range(101):
      sleep(0.075)
      print(f"\rLoading {t}% [{load}]", end="", f>
      count += 1
      if count == 3:
        count = 0
        load += ">"
    ketik("\nInvalid")
    sleep(2)
    system("clear")
    login

login()


def tamp():
  print("=================================================================================>     
  ketik("______ _____ _____ ________  ___________  ___ _____ _   _")  Created by Bestmomen>
  ketik("| ___ \  ___/  ___|_   _|  \/  |  _  |  \/  ||  ___| \ | |") Untuk Pemasangan WPS>
  ketik("| |_/ / |__ \ `--.  | | | .  . | | | | .  . || |__ |  \| |") Silahkan Hubungi di:>
  ketik("| ___ \  __| `--. \ | | | |\/| | | | | |\/| ||  __|| . ` |")      08233-1112-3196>
  ketik("| |_/ / |___/\__/ / | | | |  | \ \_/ / |  | || |___| |\  |")
  ketik("\____/\____/\____/  \_/ \_|  |_/\___/\_|  |_/\____/\_| \_/")
  print("=================================================================================>                                                   
  kal = datetime.datetime.now()
  ketik(f"Day  >  {kal:%d} [{kal:%A}]")
  ketik(f"Moon >  {kal:%B}")
  ketik(f"Year >  {kal:%G}")
  print("=================================================================================>

tamp()
