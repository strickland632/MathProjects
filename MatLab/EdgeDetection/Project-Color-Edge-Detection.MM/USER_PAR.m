global beta Dt sigma delta nmax id_smooth id_grad level
%--------------------------------------------------

%============================================
%== Parameters for Step 1: Noise Reduction
%============================================
id_smooth = 1;  %choices for denoising
delta = 0.0; beta = 0.05; Dt = 0.25; nmax = 5;   %when id_smooth=1
sigma = 2.5;                                     %when id_smooth=2
    DENS = {'Reverse-Trans-Weight','Gaussian'};

%============================================
%== Parameters for Step 2: Grad Calculation
%============================================
id_grad = 1;   %choices for grad
    GRAD = {'Structure-Tensor','Max of RGB-Grad','L2-norm of RGB-Grad'};

level = 4;
%--------------------------------------------------
idata = 1; 
DATA = { '/Users/sarahstrickland/Documents/Project-Color-Edge-Detection.MM/DATA/catty.jpeg' '/Users/sarahstrickland/Documents/Project-Color-Edge-Detection.MM/DATA/synthetic-Checkerboard.png' };
