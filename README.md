# GAMS--Model--for--Power--System--Optimization-
This repository contains a collection of GAMS models and supporting
files for power system optimisation. It is also used as an example
for organising and sharing research code through GitHub.

## Overview

The collection includes:

- Economic dispatch and cost–emission studies
- Dynamic economic dispatch
- AC and DC optimal power flow
- Renewable energy and battery energy storage modelling
- Phasor measurement unit (PMU) allocation
- Transmission expansion planning
- Basic optimisation examples

## Repository Structure

| Folder | Description |
|--------|-------------|
| Models | GAMS model files organised by topic |
| Results | Supplied economic-dispatch results in CSV format |
| Project File | Supporting data-export script |

The Models folder contains the following categories:

- Learning_Examples
- Economic_Dispatch
- Dynamic_Economic_Dispatch
- Optimal_Power_Flow/AC
- Optimal_Power_Flow/DC
- PMU_Allocation
- Transmission_Expansion

## Software Requirements

- GAMS
- A solver suitable for the selected model

The models include linear programming (LP), mixed-integer programming
(MIP), nonlinear programming (NLP), and quadratically constrained
programming (QCP) formulations.

Some scripts call GDXXRW for spreadsheet export and require an
appropriate Windows GAMS installation.

The GAMS version and solver versions used to produce the supplied
results have not yet been documented.

## Getting Started

1. Download the repository using **Code → Download ZIP**.
2. Extract the ZIP file on your computer.
3. Open GAMS Studio.
4. Select a `.gms` file from the relevant Models subfolder.
5. Review the model's input requirements and output paths.
6. Run the model using a suitable solver.
7. Check the compilation messages, solver status and model status
   before interpreting the results.

The files represent separate examples and model variants.
There is no single script that runs the entire collection.

## Data and Results

Most models define their input data directly within the GAMS code.

The supplied results file is located at:

`Results/Economic_Dispatch/results.csv`

Its column headings correspond to the output written by:

`Models/Economic_Dispatch/GAMS_Book_Ch03_ED_aalim_test_02.gms`

The CSV contains generator power output, load and objective-function
values for several cases. These results have not been independently
reproduced as part of preparing this repository.

Scripts may write outputs into their working directory rather than
automatically saving them in the Results folder. Several variants
use the same output filenames, so use separate working directories
when running different examples.

## Supporting Script

`Project File/Extracting_Data_to_CSV.gms`

This original project script contains embedded data and commands
for GDX and spreadsheet export. Despite its filename, its export
commands use GDXXRW; CSV output should not be assumed.

## Validation Status

The files have been organised for sharing, but the models have not
been executed or validated as part of this GitHub tutorial.

Original filenames and source code have been retained. Some filenames
may not fully describe the implementation. For example,
`AC_OPF_ESS.gms` declares a DC-OPF model and is grouped under DC.

## Licence

A repository-wide licence has not yet been assigned.
Applicable permissions for original and third-party code are being
confirmed. Public availability does not itself grant permission to
reuse, modify or redistribute these files.

The licence for GAMS software and its solvers is separate from any
licence applied to the model source code in this repository.
