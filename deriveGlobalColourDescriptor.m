%%
% Derive a 3 dimensional image descriptor, based on the average RGB
% component values of the image.
%
function dsc = deriveGlobalColourDescriptor(img)

    red = img(:,:,1);
    red = reshape(red, 1, []);
    average_red = mean(red);
    
    green = img(:,:,2);
    green = reshape(green, 1, []);
    average_green = mean(green);
    
    blue = img(:,:,3);
    blue = reshape(blue, 1, []);
    average_blue = mean(blue);
    
    dsc = [average_red, average_green, average_blue];    

return;
