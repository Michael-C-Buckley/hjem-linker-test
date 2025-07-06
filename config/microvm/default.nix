_: {
  microvm = {
    hypervisor = "qemu";
    socket = "control.socket";

    # Use the the local host's store
    shares = [
      {
        proto = "9p";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
    ];
  };
}
