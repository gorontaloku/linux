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
  ketik("\033[36;1mHai, selamat datang boskuh")
  sleep(2)
  system("clear")
  ketik("Dibutuhkan password dulu sebelum masuk")
  pswd = input("\033[37;1mPassword \033[31;1m> ")
  if pswd == "\033[1;32m12345":
    count = 0
    load = "\033[36;1m>"
    for t in range(101):
      #sleep(0)
      #print(f"\rLoading {t}% [{load}]", end="", flush=True)
      count += 1
      if count == 3:
        count = 0
        load += ">"
    ketik("\n\033[0;32mSUKSES BOSKU")
    sleep(2)
    system("clear")
  else:
    count = 0
    load = ">"
    for t in range(101):
      sleep(0.075)
      print(f"\rLoading {t}% [{load}]", end="", flush=True)
      count += 1
      if count == 1:
        count = 0
        load += ">"
    ketik("\nInvalid")
    sleep(2)
    system("python tampilan.py")
    login

login()


def tamp():
  print("\033[32;1m================================================================")
  ketik("\033[33;1m  ██╗    ██╗\033[32;1m██████╗ ███████╗     \033[36;1m Create by:")
  ketik("\033[33;1m  ██║    ██║\033[32;1m██╔══██╗██╔════╝      \033[33;1m Bestmomen")
  ketik("\033[33;1m  ██║ █╗ ██║\033[32;1m██████╔╝███████╗\033[36;1m Info Pemasangan")
  ketik("\033[33;1m  ██║███╗██║\033[32;1m██╔═══╝ ╚════██║    \033[36;1m Hubungi No:")
  ketik("\033[33;1m  ╚███╔███╔╝\033[32;1m██║     ███████║ \033[36;1m 0823-1112-3196")
  ketik("\033[33;1m   ╚══╝╚══╝ \033[32;1m╚═╝     ╚══════╝                          ")
  print("\033[32;1m================================================================")
  ketik("\033[31;1mdilarang keras \033[36;1mmenyebarkan/menjual kembali script ini ")

tamp()
