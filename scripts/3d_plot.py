import numpy as np
import matplotlib.pyplot as plt
# from mpl_toolkits.mplot3d import Axes3D

# Create a range of x and y values
x = np.linspace(0, 3, 100)
y = np.linspace(0, 5, 100)

# Create a meshgrid from x and y values
X, Y = np.meshgrid(x, y)

# Calculate the Z values using the function sin(x) * cos(y)
fn = lambda x, y: (np.sin(x/3*np.pi + np.pi/2) * np.cos(y/5*np.pi))*.5*.75 + 0.5
Z = fn(X,Y)

# Create a 3D figure and axes
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Plot the surface
ax.plot_surface(X, Y, Z, cmap='viridis')

# Set labels for the axes
ax.set_xlabel('X-axis')
ax.set_ylabel('Y-axis')
ax.set_zlabel('Z-axis (sin(x)*cos(y))')

# Set the title of the plot
ax.set_title('3D Plot of sin(x) * cos(y)')

print(fn(0,0)) # 1 sin(pi/2)
print(fn(0,5))
print(fn(3,0))
print(fn(3,5)) # 1 sin(pi/2)

# Display the plot
plt.show()
