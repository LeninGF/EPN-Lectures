import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def hello(name):
    print(f"hello {name}")

hello("lenin")

def sumar(a,b):
    return a+b

print(sumar(5,3))

x = np.linspace(-5,5,1000)
y = x**2

plt.scatter(x,y)
plt.show()
