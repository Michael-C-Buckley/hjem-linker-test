# Add persisted storage
{...}: {
  microvm.volumes = [
    {
      mountPoint = "/root";
      image = "persist.img";
      size = 256;
    }
  ];
}
