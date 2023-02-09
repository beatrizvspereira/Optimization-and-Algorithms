function  m_dev = alinea_d( x,w,K,tau )

m_dev=0;
for i=1:K
        m_dev = m_dev + norm(x(1:2,tau(i))-w(:,i));
end

m_dev=m_dev/K;

end

