{ config, lib, pkgs, ... }:

{
  # Used to allow Geshin Impact to run on linux
  networking.extraHosts = ''
    0.0.0.0 log-upload-os.mihoyo.com
    0.0.0.0 overseauspider.yuanshen.com
    0.0.0.0 prd-lender.cdp.internal.unity3d.com
    0.0.0.0 thind-prd-knob.data.ie.unity3d.com
    0.0.0.0 thind-gke-usc.prd.data.corp.unity3d.com
    0.0.0.0 cdp.cloud.unity3d.com
    0.0.0.0 remote-config-proxy-prd.uca.cloud.unity3d.com
  '';
}
