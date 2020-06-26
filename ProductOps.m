function [K]= ProductOps(A,B)

%function returns product of 2 operators. 

if or(strcmp(A.status,'O'),strcmp(B.status,'O')) %if either are zero, output zero.
    K.status='O';
    K.ao='';
    K.as='';
    K.bo='';
    K.bs='';
    K.co='';
    K.cs='';




elseif (strcmp(A.status,'I'))
    K=B;


elseif (strcmp(B.status,'I'))
    K=A;

else
    K.status='1';
    K.ao=strcat(A.ao,B.ao);
    K.as=strcat(A.as,B.as);
    K.bo=strcat(A.bo,B.bo);
    K.bs=strcat(A.bs,B.bs);
    K.co=strcat(A.co,B.co);
    K.cs=strcat(A.cs,B.cs);
    K=CheckO(K);
end



    
    
    
        
    
    
    



