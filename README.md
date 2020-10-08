# CA4 Model

A light-color resource competition model for *Synechococcus* phytoplankton in blue-green ocean environments. Model code is based on modified equations and theory published by [Stomp et al., 2008](https://www.journals.uchicago.edu/doi/abs/10.1086/591680)

Competition is between a generalist phytoplankton that undergoes Type IV Chromatic Acclimation (CA4) and can absorb either blue or green light (pigment type 3d), a blue-light specialist (3c), and a green-light specialist (3a).

Absorption by other phytoplankton is represented by the absorption spectrum of chlorophyll-a, which changes as a function of concentration from 0-25 mg m-3 as per [Bricaud et al. (1995)](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/95JC00463), and the absorption spectrum of E. huxleyi, a Coccolithophore with higher specific absorption than chlorophyll-a at 495 nm. The model assumes a homogeneous aqueous layer, synonymous with the mixed layer, whose depth can be modified. Default light source is the spectrum of daylight, but constant or oscillating LED light spectra are included. 

CA4 is only observed in marine *Synechococcus*. The biology involves changing the ratio of chromophores of phycoerythrin: phycourobilin, PUB (max absorption at 495 nm) to phycoerythrobilin, PEB (max absorption at 545 nm) in the phycobilisome light-harvesting antenna of the cell. PUB:PEB goes up in blue light, and down in green light.
