function F = Fn(A)
F.times = @(x) F_times(x,A);
F.trans = @(y) F_trans(y,A);

    function y = F_times(x,A)
        y = A*x;
    end

    function x = F_trans(y,A)
        x = (y'*A)';
    end
end