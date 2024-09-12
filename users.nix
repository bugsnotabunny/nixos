{ username, usernameFull, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dmalakhov = {
    isNormalUser = true;
    description = "Dmitry Malakhov";
    extraGroups = [
      "input"
      "audio"
      "docker"
      "networkmanager"
      "wheel"
    ];
  };
}
