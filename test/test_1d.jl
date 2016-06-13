# Test file for 1-d Chebyshev polynomials

using ChebyshevApprox

n = 10
range = [2.0,-3.0]

nodes = chebyshev_nodes(n,range)

y = zeros(n)

for i = 1:n

  y[i] = (nodes[i]+4.0)^0.5

end

order = 5

w_tensor   = chebyshev_weights(y,nodes,[order],range)
w_complete = chebyshev_weights(y,nodes,order,range)

println(maxabs(w_tensor - w_complete)) # We run this in the 1-d case because the tensor polynomial and the complete polynomial should coincide

point = [1.748]

y_chebyshev_tensor   = chebyshev_evaluate(w_tensor,point,[order],range)
y_chebyshev_complete = chebyshev_evaluate(w_complete,point,order,range)
y_clenshaw_tensor    = clenshaw_evaluate(w_tensor,point,[order],range)
y_clenshaw_complete  = clenshaw_evaluate(w_complete,point,order,range)

y_actual = (point+4.0).^0.5

println([y_actual y_chebyshev_tensor y_chebyshev_complete y_clenshaw_tensor y_clenshaw_complete])