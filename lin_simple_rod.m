function [ temp_array ]  =  lin_simple_rod ( num, TL, TR )
%
%DESCRIPTION
%    Determine the temperature as a function of position for a heated rod.
%
%ARGUMENTS
%
%    num                        is the number of pieces into which
%                                  the rod is divided for numerical
%                                  calculations
%
%    TL                         is the temperature of the left end
%                                  (units are Kelvin)
%
%    TR                         is the temperature of the right end
%                                  (units are Kelvin)
%
%RETURNS
%
%    temp_array                 is a 1-by-num maxtrix of 
%                                  temperatures, one per piece of rod
%                                  (units are Kelvin)
%AUTHOR
%    Kevin Granger <kmg2728@rit.edu>
%    2013-01-16

%{
Additional Documentation:

MATH

    This program attempts to solve the partial differential equation
    d^2 T / dx^2 = 0 through linear algebra. We create our equations
    holding unknowns using the "second difference" of each of the pieces
    of the rod.

    These equations are related to the only two unknown values we have, TL
    and TR.

%}




% Check starting values :
if TL < 0 || TR < 0
    error('Temperatures are given in Kelvin, and as such must be above absolute zero.')
elseif num < 1 || rem(num,1) ~= 0
    error('You must give a positive, nonzero, integer number of pieces to break the rod into.')
end


% Create the equation matrix. It will always be diagonal, with a -2 on the
% piece in question, and 1's on the adjacent pieces (unless it's an edge
% piece, in which case the temperature sources are in the "answer" column
% vector "B"
A = diag((ones(1,num)*-2)) + diag(ones(1,(num-1)),1) + diag(ones(1,(num-1)),-1);

% Populate the "answer" column vector.
B = [-TL zeros(1,num-2) -TR]';

% Perform the matrix divison.
temp_array = (A\B)';
