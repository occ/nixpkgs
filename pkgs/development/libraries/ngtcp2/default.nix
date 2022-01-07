{ lib, stdenv, fetchFromGitHub
, autoreconfHook, pkg-config
, cunit, file
, jemalloc, libev, nghttp3, quictls
}:

stdenv.mkDerivation rec {
  pname = "ngtcp2";
  version = "unstable-2021-12-19";

  src = fetchFromGitHub {
    owner = "ngtcp2";
    repo = pname;
    rev = "20c710a8789ec910455ae4e588c72e9e39f8cec9";
    sha256 = "sha256-uBmD26EYT8zxmHD5FuHCbEuTdWxer/3uhRp8PhUT87M=";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config cunit file ];
  buildInputs = [ jemalloc libev nghttp3 quictls ];

  preConfigure = ''
    substituteInPlace ./configure --replace /usr/bin/file ${file}/bin/file
  '';

  outputs = [ "out" "dev" ];

  doCheck = true;

  meta = with lib; {
    homepage = "https://github.com/ngtcp2/ngtcp2";
    description = "ngtcp2 project is an effort to implement QUIC protocol which is now being discussed in IETF QUICWG for its standardization.";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ izorkin ];
  };
}
