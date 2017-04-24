from __future__ import division
import numpy as np
import matplotlib.pyplot as plt

nx = 51
ny = 1
Lx = 1e4
Ly = 0
X = np.linspace(0, Lx, nx)
Y = np.linspace(0, Ly, ny)
dx = X[1] - X[0]
dy = Y[1] - Y[0]

# tracer distribution
A= np.pi*5/3/1000.
r = 2500.
theta0 = np.pi/2.
x0 = 0.5*nx*dx+r*np.cos(theta0)
y0 = 0.5*ny*dy+ r*np.sin(theta0)
phi = np.exp(- 0.5*(((X-x0)/500)**2 + ((Y-y0)/500)**2))

# streamfunction
r = ((X-0.5*dx)-(0.5*nx)*dx)**2+((Y-0.5*dy)-0.5*Ly)**2
r1 = 3500.
r2 = 4500.
psi = np.where(r<=r1**2, A*r, \
    np.where((r>r1**2) & (r<=r2**2), A*r1*np.sqrt(r), A*r1*r2))


Also, I tried    
# tracer distribution
    A= np.pi*5/3/1000.
    r = 2500.
    theta0 = np.pi/2.
    x0 = 0.5*nx*dx+r*np.cos(theta0)
    y0 = 0.5*ny*dy+ r*np.sin(theta0)
    phi = np.exp(- 0.5*(((X-x0)/500)**2 + ((Y-y0)/500)**2))

# streamfunction
    r = np.sqrt(((X-0.5*dx)-(0.5*nx)*dx)**2+((Y-0.5*dy)-0.5*Ly)**2)
    r1 = 3500.
    r2 = 4500.
    psi = np.where(r<=r1, A*r**2, \
        np.where((r>r1) & (r<=r2), A*r1*r, A*r1*r2))

