{
  lib,
  noughtyLib,
  ...
}:
lib.mkIf (noughtyLib.isUser [ "nate" ]) {
  users.users.nate = {
    uid = 1000;
    description = "Nate Felt";
    # mkpasswd -m sha-512
    hashedPassword = "$6$VBR/NDUtVw4l0XzB$UHjs2mAnkt/6.tLxfQUFre43XIgZpyPI2Db7jxUQoRzug/sBq.qws2yII9sTz/cELRcuvCOScD4jKLkFr7w68.";
  };
}
