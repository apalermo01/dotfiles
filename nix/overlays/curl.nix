final: prev: 

{
    curl = prev.curl.override {
      gnutlsSupport = true;
    };
}
