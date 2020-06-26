function Z=Check(X)
%checks if the projects making up X are orthogonal. Also multiplies
%projectors when possible to reduce the length of the operators.

O.status='O';
O.ao='';
O.bo='';
O.co='';
O.as='';
O.bs='';
O.cs='';


%O defines the zero operator%.

i=1;
while(i<length(X.as))
    
    if strcmp(X.as(i),X.as(i+1)) %If measurement setting is same.
        if strcmp(X.ao(i),X.ao(i+1))
            X.as(i+1)=[];
            X.ao(i+1)=[];
            
            continue;
        else
            Z=O;
            return;
        end
    end
    i=i+1; %increment i.
end
%A projectors have been checked. Do the same for B.

i=1;
while(i<length(X.bs))
    
    if strcmp(X.bs(i),X.bs(i+1)) %If measurement setting is same.
        if strcmp(X.bo(i),X.bo(i+1))
            X.bs(i+1)=[];
            X.bo(i+1)=[];
            
            continue;
        else
            Z=O;
            return;
        end
    end
    i=i+1; %increment i.
end
   
i=1;
while(i<length(X.cs))
    
    if strcmp(X.cs(i),X.cs(i+1)) %If measurement setting is same.
        if strcmp(X.co(i),X.co(i+1))
            X.cs(i+1)=[];
            X.co(i+1)=[];
            
            continue;
        else
            Z=O;
            return;
        end
    end
    i=i+1; %increment i.
end
   

   

Z=X;
            
        
            