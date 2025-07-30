hardware.opengl = {
  enable = true;
  driSupport = true;        # This covers the main drivers
  driSupport32Bit = true;   # This covers lib32-mesa equivalent
  
  extraPackages = with pkgs; [
    mesa.drivers            # mesa + vulkan-radeon equivalent
    vulkan-loader          # vulkan-icd-loader equivalent
  ];
  
  extraPackages32 = with pkgs.pkgsi686Linux; [
    mesa.drivers           # lib32-vulkan-radeon equivalent
    vulkan-loader         # lib32-vulkan-icd-loader equivalent
  ];
};

boot.kernelParams = [
  "amdgpu.dc=1"     # Keep this - enables display core, generally good
  "amdgpu.psr=0"    # Keep this - PSR causes hangs on many mobile GPUs
];

extraPackages = with pkgs; [
  mesa.drivers
  mesa.opencl     # rusticl - often more stable than ROCm on mobile
];
