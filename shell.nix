with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    opentofu
    tflint
    awscli2
    git
    nodejs
    yarn
  ];
}
