with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    opentofu
    tflint
    git
    nodejs
    yarn
  ];
}
