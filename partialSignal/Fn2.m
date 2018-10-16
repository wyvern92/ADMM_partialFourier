function F = Fn2(A)
F.times = @(x) F_times(x,A);
F.trans = @(y) F_trans(y,A);

    function y = F_times(x,A)
        y = A*x*(A.');
    end

    function x = F_trans(y,A)
        % write A'y
        x = 0;
    end
end