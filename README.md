# device-independence-tripartite-q-systems
Code written during summer research project at CQT, NUS on obtaining an entanglement witness to bipartite quantum sources. A major attempt in this project was to develop modifications of the NPA hierarchy that lead to good bounds on bipartite quantum sources. The code in this repo implements the original NPA heirarchy, for two or three parties. 

The NPA hierarchy paper can be found at https://iopscience.iop.org/article/10.1088/1367-2630/10/7/073013/meta .
The code uses Mosek (https://www.mosek.com/), and Yalmip (https://yalmip.github.io/), both of which can be used freely by students. 

The NPA constraints require us to compare all the POVM measurement operators that appear in the heirarchy. Therefore, each operator appearing in the hierarchy is labelled with multiple strings that define how it is constructed from the measurement Projector operators. Its status also determines whether it is a null operator, identity operator, or otherwise. This is crucial, since it allows us to compare and manipulate these products of POVMs after taking into account their commutation relations and orthogonality properties.

**Adjoint.m** :   Returns the Adjoint of the input operator.

**CheckO.m** : Checks the input matrix and reduces its length. Checks for presence of orthogonal projectors in the input operator, and replaces it with the null operator is such cases occur.

**Compare.m** : Compares two operators. Returns 1 if operators are equal. 

**







