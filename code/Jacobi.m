% Jacobi Verfahren
%  [x, ea, iter] = Jacobi(A,b): Jacoobi Verfahren ohne Relaxation
% Eingabe: 
%   A = Koeffizientenmatrix (quadratisch!)
%   b = rechte Seite
%   es = Abbruchkriterium (0.00001% by default)
%   maxit = Anzahl der max. erlaubten Iterationen (50 by default)
% Ausgabe: 
%   x = Lösungsvektor
%   ea = geschätzter Fehler
%   iter = Anzahl der durchgeführten Iterationen
function [x, ea, iter] = Jacobi(A, b, es, maxit)
    
    %Checke, ob eine quadratische Matrix gegeben ist:
    dims = size(A);
    if dims(1) ~= dims(2); error("A ist keine quadratische Matrix!"); end;
    n = dims(1);

    %checke, ob b die gleiche Länge hat:
    if length(b) ~= n; error("b hat die falsche Länge!"); end;

    %Checke, ob die Matrix diagonaldominant ist:
    isDominant = true;
    for i = [1:n]; isDominant = sum(A(i,1:n)) < 2 * A(i,i); if ~isDominant; break; end; end;
    if ~isDominant; warning("Matrix ist nicht diagonaldominant!"); end;
    
    %Setze parameter auf Default, wenn nicht stimmend:
    if es <= 0; es = 1e-6; end;
    if maxit <= 0; maxit = 50; end;

    iter=0;
    x=zeros(n,1);
    x_neu=zeros(n,1);
    ea=100 * ones(n,1);
    while iter < maxit && max(ea) >= es
        for i = [1:n]
            x_neu(i) = (b(i) - A(i,1:n) * x)/A(i,i) + x(i);
            ea(i) = abs((x_neu(i) - x(i))/x_neu(i)) * 100;
        end
        x = x_neu;

        iter = iter+1;        
    end
    return;
end 