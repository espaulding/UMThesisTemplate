function x = saveFig(nameOfFile)
%saveFig(nameOfFile)

file_dir = '\figures';
jpg_dir = '\jpg';
jpg_file = strcat(nameOfFile, '.jpg');
eps_dir = '\eps';
eps_file = strcat(nameOfFile, '.eps');
fig_dir = '\fig';
fig_file = strcat(nameOfFile, '.fig');

handle = get(0, 'CurrentFigure')

cd ..
current_dir = strcat(pwd, file_dir);
disp(sprintf('Root directory: %s', current_dir));




if ~isempty(handle)
    disp(sprintf('Saving %s to .%s ...', fig_file, fig_dir));
    saveas(handle, strcat(current_dir, fig_dir, '\', nameOfFile, '.fig'))

    prev_paperpos = get(handle, 'PaperPosition');
    prev_papersize = get(handle, 'PaperSize');
    prev_units = get(handle, 'Units');

    set(handle, 'Units', 'inches');
    prev_pos = get(handle, 'Position');
    width = prev_pos(3);
    height = prev_pos(4);
    
    
    set(handle, 'PaperSize', [width height]);
    set(handle, 'PaperPosition', [0 0 width height]);
    
    disp(sprintf('Saving %s to .%s (updated save)...', eps_file, eps_dir));
    saveas(handle, strcat(current_dir, eps_dir, '\', nameOfFile, '.eps'), 'epsc2')
    
    
    
    disp(sprintf('Saving %s to .%s ...', jpg_file, jpg_dir));
    print( '-djpeg100', strcat(current_dir, jpg_dir, '\', nameOfFile, '.jpg'))

    
    set(handle, 'Units', prev_units);
    set(handle, 'PaperSize', prev_papersize);
    set(handle, 'PaperPosition', prev_paperpos);
end
 
cd MATLAB