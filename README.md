#  Advanced Mathematical Engine

[![Live Demo](https://img.shields.io/badge/Live_Demo-Click_Here-success?style=for-the-badge&logo=render)](https://mathenginproject.onrender.com)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](#)
[![Octave](https://img.shields.io/badge/GNU_Octave-078bc3.svg?style=for-the-badge&logo=gnu-octave&logoColor=white)](#)

**Developer:** Alaa  
**Domain:** Computational Mathematics & Cloud Deployment

##  Overview
The **Advanced Mathematical Engine** is a comprehensive, interactive command-line application designed to execute complex matrix operations, solve linear systems, and perform spectral/characteristic analysis. 

To eliminate local dependency issues and provide seamless access, the engine has been fully containerized using **Docker** and is served as a real-time interactive web application utilizing **GoTTY**.

##  Live Web Access
You do not need to install MATLAB, GNU Octave, or any specific dependencies to test the engine. It is deployed in the cloud and accessible directly via your browser:

 **[Launch the Advanced Mathematical Engine](https://mathenginproject.onrender.com)**

*(Note: The cloud instance may take ~50 seconds to wake up from sleep mode upon initial load).*

##  Core Features
1. **Matrix Operations & Analysis**
   - Standard Arithmetic (Addition, Subtraction, Multiplication)
   - Matrix Inversion ($A^{-1}$) & Rank computation
   - Step-by-step **Gaussian Elimination**
   - **Full Characteristic Analysis**: Computes the characteristic matrix $(A - \lambda I)$, characteristic equation, and eigenvalues.
2. **Linear Systems Solver**
   - Solves systems in the form of $AX = B$ using direct inversion methods.
3. **Theory of Equations**
   - Symbolic equation solving (e.g., finding roots for expressions like $x^2 - 5x + 6 = 0$).
4. **Session Reporting**
   - Generates a cleanly formatted summary report of all mathematical steps executed during the session, which can be easily copied from the web terminal.

##  Technology Stack
* **Core Logic:** GNU Octave (MATLAB compatible)
* **Symbolic Math:** Python3 (`sympy`), `octave-symbolic`
* **Containerization:** Docker (Ubuntu 22.04 base image)
* **Web Terminal Interface:** GoTTY

##  Local Execution (Docker)
If you prefer to run the engine locally on your machine, ensure Docker is installed and execute the following commands:

```bash
# 1. Clone the repository

git clone [https://github.com/AlaaElgazwy/math-engine-web.git](https://github.com/AlaaElgazwy/math-engine-web.git)
cd math-engine-web

# 2. Build the Docker image
docker build -t math-engine-octave .

# 3. Run the container and map the web port
docker run -p 8080:8080 math-engine-octave

Then, open http://localhost:8080 in your web browser.
