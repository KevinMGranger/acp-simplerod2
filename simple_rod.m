function [ temp_array ]  =  simple_rod ( num, TL, TR )
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
%    2013-01-08

%{
Additional Documentation:

MATH

    This program attempts to solve the partial differential equation
    d^2 T / dx^2 = 0 iteratively. It does this by breaking the length of X
    into a given amount of small pieces, and averaging the value of each
    piece between the pieces that surround it. The reasoning behind the
    average was determined by expressing the "second difference" of each of
    the temperature values in an equation, and rearranging to determine
    what the value of the current piece is when the second difference is 0.

    In other words, for a piece i compared to the piece on the left (L) and
    a piece on the right (R), the second difference between the values
    should be zero:

        (TR - Ti) - (Ti - TL) = 0

    or when rearranged:

        Ti = (TR + TL) / 2

    hence the average.

    New values are computed until the maximum fractional change for any
    piece is less than the determined convergence factor, which is 0.01
    divided by the number of pieces the rod is broken into.


VARIABLE NAMING
    
    See the comments near where each variable is declared / invoked the
    first time.

%}




% Check starting values :
if TL < 0 || TR < 0
    error('Temperatures are given in Kelvin, and as such must be above absolute zero.')
elseif num < 1 || rem(num,1) ~= 0
    error('You must give a positive, nonzero, integer number of pieces to break the rod into.')
end

% Populate variables :

% These are the temperature arrays.
% Since the averaging for each piece is done using the old values, two
% arrays are necessary.
old_array = [ TL (ones(1,num) * mean([TL TR])) TR];
temp_array = old_array;

% This is the fractional change in temperature.
% So the while loop runs at least once, make the fractional error larger
% than any possible convergence factor.
frac = 1;

% This is the convergence factor.
% The data needs to be more accurate as the rod is broken into more pieces.
convergence = 0.01 / num;

% Keep iterating until the fractional change is less than our determined
% convergence factor.
while frac > convergence
    
    % For each piece of rod, calculate the average temperature between the
    % two other pieces.
    % Since the array also includes the two non-changing values at the end,
    % start at position 2 and go until we've reached the end of the rod
    % (num+1 since it's 1-indexed, and we're starting at 2)
    for i=2:num+1
        
        % The old temperatures are used so that values can't blow up, in
        % certain cases.
		temp_array(i) = (old_array(i-1) + old_array(i+1)) / 2;
    end
    
    % We care about the maximum fractional change for any piece. It doesn't
    % matter if the one on the end isn't changing much, if we're still
    % calculating the center pieces, keep going!
	frac = max(abs(temp_array - old_array) ./ old_array);
    
    % What's new is old. Take our new values and get ready to use them for
    % next time, if there is a next time.
    old_array = temp_array;
end

% Shave off the temperatures of the left and right ends, giving back only
% the temperatures of the pieces of the rod.
temp_array = temp_array(2:num+1);