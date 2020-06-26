# NPA Hierarchy
Code written during summer research project at CQT, NUS on obtaining an entanglement witness to bipartite quantum sources. A major attempt in this project was to develop modifications of the NPA hierarchy that lead to good bounds on bipartite quantum sources. The code in this repo implements the original NPA heirarchy, for two or three parties. 

The NPA hierarchy paper can be found [here](https://iopscience.iop.org/article/10.1088/1367-2630/10/7/073013/meta) .
The code uses Mosek ([link](https://www.mosek.com/)), and Yalmip ([link](https://yalmip.github.io/)), both of which can be used freely by students. 

## Basic approach

The NPA constraints require us to compare all the measurement operators that appear in the heirarchy. Therefore, each operator appearing in the hierarchy is labelled with multiple strings that define how it is constructed from the individual measurement projector operators. Its status also determines whether it is a null operator, identity operator, or otherwise. This is crucial, since it allows us to compare and manipulate these products of POVMs after taking into account their commutation relations and orthogonality properties. 

Our approach is the following : 

Step 1 : Generate all unique sequences of operators of the required order, say order L. This requires use of ProductOp, Reduce. Call the list S.

Step 2 : Generate all unique sequences of operators of the order 2L. This allows us to have all operators that may appear in the Matrix M and some more. Call the list G.

Step 3 : Assign an index to each operator of order 2L. A natural way is to define the index to be the position at which a given operator appears in G.

Step 4 : Generate an sdpvar for length = length of G. Call it v. This holds all the unique elements that can appear in M. 

Step 5 : For i and j ranging from 1 to length(S), compute the (i,j) element of M. This requires use of adjoint. Find the index assigned to the element and write M(i,j)=indexof( the i,j th operator). Adding the M >=0 constraint completes all the NPA constraints.

Step 6 : Maximize the Bell expression which is a linear function of elements in v, subject to v creating a positive semidefinite matrix M. 

Additional constraints on the elements of M, translate to additional constraints between the elements of the sdpvar v defined earlier. We are set.


THe code works for 
1) CHSH for 2 party (Make C have one measurement and one outcome)
2) Mermin for 3 party ([2,2],[2,2],[2,2],2)- Order 2
3) Any bell expression for 2 or 3 parties. 


## Description of code 

**Adjoint.m** :   Returns the Adjoint of the input operator.

**CheckO.m** : Checks the input matrix and reduces its length. Checks for presence of orthogonal projectors in the input operator, and replaces it with the null operator is such cases occur.

**Compare.m** : Compares two operators. Returns 1 if operators are equal. 

**GenerateOps.m** : Generates the list of operators appearing in the NPA hierarchy. Takes as input 3 lists, A, B, C and one number L. L denotes the order to which the operators are to be generated (it is typically between 2 and 6). The lists specity the number of settings and outcomes for each party. That is, if A = \[4,4,2\] then A has choice of three settings, with the first and second setting having 4 outcomes each, and the third setting having 2 outcomes.  

**IndexOf.m** : Returns the index of a given operator in the given list of operators.

**Reduce.m** : Removes from the given list of operators any diplicates, null operators, identity operators. 

**ProductOps.m** : Computes the product of the two given operators. 

**MerminCode.m**: Uses the NPA hierarchy to compute the maximum violation of the Mermin Inequality for three parties. Order of the hierarchy can be adjusted from within the code.

**CHSH_3partycode.m** : Uses the NPA hierarchy to compute bounds on the maximum violation of the CHSH Inequality for two parties. 

