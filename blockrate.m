% blocking rate
function B=blockrate(p,m)       
    B=1;                       
    for k=1:m
       B=((p*B)/k)/(1+p*B/k); 
    end
end