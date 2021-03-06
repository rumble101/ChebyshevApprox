# Test file for 4-d Chebyshev polynomials

using ChebyshevApprox

n1 = 10
n2 = 15
n3 = 7
n4 = 16

dom_1 = [2.0, -3.0]
dom_2 = [1.5,  0.5]
dom_3 = [0.5, -0.5]
dom_4 = [-0.66, -1.79]
dom = [dom_1 dom_2 dom_3 dom_4]

nodesr_1 = chebyshev_nodes(n1,dom_1)
nodesr_2 = chebyshev_nodes(n2,dom_2)
nodesr_3 = chebyshev_nodes(n3,dom_3)
nodesr_4 = chebyshev_nodes(n4,dom_4)
nodesv_1 = vertesi_nodes(n1,dom_1)
nodesv_2 = vertesi_nodes(n2,dom_2)
nodesv_3 = vertesi_nodes(n3,dom_3)
nodesv_4 = vertesi_nodes(n4,dom_4)

yr = zeros(n1,n2,n3,n4)
yv = zeros(n1,n2,n3,n4)

for i = 1:n1
  for j = 1:n2
    for k = 1:n3
      for l = 1:n4

        yr[i,j,k,l] = (nodesr_1[i]+4.0)^0.5+nodesr_1[i]*sqrt(nodesr_2[j])+exp(nodesr_3[k])*nodesr_4[l]
        yv[i,j,k,l] = (nodesv_1[i]+4.0)^0.5+nodesv_1[i]*sqrt(nodesv_2[j])+exp(nodesv_3[k])*nodesv_4[l]

      end
    end
  end
end

order_tensor = [7, 6, 6, 6]
order_complete = 6

wr_tensor   = chebyshev_weights(yr,[nodesr_1,nodesr_2,nodesr_3,nodesr_4],order_tensor,dom)
wr_complete = chebyshev_weights(yr,(nodesr_1,nodesr_2,nodesr_3,nodesr_4),order_complete,dom)
wv_tensor   = chebyshev_weights_vertesi(yv,(nodesv_1,nodesv_2,nodesv_3,nodesv_4),order_tensor,dom)
wv_complete = chebyshev_weights_vertesi(yv,(nodesv_1,nodesv_2,nodesv_3,nodesv_4),order_complete,dom)

point = [1.748, 0.753, 0.119, -0.947]

yr_tensor    = chebyshev_evaluate(wr_tensor,point,order_tensor,dom)
yr_complete  = chebyshev_evaluate(wr_complete,point,order_complete,dom)
yv_tensor    = chebyshev_evaluate(wv_tensor,point,order_tensor,dom)
yv_complete  = chebyshev_evaluate(wv_complete,point,order_tensor,dom)

y_actual = (point[1]+4.0)^0.5+point[1]*sqrt(point[2])+exp(point[3])*point[4]

println([y_actual yr_tensor yr_complete ye_tensor ye_complete])

yr_grad_tensor      = chebyshev_gradient(wr_tensor,point,order_tensor,dom)
yr_grad_complete    = chebyshev_gradient(wr_complete,point,order_complete,dom)
yr_deriv_tensor_1   = chebyshev_derivative(wr_tensor,point,1,order_tensor,dom)
yr_deriv_complete_1 = chebyshev_derivative(wr_tensor,point,1,order_complete,dom)
yv_grad_tensor      = chebyshev_gradient(wv_tensor,point,order_tensor,dom)
yv_grad_complete    = chebyshev_gradient(wv_complete,point,order_complete,dom)
yv_deriv_tensor_1   = chebyshev_derivative(wv_tensor,point,1,order_tensor,dom)
yv_deriv_complete_1 = chebyshev_derivative(wv_complete,point,1,order_complete,dom)

println(yr_grad_tensor, yr_grad_complete, yr_deriv_tensor_1, yr_deriv_complete_1)
println(yv_grad_tensor, yv_grad_complete, yv_deriv_tensor_1, yv_deriv_complete_1)
