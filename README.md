# 📡Electromagnetic-Security-Patch-Microstrip-Antenna-Project

This repository contains the codes and simulation files used in the analysis and design of microstrip patch antennas for electromagnetic security applications. The project was developed as part of an academic coursework on electromagnetic compatibility (EMC) and antenna array design.

--- 
## 📘 Project Overview

The goal of the project was to investigate the electromagnetic behavior of dipole antennas and microstrip patch antenna array in different configurations. The study includes simulation, design optimization, and shielding techniques to ensure compliance with international emission standards. 

---

## 📁 Repository Contents


```

├── 📁 CST_Dipole_Project       # CST files
│ ├──📁 File CST/
│ │   ├── double_dipole.cst    # Two Dipoles Model
│ │   ├── shield_aperture.cst  # Two Dipoles Surrounded by a Shield with an Aperture
│ │   ├── shield_box.cst       # Two Dipoles Surrounded by a Shield
│ │   └── single_dipole.cst    # Single Dipole Model
│ │
│ └──📁 Script Matlab/                           # Matlab scripts for CST result analysis
│    ├── emc_box.m                              # Script for Plotting Radiated Field vs Limits with Full Shield
│    ├── emc_box_with_aperture_only_5GHz.m      # Script for Plotting Radiated Field vs Limits with Shield with Aperture at 5GHz
│    ├── emc_box_with_aperture_sweep.m          # Script for Plotting Radiated Field vs Limits with Shield with Aperture (freq. sweep)
│    ├── emc_cm_limit.m                         # Plot Common Mode Currents Limits
│    ├── emc_dm_limit.m                         # Plot Differential Mode Current Limits
│    ├── length_optimization.m                  # Dipole Length Optimization at 5GHz
│    └── limit.m                                # Emission Limits 
│
├──📁 Matlab_Antenna_Array_Project             # Matlab Antenna Array Simmulations
│    ├── array_antennas_N_var_Comparison.m     # Patch Microstrip Antenna Array Comparison
│    ├── array_antennas_N_var_Binomial.m       # Patch Microstrip Antenna Binomial Array with Variable Number of Antennas 
│    ├── array_antennas_N_var_Chebyshev.m      # Patch Microstrip Antenna Chebyshev Array with Variable Number of Antennas
│    ├── array_antennas_N_var_ULA.m            # Patch Microstrip Antenna ULA Array with Variable Number of Antennas
│    ├── array_antennas_Phase_Shift_ULA.m      # Patch Microstrip Antenna ULA Array with Variable Phase
│    └── microstrip.m                          # Single Patch Microstrip Design
│
├── Electromagnetic Security Report.pdf        # report
├── LICENSE                                    # MIT License
└── README.md                                  # Project Documentation

```

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

- Raffaele Di Benedetto

- Antonio Nardone

- Vittoria Damato

- Carolina Sbiroli
