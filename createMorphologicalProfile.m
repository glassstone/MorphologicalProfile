function [ mp ] = createMorphologicalProfile( im, profiles )
%CREATEMORPHOLOGICALPROFILE create Morphological profile for the input
%image
%
%Syntax:
%     mp = createMorphologicalProfile( im, profiles )
%     
%Description:
%     [ mp ] = createMorphologicalProfile( im, profiles ) create 
%     morphological profile for the input image base on the input parameter profiles.
%     profiles is a cell of structure containing the profile structure information
%     profile.se = 'square' e.g. structure element type
%     profile.operation = 'erode' e.g. profile.operation = 'erode'
%     profile.range = { {3,4}, {4,5} {5,8} } e.g. profile.range = 5:2:9

CH = size(im, 3); % number of channels of image
profile_total_length =0;

for i=1:length(profiles)
    profile_total_length = profile_total_length + length(profiles{i}.range);
end

mp = zeros(size(im,1), size(im,2), CH*profile_total_length );
mp_ch = 1;


for k=1:CH %loop through each channel
    for p = 1:length(profiles) % loop through each profiles op type
        for idx = 1:length(profiles{p}.range) %loop through each profile size
            str_arg = profiles{p}.range{idx}; %get the size of strel using the index
            se = strel(profiles{p}.se, str_arg{:});
            
            
            %mp_ch
            eval([ 'op = @' profiles{p}.operation ';'] );
            mp(:,:, mp_ch) = op(im(:,:,k), se);            
            figure(1), imagesc(mp(:,:,mp_ch)), colormap('gray'), axis image;
            mp_ch = mp_ch + 1;
            
        end %end loop range
    end %end loop profile op type
end %end loop channel


end

