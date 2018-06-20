solX = [];
solY = [];
condx = -1/3;
condy = 1;
time = 0;
jump = 2;
%dt = jump/100;
k = 0;
timeJ1 = 0;
timeJ2 = 0;
while k < 4
    if ~mod(k,2)
        a = 0;
        b = 1;
        c = -1;
        d = -1;
    else
        a = 0;
        b = 1;
        c = -1 - 3 * 36,512;
        d = -1 - 36,512;
    end
    syms x(t) y(t);
    ode1 = diff(x) == a*x + b*y;
    ode2 = diff(y) == c*x + d*y;
    odes = [ode1; ode2];
    S = dsolve(odes);
    xSol(t) = S.x;
    ySol(t) = S.y;
    [xSol(t), ySol(t)] = dsolve(odes);
    cond1 = x(time) == condx;
    cond2 = y(time) == condy;
    conds = [cond1; cond2];
    [xSol(t), ySol(t)] = dsolve(odes,conds);
    if k < 2
        if ~mod(k,2)
            eqns = 0 == ySol(t);
            timeJ = solve(eqns, t);
            timeJ1 = timeJ - time;
        else
            eqns = -3*xSol(t) == ySol(t);
            timeJ = solve(eqns, t);
            timeJ2 = timeJ - time;
        end
    end
    if ~mod(k,2)
        timeJ = timeJ1;
    else
        timeJ = timeJ2;
    end
    dt = timeJ/100;
    t = time : dt : time + timeJ;
    solX = [solX, xSol(t)];
    solY = [solY, ySol(t)];
    time = time + timeJ;
    condx = xSol(time);
    condy = ySol(time);
    k = k + 1;
end
plot(solX,solY);
