# 📡Electromagnetic-Security-Patch-Microstrip-Antenna-Project

This repository contains the codes and simulation files used in the analysis and design of microstrip patch antennas for electromagnetic security applications. The project was developed as part of an academic coursework on electromagnetic compatibility (EMC) and antenna array design.

--- 
## 📘 Project Overview

The goal of the project was to investigate the electromagnetic behavior of dipole antennas and microstrip patch antenna array in different configurations. The study includes simulation, design optimization, and shielding techniques to ensure compliance with international emission standards. 

---

## 📁 Repository Contents

├── 📁CST_Dipole_Project       #CST files
│ ├──📁 File CST/
│ │   ├── double_dipole.cst    #two dipoles model
│ │   ├── shield_aperture.cst  #two dipoles surrounded by a shield with an aperture
│ │   ├── shield_box.cst       #two dipoles surrounded by a shield
│ │   └── single_dipole.cst    #single dipole model
│ │
│ └──📁Script Matlab/                           #Matlab scripts for cst result analysis
│    ├── emc_box.m                              #script for plotting radiated field vs limits with full shield
│    ├── emc_box_with_aperture_only_5GHz.m      #script for plotting radiated field vs limits with shield with aperture at 5GHz
│    ├── emc_box_with_aperture_sweep.m          #script for plotting radiated field vs limits with shield with aperture (freq. sweep)
│    ├── emc_cm_limit.m                         #plot common mode currents limits
│    ├── emc_dm_limit.m                         #plot differential mode current limits
│    ├── length_optimization.m                  #dipole length optimization at 5GHz
│    └── limit.m                                #emission limits 
│
├──📁 Matlab_Antenna_Array_Project             #Matlab antenna array simmulations
│    ├── array_antennas_N_var_Comparison.m     #patch microstrip antenna array comparison
│    ├── array_antennas_N_var_Binomial.m       #patch microstrip antenna Binomial array with variable number of antennas  
│    ├── array_antennas_N_var_Chebyshev.m      #patch microstrip antenna Chebyshev array with variable number of antennas
│    ├── array_antennas_N_var_ULA.m            #patch microstrip antenna ULA array with variable number of antennas
│    ├── array_antennas_Phase_Shift_ULA.m      #patch microstrip antenna ULA array with variable phase
│    └── microstrip.m                          #signle patch microstrip design
│
├── Electromagnetic Security Report.pdf        #report
├── LICENSE
└── README.md

---

## 🛠 Tools and Software

- Matlab (Antenna Toolbox & Array Deigner)
- CST

---

## 📊 Key Results

- Optimized microstrip patch antenna with resonant frequency at 5 GHz

- Design and comparison of ULA, Binomial, and Chebyshev antenna arrays

- Shielding effectiveness assessment through PEC enclosure with variable apertures

- Compliance validation against CISPR Class A and B emission limits

---

## 📚 References

For a full explanation of the methodology, results, and theoretical background, see the Electromagnetic Security Report.pdf included in this repository.

---

## 👤 Authors

- Antonio Nardone

- Raffaele Di Benedetto

- Vittoria Damato

- Carolina Sbiroli