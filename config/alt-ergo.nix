{ stdenv, autoreconfHook, fetchFromGitHub, fetchpatch, lib, which, ocamlPackages }:

let ocplib-simplex =

  let
    inherit (ocamlPackages) ocaml findlib;
    pname = "ocplib-simplex";
    version = "0.4";
  in

  stdenv.mkDerivation {
    name = "ocaml${ocaml.version}-${pname}-${version}";

    src = fetchFromGitHub {
      owner = "OCamlPro-Iguernlala";
      repo = pname;
      rev = "v${version}";
      sha256 = "09niyidrjzrj8g1qwx4wgsdf5m6cwrnzg7zsgala36jliic4di60";
    };

    preBuild = ''
      export HOME=$PWD
    '';

    nativeBuildInputs = [ autoreconfHook ocaml findlib ];

    strictDeps = true;

    installFlags = [ "LIBDIR=$(OCAMLFIND_DESTDIR)" ];

    createFindlibDestdir = true;

  };
in

let
  pname = "alt-ergo";
  version = "2.4.3";

  configureScript = "ocaml unix.cma configure.ml";
  preBuild = ''
      export HOME=$PWD
    '';

  src = fetchFromGitHub {
    owner = "OCamlPro";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-2XARGr8rLiPMOM0rBBoRv5tZvKYtkLkJctGqLYkMe7Q=";
  };
in

let alt-ergo-lib = ocamlPackages.buildDunePackage rec {
  pname = "alt-ergo-lib";
  inherit version src configureScript;
  configureFlags = [ pname ];
  nativeBuildInputs = [ which ];
   preBuild = ''
      export HOME=$PWD
    '';
  buildInputs = with ocamlPackages; [ dune-configurator ];
  propagatedBuildInputs = with ocamlPackages; [ dune-build-info num ocplib-simplex seq stdlib-shims zarith ];
}; in

let alt-ergo-parsers = ocamlPackages.buildDunePackage rec {
  pname = "alt-ergo-parsers";
  inherit version src configureScript;
  configureFlags = [ pname ];
   preBuild = ''
      export HOME=$PWD
    '';
  nativeBuildInputs = [ which ocamlPackages.menhir ];
  propagatedBuildInputs = [ alt-ergo-lib ] ++ (with ocamlPackages; [ camlzip psmt2-frontend ]);
}; in

ocamlPackages.buildDunePackage {

  inherit pname version src configureScript;

  configureFlags = [ pname ];

  nativeBuildInputs = [ which ocamlPackages.menhir ];
  buildInputs = [ alt-ergo-parsers ocamlPackages.cmdliner ];
 preBuild = ''
      export HOME=$PWD
    '';
  meta = {
    description = "High-performance theorem prover and SMT solver";
    homepage    = "https://alt-ergo.ocamlpro.com/";
    license     = lib.licenses.ocamlpro_nc;
    maintainers = [ lib.maintainers.thoughtpolice ];
  };
}
