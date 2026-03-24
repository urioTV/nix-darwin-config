{ self, inputs, ... }:
{
  flake.homeModules.ai =
    { config, pkgs, ... }:
    let
      githubMcpWrapper = pkgs.writeShellScript "github-mcp-wrapper" ''
        export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ${config.sops.secrets.github_token.path})"
        exec ${pkgs.github-mcp-server}/bin/github-mcp-server stdio
      '';

      notionMcpWrapper = pkgs.writeShellScript "notion-mcp-wrapper" ''
        export NOTION_TOKEN="$(cat ${config.sops.secrets.notion_api_key.path})"
        exec ${pkgs.bun}/bin/bunx -y @notionhq/notion-mcp-server
      '';
    in
    {
      imports = [
        self.homeModules.ai-gemini-cli
        self.homeModules.ai-opencode
        self.homeModules.ai-opencode-providers
        self.homeModules.ai-opencode-oh-my-opencode-slim
        self.homeModules.ai-opencode-skills-import
      ];

      programs.mcp = {
        enable = true;
        servers = {
          nixos = {
            command = "nix";
            args = [
              "run"
              "github:utensils/mcp-nixos"
              "--"
            ];
          };
          context7 = {
            type = "remote";
            url = "https://mcp.context7.com/mcp";
            # headers = {
            #   "CONTEXT7_API_KEY" = "{file:${config.sops.secrets.context7_api_key.path}}";
            # };
          };
          github = {
            command = "${githubMcpWrapper}";
          };
          websearch = {
            type = "remote";
            url = "https://mcp.exa.ai/mcp?tools=web_search_exa";
          };
          grep_app = {
            type = "remote";
            url = "https://mcp.grep.app";
          };
          notion = {
            command = "${notionMcpWrapper}";
          };
        };
      };
    };
}
