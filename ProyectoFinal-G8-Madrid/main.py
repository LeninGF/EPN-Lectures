import csv
import os
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

import requests


MADRID_LAT = 40.4168
MADRID_LONGITUDE = -3.7038
API_KEY = os.getenv("OPENWEATHER_API_KEY")
FILE_NAME = "clima-madrid-hoy.csv"

API_URL = "https://api.openweathermap.org/data/2.5/weather"


def get_weather(lat: float, lon: float, api_key: str) -> dict[str, Any]:
    """
    Consulta el clima actual de Madrid en OpenWeatherMap.

    Fuentes:
    https://openweathermap.org/current
    https://requests.readthedocs.io/en/latest/user/quickstart/
    """
    if not api_key:
        raise ValueError(
            "La variable de entorno OPENWEATHER_API_KEY no está configurada"
        )

    params = {
        "lat": lat,
        "lon": lon,
        "appid": api_key,
        "units": "metric",
        "lang": "es",
    }

    response = requests.get(API_URL, params=params, timeout=15)
    response.raise_for_status()

    return response.json()


def flatten_json(
    value: Any,
    parent_key: str = "",
    separator: str = "_",
) -> dict[str, Any]:
    """
    Convierte diccionarios y listas anidadas en un diccionario plano.
    """
    normalized: dict[str, Any] = {}

    if isinstance(value, dict):
        for key, item in value.items():
            new_key = f"{parent_key}{separator}{key}" if parent_key else str(key)
            normalized.update(flatten_json(item, new_key, separator))

    elif isinstance(value, list):
        for index, item in enumerate(value):
            new_key = (
                f"{parent_key}{separator}{index}"
                if parent_key
                else str(index)
            )
            normalized.update(flatten_json(item, new_key, separator))

    else:
        normalized[parent_key] = value

    return normalized


def process(json_response: dict[str, Any]) -> dict[str, Any]:
    """
    Prepara la respuesta para escribirla en el CSV.
    """
    normalized = flatten_json(json_response)

    timestamp = json_response.get("dt")

    if timestamp is not None:
        timezone_offset = json_response.get("timezone", 0)

        normalized["dt_local"] = datetime.fromtimestamp(
            timestamp + timezone_offset,
            tz=timezone.utc,
        ).strftime("%Y-%m-%d %H:%M:%S")

    # Estas columnas deben existir aunque no haya lluvia o nieve.
    normalized.setdefault("rain_1h", 0)
    normalized.setdefault("rain_3h", 0)
    normalized.setdefault("snow_1h", 0)
    normalized.setdefault("snow_3h", 0)

    return normalized


def write2csv(data: dict[str, Any], csv_filename: str) -> None:
    """
    Agrega una fila al CSV.

    Si una consulta futura trae columnas nuevas, por ejemplo rain_1h,
    actualiza el encabezado sin perder los registros anteriores.
    """
    csv_path = Path(csv_filename)

    if not csv_path.exists() or csv_path.stat().st_size == 0:
        with csv_path.open("w", newline="", encoding="utf-8") as csv_file:
            writer = csv.DictWriter(csv_file, fieldnames=list(data.keys()))
            writer.writeheader()
            writer.writerow(data)
        return

    with csv_path.open("r", newline="", encoding="utf-8") as csv_file:
        reader = csv.DictReader(csv_file)
        old_rows = list(reader)
        old_fields = reader.fieldnames or []

    new_fields = old_fields + [
        field for field in data.keys() if field not in old_fields
    ]

    if new_fields != old_fields:
        with csv_path.open("w", newline="", encoding="utf-8") as csv_file:
            writer = csv.DictWriter(csv_file, fieldnames=new_fields)
            writer.writeheader()
            writer.writerows(old_rows)
            writer.writerow(data)
    else:
        with csv_path.open("a", newline="", encoding="utf-8") as csv_file:
            writer = csv.DictWriter(csv_file, fieldnames=old_fields)
            writer.writerow(data)


def main() -> None:
    print("===== Bienvenido a Madrid-Clima =====")

    try:
        madrid_weather = get_weather(
            lat=MADRID_LAT,
            lon=MADRID_LONGITUDE,
            api_key=API_KEY,
        )

        processed_weather = process(madrid_weather)
        write2csv(processed_weather, FILE_NAME)

        print(
            f"Registro guardado correctamente en {FILE_NAME}, "
            f"fecha: {processed_weather.get('dt_local')}"
        )

    except requests.exceptions.HTTPError as error:
        print(f"Error HTTP al consultar OpenWeatherMap: {error}")

    except requests.exceptions.RequestException as error:
        print(f"Error de conexión con OpenWeatherMap: {error}")

    except (ValueError, OSError, csv.Error) as error:
        print(f"Error al procesar o guardar los datos: {error}")


if __name__ == "__main__":
    main()
