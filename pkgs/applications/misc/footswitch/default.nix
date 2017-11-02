{ stdenv, hidapi, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "footswitch";

  src = fetchFromGitHub {
    owner = "rgerganov";
    repo = "footswitch";
    rev = "7cb0a9333a150c27c7e4746ee827765d244e567a";
    sha256 = "0mg1vr4a9vls5y435w7wdnr1vb5059gy60lvrdfjgzhd2wwf47iw";
  };

  buildCommand = ''
    mkdir -p $out/bin
    cd $src
    $CC footswitch.c common.c debug.c \
      -o $out/bin/footswitch \
      -I${hidapi}/include/hidapi \
      -lhidapi-libusb -L${hidapi}/lib
  '';

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "Command line tool for programming PCSensor (Microdia) foot switches";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
