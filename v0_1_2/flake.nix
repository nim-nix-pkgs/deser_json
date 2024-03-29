{
  description = ''JSON-Binding for deser'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-deser_json-v0_1_2.flake = false;
  inputs.src-deser_json-v0_1_2.ref   = "refs/tags/v0.1.2";
  inputs.src-deser_json-v0_1_2.owner = "gabbhack";
  inputs.src-deser_json-v0_1_2.repo  = "deser_json";
  inputs.src-deser_json-v0_1_2.type  = "github";
  
  inputs."deser".owner = "nim-nix-pkgs";
  inputs."deser".ref   = "master";
  inputs."deser".repo  = "deser";
  inputs."deser".dir   = "v0_2_1";
  inputs."deser".type  = "github";
  inputs."deser".inputs.nixpkgs.follows = "nixpkgs";
  inputs."deser".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."jsony".owner = "nim-nix-pkgs";
  inputs."jsony".ref   = "master";
  inputs."jsony".repo  = "jsony";
  inputs."jsony".dir   = "1_1_3";
  inputs."jsony".type  = "github";
  inputs."jsony".inputs.nixpkgs.follows = "nixpkgs";
  inputs."jsony".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-deser_json-v0_1_2"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-deser_json-v0_1_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}