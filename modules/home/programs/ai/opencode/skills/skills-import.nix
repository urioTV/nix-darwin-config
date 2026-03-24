# home/programs/ai/skills/skills-import.nix
#
# Each subfolder in this directory maps to ~/.config/opencode/skills/<name>/SKILL.md
# and is available as a skill in opencode.
#
# To add a new skill: create a folder <name>/SKILL.md next to this file.
# Nothing else needs to be changed.
{ lib, ... }:
{
  flake.homeModules.ai-opencode-skills-import =
    { ... }:
    let
      skillsDir = ./.;

      # Collects all subfolders (each is a separate skill)
      skillDirs = lib.filterAttrs (name: type: type == "directory") (builtins.readDir skillsDir);

      # name: "autocommit"  →  key: "opencode/skills/autocommit/SKILL.md"
      toConfigFile = name: _: {
        "opencode/skills/${name}/SKILL.md".source = skillsDir + "/${name}/SKILL.md";
      };

      skillConfigs = lib.mapAttrs toConfigFile skillDirs;
    in
    {
      xdg.configFile = lib.mkMerge (lib.attrValues skillConfigs);
    };
}
