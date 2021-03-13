%%% erlangB function%%%
function load_totoal=erlangB(m,br)
    p_up=500;
    p_l=0.0;
    p_mid=(p_up+p_l)/2;        
    temp=blockrate(p_mid,m);
    
    while(p_up-p_l>0.0001)     
      
            if(temp>br)
                p_up=p_mid;
            else
                p_l=p_mid;
            end
             p_mid=(p_up+p_l)/2;
             temp=blockrate(p_mid,m);

    end
   load_totoal=p_mid;           
end