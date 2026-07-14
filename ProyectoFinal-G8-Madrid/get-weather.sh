#!/usr/bin/bash

source /home/edgar-epn/miniforge3/etc/profile.d/conda.sh
conda activate iccd332

source /home/edgar-epn/.config/openweather.env

cd /home/edgar-epn/Arquitectura2026A/ProyectoFinal-G8-Madrid

python main.py
