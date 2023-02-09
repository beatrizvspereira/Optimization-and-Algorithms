function count=alinea_c( u,T )

count=0;
for i=2:T-1
    if norm(u(:,i)-u(:,i-1)) > 10^-4
        count=count+1;
    end
end

end

