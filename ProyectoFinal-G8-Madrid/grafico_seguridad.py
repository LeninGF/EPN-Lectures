import os
import matplotlib.pyplot as plt

meses = ["Enero", "Febrero"]
robos_2025 = [1481, 1333]
robos_2026 = [1226, 1072]

x = range(len(meses))
ancho = 0.35

plt.figure(figsize=(7,4.5))

plt.bar([i-ancho/2 for i in x],
        robos_2025,
        width=ancho,
        label="2025")

plt.bar([i+ancho/2 for i in x],
        robos_2026,
        width=ancho,
        label="2026")

plt.xticks(x, meses)
plt.ylabel("Número de robos")
plt.title("Robo de motocicletas en Ecuador", fontsize=14)

plt.legend()
plt.grid(axis="y", alpha=0.3)

os.makedirs("weather-site/content/images", exist_ok=True)

plt.tight_layout()

plt.savefig(
    "weather-site/content/images/robo_motos_2025_2026.png",
    dpi=180,
    bbox_inches="tight"
)

plt.show()
