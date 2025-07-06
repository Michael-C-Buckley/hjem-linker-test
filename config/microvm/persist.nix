# Add persisted storage
# These tiny persistent volumes are only for testing non-impermenance setups
# as microvm.nix mimics impermenance
_: {
  microvm.volumes = [
    {
      mountPoint = "/root";
      image = "rootPersist.img";
      size = 1;
    }
    {
      mountPoint = "/home/user";
      image = "userPersist.img";
      size = 1;
    }
  ];
}
