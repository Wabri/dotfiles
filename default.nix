with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    pkgs.onefetch
  ];
}
