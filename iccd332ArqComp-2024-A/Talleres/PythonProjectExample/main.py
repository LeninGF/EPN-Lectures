import argparse
from utils.geometry import perimetro_circulo, perimetro_cuadrilatero
from utils.geometry import area_cuadrilatero
from utils.geometry import print_resultado

def main(figura):
    print("=====Programa Geometría=====")
    print("=Autor: Lenin G. Falconi=")

    perimetro = 0
    area = 0
        
    if figura=="cuadrado":
        lado = input("Ingrese el valor del lado: ")
        lado = float(lado)
        perimetro = perimetro_cuadrilatero(lado1=lado,
                                           lado2=lado,
                                           lado3=lado,
                                           lado4=lado)
        area = area_cuadrilatero(lado1=lado, lado2=lado)
        
    elif figura=="circulo":
        pass
    else:
        print("Ingrese una figura geometrica escribiendo  python main.py --fig <nombre de la figura>")

    print_resultado(nombre_figura=figura,
                    perimetro=perimetro,
                    area=area)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Figuras Geometricas")
    parser.add_argument("--fig", default="cuadrado", help="Se declara la figura geométrica sobre la que se realiza operaciones e.g.cuadrado, circulo, rectangulo")
    args = parser.parse_args()
    main(figura=args.fig)
