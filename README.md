# FHN-stuff-of-questionable-utility
Some usefull stuff on analizing bearings with FHN
## MLX files

> [!IMPORTANT]
> Probably a good idea to `addpath` like everything from this repo for all `.mlx` to work

- **[FHN_Data.mlx](./FHN_Data.mlx)**

Processes whole dataset in rly bulky way. Used to obtain tables: [`Paderborn_vs_FHN_A10_B1_W15-01-3.mat`](./mats/Paderborn_vs_FHN_A10_B1_W15-01-3.mat), [Paderborn_vs_FHN_A10_B1_W15-01-3_RMS.mat](./mats/Paderborn_vs_FHN_A10_B1_W15-01-3_RMS.mat).

- **[FHNvsPaderbornNew.mlx](./FHNvsPaderbornNew.mlx)**

Does something I guess)) Loops some dataset entires to obtain a single histogram without distributions. Rly bulky & unoptimized.

- **[distribplot.mlx](./distribplot.mlx)**

Used to visualize distributions depending on time domain scale value `θ` from tables: [`Paderborn_vs_FHN_A10_B1_W15-01-3.mat`](./mats/Paderborn_vs_FHN_A10_B1_W15-01-3.mat), [Paderborn_vs_FHN_A10_B1_W15-01-3_RMS.mat](./mats/Paderborn_vs_FHN_A10_B1_W15-01-3_RMS.mat).

- **[FHN_Response_distribution_analyzer.mlx](./FHN_Response_distribution_analyzer.mlx)**

Optimized thingy. Loops certain dataset entries and produces distribution histogram, also analyzes area of distribution overlap.

## [`systems`](./systems) folder
FHN with and without external signal.

[FHN.m](./systems/FHN.m) - FHN system without external signal, unscaled in time domain

[FHN_EXT.m](./systems/FHN_EXT.m) - FHN system with external signal, scaled in time domain

## [mats](./mats) folder
Some datasets with research data
### Tables
These tables are used in [distribplot.mlx](./distribplot.mlx)

[Paderborn_vs_FHN_A10_B1_W15-01-3.mat](./mats/Paderborn_vs_FHN_A10_B1_W15-01-3.mat) - Amlitude normalization

[Paderborn_vs_FHN_A10_B1_W15-01-3_RMS.mat](./mats/Paderborn_vs_FHN_A10_B1_W15-01-3_RMS.mat) - RMS normalization

| Column Name | Comment |
| --- | --- |
| `DataSetEntry` | Full name of dataset file (without memo)|
| `N` | Rotational Speed |
| `M` | Load Torque |
| `F` | Radial Force |
| `Id` | Identifier in current dataset group |
| `W` | θ - for neuron scaling in time domain |
| `MPD_2e-1` | Mean Peak Distance for peaks greater than 0.2 | 
| `MPD_4e-1` | Mean Peak Distance for peaks greater than 0.4 |
| `MPD_6e-1` | Mean Peak Distance for peaks greater than 0.6 |
| `MPD_8e-1` | Mean Peak Distance for peaks greater than 0.8 |
| `TrueType` | Type of bearing |

> [!NOTE]
> They can be used directly in `Classification Learner`

> [!TIP]
> For referncing `MPD` columns in matlab scripts use this syntax `T.("MPD column name")`

## [utils](./utils) folder
Utility fuctions & classes used in almost every script

### [ButcherTableau.m](./utils/ButcherTableau.m)
The `ButcherTableau` class provides a collection of Butcher tableaus for various numerical methods used in solving ordinary differential equations (ODEs). Each tableau is represented as a struct containing the coefficients `a`, `b`, and `c`.

#### Usage

To get the coefficients of a specific method, use the `get` method:

```matlab
[a, b, c] = ButcherTableau.get('RK4');
```
To list all available methods, use the listMethods method:

```matlab
methods = ButcherTableau.listMethods();
```

### [etaAnalyzer.m](./utils/etaAnalyzer.m)
The `etaAnalyzer` class provides an estimated time of arrival (ETA) analyzer for `for` loops, helping to track and display progress and ETA during iterative computations.

#### Methods

- **Constructor**: Initializes the `etaAnalyzer` object.
```matlab
obj = etaAnalyzer(maxCtr, windowSize, nextUpdate)
```
`maxCtr`: Maximum number of iterations.

`windowSize`: Size of the window for averaging iteration times.

`nextUpdate` (optional): Progress update interval. Default is 0 (update every iteration).
- **startIter**: Marks start of iteration
```matlab
obj.startIter();
```
- **endIter**: Marks end of iteration
```matlab
obj.endIter();
```
#### Usage
To use the `etaAnalyzer` in a loop, follow these steps:

1. Initialize the Analyzer: Create an etaAnalyzer object with the desired parameters.
2. Start and End Iterations: Wrap the loop iterations with startIter and endIter.

```matlab
eta = etaAnalyzer(maxCtr, windowSize, nextUpdate);
for i = 1:maxCtr
    eta = eta.startIter();
    % Your loop code here
    eta = eta.endIter();
end
```

### [trim_signal.m](./utils/trim_signal.m)
The `trim_signal` function trims a given signal to a specified target duration. It ensures that the signal is not shorter than the desired duration and adjusts the length accordingly.

#### Usage

```matlab
[t_trimmed, sig_trimmed] = trim_signal(t, sig, fs, targetTmax)
