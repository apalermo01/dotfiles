{ pkgs, ... }: 


{
  environment.systemPackages = with pkgs; [
    code-cursor
    code-cursor-fhs
    cmatrix
  ];
}
