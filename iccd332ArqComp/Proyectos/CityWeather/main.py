import requests
import os
import csv
from datetime import datetime


QUITO_LAT = -0.2299
QUITO_LONGITUDE = -78.5249
API_KEY = "123456789123456789"
FILE_NAME = "clima-quito-hoy.csv"


def get_weather(lat, lon, api):
    pass


def write2csv(json_response, csv_filename):
    pass


def process(json):
    normalized_dict = {}
    return normalized_dict


def main():
    print("===== Bienvenido a Quito-Clima =====")
    quito_weather = get_weather(lat=QUITO_LAT, lon=QUITO_LONGITUDE, api=API_KEY)
    if quito_weather['cod']!=404:
        process(quito_weather)
        write2csv()  #
        
    else:
        print("Ciudad no disponible o API KEY no válida")


if __name__ == '__main__':
    main()
