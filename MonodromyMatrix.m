function [MonMat,Xdata]=MonodromyMatrix(X0,period)

    tspan=[0 period];
    XMon0 = [X0' ; reshape(eye(6),36,1) ];%M0是单位矩阵，6x6
    opt = odeset('reltol',1e-12,'abstol',1e-14);%
    [t_seq,y_seq] = ode45(@FundamentalMatrixDyn,tspan,XMon0, opt);%
        
    MonMat = reshape(y_seq(end,7:42),[6 6]);
    Xdata = y_seq(:,1:6);
     
	%此处X为42x1的矩阵，前6个元素代表状态量X，后面的36个元素代表状态转移矩阵M;
    function dX  = FundamentalMatrixDyn (t,X)
        Y = X(1:6);
        phi = reshape(X(7:42),[6 6]);
        
        r = norm(Y(1:3));
        beta =33.6;
        
        A1=zeros(3,3);A2=eye(3);
        A3=[-1/r^3+3 0 0;0 -1/r^3 0;0 0 -1/r^3-1];
        A4 = [0 2 0;-2 0 0;0 0 0];
        A = [A1 A2;
             A3 A4];
        B = [0 0 0 beta 0 0]'; 
        
		%注意此处是A(X)相对于X求偏导
        A33=[3/r^5*Y(1)^2-1/r^3+3 3/r^5*Y(1)*Y(2) 3/r^5*Y(1)*Y(3);
            3/r^5*Y(1)*Y(2) 3/r^5*Y(2)^2-1/r^3 3/r^5*Y(3)*Y(2);
            3/r^5*Y(3)*Y(1) 3/r^5*Y(3)*Y(2) 3/r^5*Y(3)^2-1/r^3-1];
        A_phi = [A1 A2;
             A33 A4];
        dX = zeros(42,1);
        dX(1:6) = A*Y+B;%对应于DX = A(X) + beta
        dphi = A_phi*phi;%对应于M' = A'(X)*M
        dX(7:42) = reshape(dphi,36,1);
    end
end