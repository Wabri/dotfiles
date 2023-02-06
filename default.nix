with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    pkgs.go
  ];
}
