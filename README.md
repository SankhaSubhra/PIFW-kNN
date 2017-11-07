# A MATLAB implementation of PIFW-kNN.
## Written by: Nimagna Biswas and Saurajit Chakraborty.

### Reference: Nimagna Biswas, Saurajit Chakraborty, Sankha Subhra Mullick, and Swagatam Das, A Parameter Independent Fuzzy Weighted k-Nearest Neighbor Classifier, Pattern Recognition Letters, November, 2017.
### Contact: nimagna0072@gmail.com (Nimagna Biswas), rik.stxaviers@gmail.com (Saurajit Chakraborty). 

### DESCRIPTION:
* The package contains 9 functions, 1 script and 1 sample dataset from UCI repository [1].
* pifwknn.m: The main script.
* shade.m: Implementation of SHADE [2].
* fitness.m. Calculates the leave-one-ot error for a value of k and set of class specific feature weights.
* wtdistance.m: Claculates weighted distance as described in the corresponding article.
* membership_assignment.m: Calculates the fuzzy membership matrix.
* fuzzy_knn.m: Supporting function.
* extract.m: Supporting function.
* wt_Mean.m: Supporting function.
* wt_Lehmer_Mean.m: Supporting function.
* cauchy_rand.m: Supporting function.
* Balance_Scale.mat: Example dataset.

=============================================================================================

DEPENDENCIES:
* MATLAB 2014a and above.
* The source code and data files must be in the same folder. 
* Load the dataset (.mat format) in the workspace and run the script named 'pifwknn.m'.
* Please read 'pifwknn.m' (or Balance_Scale.mat) for further arrangement of the dataset.

=============================================================================================

REFERENCE:
* [1] Lichman, M., 2013. UCI machine learning repository. URL: http://archive.ics.uci.edu/ml.
* [2] Tanabe, R., Fukunaga, A., 2013. Success-history based parameter adaptation
for differential evolution, in: IEEE CEC, pp. 71–78.
