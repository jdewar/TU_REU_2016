% Takes a set of parameters for the function bHandle
%  as well as any arguments you'd like to pass to bHandle
% Returns the jacobian: pj/qi part qi/ part pj = S
function [jac, Qnames] = sens_analysis(params, bHandle, varargin)

Pnames = fieldnames(params);
Plen  = length(Pnames);
for i = Plen:-1:1
    init_x0(i) = params.(Pnames{i});
end
% calculate baseline point
y0 = bHandle(params, varargin{:});
% get names
Qnames = fieldnames(y0);
Qlen  = length(Qnames);

jac = NaN(length(y0), Plen);

factor = .001;
% get .1% of initial parameters
delta_x0 = abs(init_x0 * factor);

% fudge number if delta is 0
delta_x0(delta_x0==0) = factor * .01;

for i = 1:Plen
    xi = params;
    pn = Pnames{i};
    % basic centered difference approximation of Jacobian
    xi.(pn) = init_x0(i) - delta_x0(i);
    yLo = bHandle(xi, varargin{:});
    
    xi.(pn) = init_x0(i) + delta_x0(i);
    yHi = bHandle(xi, varargin{:});
    
    for j = 1:Qlen
        qn = Qnames{j};
        % Calculate partial
        part_yj_xi = (yHi.(qn) - yLo.(qn)) / (2 * delta_x0(i));
        
        % FIXME, Do better than max(eps, X) at check for and deal with 0
        part_yj_xi = part_yj_xi * init_x0(i) / max(eps, y0.(qn));

        jac(j,i) = part_yj_xi;
    end
end

end