functionString = input("Give me a function! Example: x^2+2*x+3. f(x) = ", 's'); %'(x^2+2*x+3)'
f = inline(functionString);

a = input("a = ");
b = input("b = ");
length = b-a;

drawFunction(f, a - length*0.2, b + length*0.2, a, b)

calculateMethod = 'square';%input("How to calculate integral for the funciton? 'square, trapeze': ", 's');
stopMethod = 'c';%input("Use step count or epsilon? (c/e): ", 's');

if calculateMethod == "square"
    if stopMethod == 'c'
        n = input("Give me the sample count: ");
        method = input("What sqare method do you want to use? (start/stop/center): ", 's');
        squareIntegral(a, b, f, n, method);
    end
else 
    666
end


function drawFunction(f, a, b, fromA, fromB)
    drawH = (b - a) / 100;
    x = a:drawH:b;
    y = getY(f, x);
    hold on
    mainArea = area(x, y);
    alpha(mainArea,.1)
    xline(0);
    yline(0);
    xline(fromA, '--r');
    xline(fromB, '--r');
end


function integral = trapezeIntegral(a, b, y, useSampleCount)
    realSampleLength = size(y, 2);
    sampleLength = min(realSampleLength, useSampleCount);

    h = (b-a)/sampleLength;

    indexStep = realSampleLength / (sampleLength-1);

    realIntegral = 0.5;
    integral = 0;
    for i = 2:sampleLength
        integral = integral + ((y(sampleIndex)) + y(nextSampleIndex)) / 2 / h;
    end
    
end
function [integral, integralShape] = squareIntegral(a, b, f, n, method)
    h = (b-a)/n;
    x = a:h:b;
    y = getY(f, x);
    integral = 0;
    integralShape = 0;
    sum = 0;
    for i = 1:size(x, 2)
        if method == "start"
            [sum, integralShape] = squareIntegralStepStart(x, y, i, h, sum, integralShape);
        elseif method == "center"
            [sum, integralShape] = squareIntegralStepCenter(x, y, i, h, sum, integralShape);
        elseif method == "end"
            [sum, integralShape] = squareIntegralStepEnd(x, y, i, h, sum, integralShape);
        else
            input("UKNOWN METHOD")
        end
    end
    integral = sum
    integralShape
    integralArea = area(integralShape(1,:), integralShape(2,:));
    alpha(integralArea,.2)
end

function [sum, integralPoints] = squareIntegralStepStart(x, y, i, h, sum, integralPoints)
    sum = sum + y(i)*h;
    integralPoints(1, i*2-1) = x(i);
    integralPoints(2, i*2-1) = y(i);
    integralPoints(1, i*2) = x(i);
    integralPoints(2, i*2) = y(min([i+1 size(x, 2)]));
end

function [sum, integralPoints] = squareIntegralStepEnd(x, y, i, h, sum, integralPoints)
    if i > 1
        sum = sum + y(i-1)*h;
    end
    integralPoints(1, i*2-1) = x(i);
    integralPoints(2, i*2-1) = y(max([i-1 1]));
    integralPoints(1, i*2) = x(i);
    integralPoints(2, i*2) = y(i);
end

function [sum, integralPoints] = squareIntegralStepCenter(x, y, i, h, sum, integralPoints)
    if i > 1
        sum = sum + (y(i-1) + y(i))*h/2;
    end
    lineY0 = (y(max([i-1 1])) + y(max([i 1])))/2;
    lineY1 = (y(min([i size(x, 2)])) + y(min([i+1 size(x, 2)])))/2;
    integralPoints(1, i*2-1) = x(i);
    integralPoints(2, i*2-1) = lineY0;
    integralPoints(1, i*2) = x(i);
    integralPoints(2, i*2) = lineY1;
end


function y = getY(f, x)
    y = 0;
    length = size(x, 2);
    for i = 1:length
        y(i) = f(x(i));
    end
end