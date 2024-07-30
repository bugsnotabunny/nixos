{ username, usernameFull, ... }:
{
	# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dmalakhov = {
    isNormalUser = true;
    description = "Dmitry Malakhov";
    extraGroups = [ "audio" "docker" "networkmanager" "wheel" ];
  };
}
